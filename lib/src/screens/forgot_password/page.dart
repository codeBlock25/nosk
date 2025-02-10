import 'package:extension_helpers/extension_helpers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:nosk/generated/assets.dart';
import 'package:nosk/src/route/route.dart';
import 'package:nosk/src/screens/login/page.dart';
import 'package:pinput/pinput.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tinycolor2/tinycolor2.dart';
import 'package:validatorless/validatorless.dart';
import 'package:smart_auth/smart_auth.dart';

enum ResetStatus {
  pending,
  confirming,
  save;
}

class ForgotPasswordPage extends RouteFulWidget {
  const ForgotPasswordPage({super.key});

  static ForgotPasswordPage get route => const ForgotPasswordPage();

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();

  @override
  String path() => '/forgot-password';

  @override
  String title() => 'Request Password';
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  RxBool isPasswordHidden = true.obs;
  late final SmsRetriever smsRetriever;
  Rx<ResetStatus> status = ResetStatus.pending.obs;
  final TextEditingController pinController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late final FocusNode focusNode;
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> _pendingFormStateKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _confirmingFormStateKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _saveFormStateKey = GlobalKey<FormState>();

  Future<void> onSubmit() async {
    if (status.value == ResetStatus.pending) {
      if (_pendingFormStateKey.currentState?.validate() ?? false) {
        status.value = ResetStatus.confirming;
        return;
      }
    }
    if (status.value == ResetStatus.confirming) {
      if (_confirmingFormStateKey.currentState?.validate() ?? false) {
        status.value = ResetStatus.save;
        return;
      }
    }
    if (_saveFormStateKey.currentState?.validate() ?? false) {
      LoginPage.route.stepBackAndTo();
      context.toast(
        toastMessage: 'Password reset successful',
        type: ToastSnackBarType.success,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    // On web, disable the browser's context menu since this example uses a custom
    // Flutter-rendered context menu.
    if (kIsWeb) {
      BrowserContextMenu.disableContextMenu();
    }
    focusNode = FocusNode();

    /// In case you need an SMS autofill feature
    smsRetriever = SmsRetrieverImpl(
      SmartAuth.instance,
    );
  }

  @override
  void dispose() {
    if (kIsWeb) {
      BrowserContextMenu.enableContextMenu();
    }
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    final defaultPinTheme = PinTheme(
      width: 30.cl(40, 75),
      height: 30.cl(40, 75),
      textStyle: context.textTheme.headlineMedium,
      decoration: BoxDecoration(
        color: context.theme.scaffoldBackgroundColor.darken(6),
        borderRadius: BorderRadius.circular(19),
      ),
    );
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: context.theme.scaffoldBackgroundColor.darken(),
      body: Column(
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
            'Reset your Account.',
            style: context.textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ).center,
          10.cl(10, 20).hSpacer,
          Text(
            'Forgot your password, confirm your details to reset your password.',
            style: context.textTheme.bodySmall,
            textAlign: TextAlign.center,
          ).center.addOpacity(0.6),
          20.cl(10, 80).hSpacer,
          Obx(() {
            if (status.value == ResetStatus.pending) {
              return Form(
                key: _pendingFormStateKey,
                child: Column(
                  children: [
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
                      validator: Validatorless.multiple([
                        Validatorless.required('This field is required'),
                        Validatorless.email('Invalid email'),
                      ]),
                      autofillHints: <String>[
                        AutofillHints.email,
                        AutofillHints.username
                      ],
                      textCapitalization: TextCapitalization.none,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.continueAction,
                      decoration: InputDecoration(
                        hintText: 'Enter your email.',
                        prefixIcon: HeroIcon(
                          HeroIcons.envelope,
                          style: HeroIconStyle.outline,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            if (status.value == ResetStatus.confirming) {
              return Form(
                key: _confirmingFormStateKey,
                child: Directionality(
                  // Specify direction if desired
                  textDirection: TextDirection.ltr,
                  child: Pinput(
                    // You can pass your own SmsRetriever implementation based on any package
                    // in this example we are using the SmartAuth
                    keyboardType: TextInputType.number,
                    smsRetriever: smsRetriever,
                    controller: pinController,
                    focusNode: focusNode,
                    defaultPinTheme: defaultPinTheme,
                    separatorBuilder: (index) => const SizedBox(width: 8),
                    validator: Validatorless.multiple([
                      Validatorless.required('This field is required.'),
                      Validatorless.number('Your code should be numbers only'),
                      Validatorless.length(4, '4 Digits are required.')
                    ]),
                    hapticFeedbackType: HapticFeedbackType.lightImpact,
                    onCompleted: (pin) {
                      debugPrint('onCompleted: $pin');
                    },
                    onChanged: (value) {
                      debugPrint('onChanged: $value');
                    },
                    cursor: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 9),
                          width: 22,
                          height: 1,
                          color: focusedBorderColor,
                        ),
                      ],
                    ),
                    focusedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        color: context.theme.scaffoldBackgroundColor.darken(2),
                        borderRadius: 8.cl(10, 20).rc.brAll,
                        border: Border.all(
                          color: context.theme.primaryColor,
                          width: 2.cl(2, 4),
                        ),
                      ),
                    ),
                    submittedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        color: fillColor,
                        borderRadius: BorderRadius.circular(19),
                        border: Border.all(
                          color: context.theme.primaryColor,
                          width: 2.cl(2, 4),
                        ),
                      ),
                    ),
                    errorPinTheme: defaultPinTheme.copyBorderWith(
                      border: Border.all(color: Colors.redAccent),
                    ),
                  ),
                ),
              );
            }
            return Form(
              key: _saveFormStateKey,
              child: Column(
                children: <Widget>[
                  Obx(
                    () => TextFormField(
                      controller: passwordController,
                      style: context.textTheme.bodySmall,
                      obscureText: isPasswordHidden.isTrue,
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
                        prefixIcon: HeroIcon(
                          HeroIcons.lockClosed,
                          style: HeroIconStyle.outline,
                        ),
                        hintText: 'Enter new password',
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
                  Obx(
                    () => TextFormField(
                      controller: confirmPasswordController,
                      style: context.textTheme.bodySmall,
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
                ],
              ),
            );
          }),
          20.cl(10, 40).hSpacer,
          ElevatedButton(
            onPressed: onSubmit,
            style: ButtonStyle(
                fixedSize: Size(60.cw(200, 350), 30.cl(30, 50)).all),
            child: Obx(
              () => Text(
                status.value == ResetStatus.pending
                    ? 'SEND RESET CODE'
                    : status.value == ResetStatus.confirming
                        ? 'CONFIRM'
                        : 'SAVE RESET',
              ),
            ),
          ),
          30.cl(10, 80).hSpacer,
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: "Remembered your details?, ",
              style: context.textTheme.bodySmall?.copyWith(
                color: context.textTheme.bodySmall?.color?.lighten(30),
              ),
              children: [
                TextSpan(
                  text: "Login.",
                  style: context.textTheme.headlineSmall?.copyWith(
                    color: context.theme.primaryColor,
                    decoration: TextDecoration.underline,
                    decorationThickness: 2.cl(2, 4),
                    decorationColor:
                        context.theme.primaryColor.withValues(alpha: 0.5),
                    decorationStyle: TextDecorationStyle.solid,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = LoginPage.route.stepBackAndTo,
                ),
              ],
            ),
          ).center,
          30.cl(20, 70).hSpacer,
        ],
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
    );
  }
}

/// You, as a developer should implement this interface.
/// You can use any package to retrieve the SMS code. in this example we are using SmartAuth
class SmsRetrieverImpl implements SmsRetriever {
  const SmsRetrieverImpl(this.smartAuth);

  final SmartAuth smartAuth;

  @override
  Future<void> dispose() {
    return smartAuth.removeUserConsentApiListener();
  }

  @override
  Future<String?> getSmsCode() async {
    final signature = await smartAuth.getAppSignature();
    debugPrint('App Signature: $signature');
    final res = await smartAuth.getSmsWithUserConsentApi();
    if (res.hasData) {
      return res.requireData.code ?? '';
    }
    return null;
  }

  @override
  bool get listenForMultipleSms => false;
}
