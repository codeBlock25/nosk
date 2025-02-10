import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extension_helpers/extension_helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:heroicons/heroicons.dart';
import 'package:nosk/generated/assets.dart';
import 'package:nosk/src/logic/auth/logic.dart';
import 'package:nosk/src/logic/auth/user_model.dart';
import 'package:nosk/src/logic/user/logic.dart';
import 'package:nosk/src/route/route.dart';
import 'package:nosk/src/screens/screens.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tinycolor2/tinycolor2.dart';
import 'package:validatorless/validatorless.dart';

class RegisterPage extends RouteFulWidget {
  const RegisterPage({super.key});

  static RegisterPage get route => const RegisterPage();

  @override
  State<RegisterPage> createState() => _RegisterPageState();

  @override
  String path() => '/register';

  @override
  String title() => 'Register to Nosk';
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthLogic authLogic = AuthLogic.to;
  final UserLogic userLogic = UserLogic.to;
  RxBool asAdmin = false.obs;
  RxBool isPasswordHidden = true.obs;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  bool isLoading = false;

  Future<void> onSubmit() async {
    setState(() {
      isLoading = true;
    });
    try {
      if (_formStateKey.currentState?.validate() ?? false) {
        UserCredential? userCredential =
            await authLogic.firebaseAuth.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        if (userCredential.user == null) {
          throw Exception('Invalid account.');
        }
        var user = UserModel(
          username: userCredential.user?.displayName ?? '',
          value: userCredential.user?.uid ?? '',
          email: emailController.text,
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          type: UserType.guest,
          otherNames: '',
          createdAt: Timestamp.now(),
          updatedAt: Timestamp.now(),
        );
        await userLogic.addUser(user);
        _formStateKey.currentState?.save();
        _formStateKey.currentState?.reset();
        if (mounted) {
          context.toast(
            toastMessage: 'Account created, please login.',
            type: ToastSnackBarType.success,
            onClosed: LoginPage.route.stepBackAndTo,
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

  Future<void> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(credential);
      if (mounted) {
        context.toast(
          toastMessage: 'Welcome to Nosk Suite',
          type: ToastSnackBarType.success,
          duration: 2.seconds,
          onClosed: GuestMainPage.route.startAt,
        );
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
          toastMessage: 'Error signing you in with Google, please try again.',
          type: ToastSnackBarType.danger,
        );
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: isLoading,
      onPopInvokedWithResult: (bool canPop, result) {
        if (canPop) {
          context.focus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: 0.hSpacer,
          toolbarHeight: 0,
        ),
        backgroundColor: context.theme.scaffoldBackgroundColor.darken(),
        body: Form(
          key: _formStateKey,
          canPop: false,
          child: Column(
            children: <Widget>[
              Image.asset(
                Assets.iconsIcon,
                fit: BoxFit.fitHeight,
                height: 45.cl(50, 100),
              ).marginOnly(
                top: 5.cl(5, 10),
                bottom: 10.cl(10, 20),
              ),
              Text(
                'Create your Account.',
                style: context.textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ).center,
              10.cl(10, 20).hSpacer,
              Text(
                'Create your account as a guest at nosk hotel suite, \nplease provide the following details.',
                style: context.textTheme.bodySmall,
                textAlign: TextAlign.center,
              )
                  .paddingSymmetric(horizontal: 5.cl(5, 25))
                  .center
                  .addOpacity(0.6),
              10.cl(10, 20).hSpacer,
              Text(
                'First Name',
                style: context.textTheme.headlineSmall,
              ).align(
                alignment: Alignment.centerLeft,
              ),
              10.cl(10, 20).hSpacer,
              TextFormField(
                controller: firstNameController,
                style: context.textTheme.bodySmall,
                enabled: isLoading.isFalse,
                validator: Validatorless.multiple([
                  Validatorless.required('This field is required.'),
                ]),
                autofillHints: <String>[
                  AutofillHints.givenName,
                ],
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.continueAction,
                decoration: InputDecoration(
                  hintText: 'Enter your first name e.g Jane',
                  prefixIcon: HeroIcon(
                    HeroIcons.user,
                    style: HeroIconStyle.outline,
                  ),
                ),
              ),
              10.cl(10, 20).hSpacer,
              Text(
                'Last Name',
                style: context.textTheme.headlineSmall,
              ).align(
                alignment: Alignment.centerLeft,
              ),
              10.cl(10, 20).hSpacer,
              TextFormField(
                controller: lastNameController,
                style: context.textTheme.bodySmall,
                enabled: isLoading.isFalse,
                validator: Validatorless.required('This field is required.'),
                autofillHints: <String>[AutofillHints.familyName],
                textCapitalization: TextCapitalization.none,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.continueAction,
                decoration: InputDecoration(
                  hintText: 'Enter your Last name e.g Deo',
                  prefixIcon: HeroIcon(
                    HeroIcons.user,
                    style: HeroIconStyle.outline,
                  ),
                ),
              ),
              10.cl(10, 20).hSpacer,
              Text(
                'Email',
                style: context.textTheme.headlineSmall,
              ).align(
                alignment: Alignment.centerLeft,
              ),
              10.cl(10, 20).hSpacer,
              TextFormField(
                controller: emailController,
                style: context.textTheme.bodySmall,
                enabled: isLoading.isFalse,
                validator: Validatorless.email('Invalid email'),
                autofillHints: <String>[
                  AutofillHints.email,
                  AutofillHints.username
                ],
                textCapitalization: TextCapitalization.none,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.continueAction,
                decoration: InputDecoration(
                  hintText: 'Enter your email e.g example@nosk.com',
                  prefixIcon: HeroIcon(
                    HeroIcons.envelope,
                    style: HeroIconStyle.outline,
                  ),
                ),
              ),
              10.cl(10, 20).hSpacer,
              Text(
                'Phone Number',
                style: context.textTheme.headlineSmall,
              ).align(
                alignment: Alignment.centerLeft,
              ),
              10.cl(10, 20).hSpacer,
              TextFormField(
                controller: phoneNumberController,
                style: context.textTheme.bodySmall,
                enabled: isLoading.isFalse,
                validator: Validatorless.multiple([
                  Validatorless.required('This field is required.'),
                  Validatorless.regex(
                    RegExp(
                        r'^[+]?[(]?[0-9]{3}[)]?[-s.]?[0-9]{3}[-\s.]?[0-9]{4,6}$'),
                    'Invalid phone number',
                  )
                ]),
                autofillHints: <String>[
                  AutofillHints.telephoneNumber,
                ],
                textCapitalization: TextCapitalization.none,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.continueAction,
                decoration: InputDecoration(
                  hintText: 'Enter your phone number e.g +23480.....',
                  prefixIcon: HeroIcon(
                    HeroIcons.phone,
                    style: HeroIconStyle.outline,
                  ),
                ),
              ),
              15.cl(10, 30).hSpacer,
              Text(
                'Password',
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
                    hintText: 'Enter a strong password.',
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
                  obscureText: isPasswordHidden.isTrue,
                  autofillHints: <String>[
                    AutofillHints.password,
                    AutofillHints.newPassword
                  ],
                  keyboardType: TextInputType.visiblePassword,
                  onFieldSubmitted: (_) => onSubmit(),
                  textInputAction: TextInputAction.done,
                  validator: Validatorless.compare(
                    passwordController,
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
                onPressed: isLoading.isFalse.whenOnly(
                  use: onSubmit,
                ),
                style: ButtonStyle(
                  fixedSize: Size(60.cw(200, 350), 30.cl(30, 50)).all,
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
                label: Text('SIGN UP'),
              ),
              10.cl(10, 80).hSpacer,
              Obx(() {
                return SizedBox(
                  child: asAdmin.isFalse.when(
                    use: Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Divider().expand,
                            Text(
                              ' OR ',
                              style: context.textTheme.headlineSmall,
                            ),
                            Divider().expand,
                          ],
                        ).addOpacity(0.8),
                        10.cl(10, 80).hSpacer,
                        OutlinedButton.icon(
                          onPressed: isLoading.isFalse.whenOnly(use: signInWithGoogle),
                          icon: Image.asset(
                            Assets.iconsGoogle,
                            fit: BoxFit.fitWidth,
                            width: 18.cl(22, 44),
                          ),
                          style: ButtonStyle(
                              fixedSize: Size(60.cw(200, 350), 30.cl(30, 50)).all,
                              padding: 10.cl(5, 20).pdY.all,
                              foregroundColor: context.textTheme.bodySmall?.color.all
                          ),
                          label: Text('Sign up with Google'),
                        ),
                      ],
                    ),
                    elseUse: 0.wSpacer,
                  ),
                );
              }),
              20.cl(10, 80).hSpacer,
              RichText(
                text: TextSpan(
                  text: 'Already have an account? ',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.textTheme.bodySmall?.color
                        ?.withValues(alpha: 0.6),
                  ),
                  children: [
                    TextSpan(
                      text: 'Sign in here.',
                      style: context.textTheme.headlineSmall?.copyWith(
                        color: context.theme.primaryColor,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = LoginPage.route.goto,
                    ),
                  ],
                ),
              ).center,
              30.cl(20, 70).hSpacer,
            ],
          ),
        )
            .scrollable()
            .contain(
              width: 100.cw(100, 500),
              height: 100.h,
              color: context.theme.scaffoldBackgroundColor,
              padding: 20.cl(15, 50).pdX,
              margin: ((100.w - 100.cw(100, 500)) / 2).pdX,
            )
            .gestureHandler(
              onTap: context.focus.unfocus,
            ),
      ),
    );
  }
}
