import 'package:extension_helpers/extension_helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:nosk/src/logic/auth/logic.dart';
import 'package:nosk/src/route/route.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tinycolor2/tinycolor2.dart';
import 'package:validatorless/validatorless.dart';

class PasswordSecurityPage extends RouteFulWidget {
  const PasswordSecurityPage({super.key});

  static PasswordSecurityPage get route => const PasswordSecurityPage();

  @override
  State<PasswordSecurityPage> createState() => _PasswordSecurityPageState();

  @override
  String path() => '/setting/password-security';

  @override
  String title() => 'Password & Security';
}

class _PasswordSecurityPageState extends State<PasswordSecurityPage> {
  final AuthLogic _authLogic = AuthLogic.to;
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  RxBool isPasswordHidden = true.obs;
  RxBool isNewPasswordHidden = true.obs;
  bool isLoading = false;
  bool editing = false;

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  Future<void> onSubmit() async {
    setState(() {
      isLoading = true;
    });
    try {
      if (_formStateKey.currentState?.validate() ?? false) {
        final user = _authLogic.firebaseAuth.currentUser;
        if (user == null) return;
        await user.reauthenticateWithCredential(
          EmailAuthProvider.credential(
            email: user.email!,
            password: passwordController.text,
          ),
        );
        await user.updatePassword(newPasswordController.text);
        passwordController.clear();
        newPasswordController.clear();
        confirmPasswordController.clear();
        if (mounted) {
          context.toast(
            toastMessage: 'Password changed successfully.',
            type: ToastSnackBarType.success,
          );
        }
      }
    } on FirebaseAuthException catch (error) {
      if (mounted) {
        context.toast(
          toastMessage: error.message ?? error.code,
          type: ToastSnackBarType.danger,
        );
      }
    } catch (error) {
      if (mounted) {
        context.toast(
          toastMessage: 'Error registering account, please try again.',
          type: ToastSnackBarType.danger,
        );
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: context.breakpoint
            .largerOrEqualTo(TABLET)
            .isFalse
            .when(use: BackButton(), elseUse: 0.spacer),
        leadingWidth:
            context.breakpoint.largerOrEqualTo(TABLET).isTrue.whenOnly(use: 0),
        title: Text(
          'Password & Security',
          style: context.textTheme.headlineMedium,
        ),
      ),
      body: Form(
          key: _formStateKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Change your password.',
                style: context.textTheme.bodySmall,
              ),
              20.cl(10, 40).hSpacer,
              Text(
                'Current Password',
                style: context.textTheme.headlineSmall,
              ).align(
                alignment: Alignment.centerLeft,
              ),
              10.cl(10, 20).hSpacer,
              Obx(
                () => TextFormField(
                  controller: passwordController,
                  style: context.textTheme.bodySmall,
                  obscureText: isPasswordHidden.isTrue,
                  enabled: isLoading.isFalse,
                  autofillHints: <String>[AutofillHints.password],
                  keyboardType: TextInputType.visiblePassword,
                  onFieldSubmitted: (_) => onSubmit(),
                  textInputAction: TextInputAction.done,
                  validator: Validatorless.multiple([
                    Validatorless.required("This field can't be empty"),
                    Validatorless.min(
                      6,
                      'Password must be more than 6 characters long.',
                    ),
                    Validatorless.regex(
                      RegExp('[0-9]'),
                      'Password should contain at least one number.',
                    ),
                    Validatorless.regex(
                      RegExp('[A-Z]'),
                      'Password should contain at least one uppercase.',
                    ),
                    Validatorless.regex(
                      RegExp('[a-z]'),
                      'Password should contain at least one lowercase.',
                    ),
                  ]),
                  decoration: InputDecoration(
                    hintText: 'Enter a your current password.',
                    prefixIcon: HeroIcon(
                      HeroIcons.lockClosed,
                      style: HeroIconStyle.outline,
                    ),
                    suffixIcon: IconButton(
                      onPressed: isPasswordHidden.toggle,
                      style: ButtonStyle(
                        shape: RoundedRectangleBorder(
                          borderRadius: 40.cl(40, 80).rc.brAll,
                        ).all,
                      ),
                      icon: isPasswordHidden.isTrue.when(
                        use: HeroIcon(HeroIcons.eye),
                        elseUse: HeroIcon(HeroIcons.eyeSlash),
                      ),
                    ),
                  ),
                ),
              ),
              10.cl(10, 20).hSpacer,
              Text(
                'New Password',
                style: context.textTheme.headlineSmall,
              ).align(
                alignment: Alignment.centerLeft,
              ),
              10.cl(10, 20).hSpacer,
              Obx(
                () => TextFormField(
                  controller: newPasswordController,
                  style: context.textTheme.bodySmall,
                  obscureText: isNewPasswordHidden.isTrue,
                  enabled: isLoading.isFalse,
                  autofillHints: <String>[AutofillHints.newPassword],
                  keyboardType: TextInputType.visiblePassword,
                  onFieldSubmitted: (_) => onSubmit(),
                  textInputAction: TextInputAction.done,
                  validator: Validatorless.multiple([
                    Validatorless.required("This field can't be empty"),
                    Validatorless.min(
                      6,
                      'Password must be more than 6 characters long.',
                    ),
                    Validatorless.regex(
                      RegExp('[0-9]'),
                      'Password should contain at least one number.',
                    ),
                    Validatorless.regex(
                      RegExp('[A-Z]'),
                      'Password should contain at least one uppercase.',
                    ),
                    Validatorless.regex(
                      RegExp('[a-z]'),
                      'Password should contain at least one lowercase.',
                    ),
                  ]),
                  decoration: InputDecoration(
                    hintText: 'Enter a new password.',
                    prefixIcon: HeroIcon(
                      HeroIcons.lockClosed,
                      style: HeroIconStyle.outline,
                    ),
                    suffixIcon: IconButton(
                      onPressed: isNewPasswordHidden.toggle,
                      style: ButtonStyle(
                        shape: RoundedRectangleBorder(
                          borderRadius: 40.cl(40, 80).rc.brAll,
                        ).all,
                      ),
                      icon: isNewPasswordHidden.isTrue.when(
                        use: HeroIcon(HeroIcons.eye),
                        elseUse: HeroIcon(HeroIcons.eyeSlash),
                      ),
                    ),
                  ),
                ),
              ),
              10.cl(10, 20).hSpacer,
              Text(
                'Confirm Password',
                style: context.textTheme.headlineSmall,
              ).align(
                alignment: Alignment.centerLeft,
              ),
              10.cl(10, 20).hSpacer,
              Obx(
                () => TextFormField(
                  controller: confirmPasswordController,
                  style: context.textTheme.bodySmall,
                  enabled: isLoading.isFalse,
                  obscureText: isNewPasswordHidden.isTrue,
                  autofillHints: <String>[
                    AutofillHints.password,
                    AutofillHints.newPassword
                  ],
                  keyboardType: TextInputType.visiblePassword,
                  onFieldSubmitted: (_) => onSubmit(),
                  textInputAction: TextInputAction.done,
                  validator: Validatorless.compare(
                    newPasswordController,
                    'Passwords must match.',
                  ),
                  decoration: InputDecoration(
                      prefixIcon: HeroIcon(
                        HeroIcons.lockClosed,
                        style: HeroIconStyle.outline,
                      ),
                      hintText: 'Confirm password'),
                ),
              ),
              20.cl(10, 40).hSpacer,
              ElevatedButton.icon(
                onPressed: isLoading.isFalse.whenOnly(use: onSubmit),
                style: ButtonStyle(
                  fixedSize: Size(60.cw(200, 350), 30.cl(30, 50)).all,
                  backgroundColor: Colors.green.all,
                  padding: 10.cl(5, 20).pdY.all,
                ),
                icon: isLoading.isTrue.whenOnly(
                  use: CircularProgressIndicator(
                    backgroundColor: context.theme.primaryColor.lighten(20),
                    color: Colors.white,
                    strokeWidth: 2.cl(2, 4),
                  ).sized(
                    width: 18.cl(20, 34),
                    height: 18.cl(20, 34),
                  ),
                ),
                label: Text(
                  'Change Password',
                  style: context.textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                  ),
                ),
              )
                  .marginSymmetric(
                    vertical: 15.cl(15, 35),
                  )
                  .center,
            ],
          )).contain(
        width: 100.w,
        height: 100.h,
        padding: 15.cl(15, 35).pdX,
      ),
    );
  }
}
