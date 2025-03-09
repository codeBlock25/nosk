import 'package:extension_helpers/extension_helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:nosk/generated/assets.dart';
import 'package:nosk/src/logic/auth/logic.dart';
import 'package:nosk/src/route/route.dart';
import 'package:nosk/src/screens/login/page.dart';
import 'package:pinput/pinput.dart';
import 'package:responsive_framework/responsive_framework.dart';
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
  final AuthLogic _authLogic = AuthLogic.to;
  Rx<ResetStatus> status = ResetStatus.pending.obs;
  final TextEditingController pinController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late final FocusNode focusNode;
  final TextEditingController confirmPasswordController =
      TextEditingController();
  RxBool isLoading = false.obs;

  final GlobalKey<FormState> _pendingFormStateKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _confirmingFormStateKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _saveFormStateKey = GlobalKey<FormState>();

  Future<void> onSubmit() async {
    if (isLoading.isTrue) return;
    isLoading.value = true;
    try {
      if (status.value == ResetStatus.pending) {
        if (_pendingFormStateKey.currentState?.validate() ?? false) {
          await _authLogic.firebaseAuth
              .sendPasswordResetEmail(email: emailController.text);
          if (mounted) {
            context.toast(
              toastMessage:
                  'Reset link sent, please follow link to reset your password',
              type: ToastSnackBarType.success,
            );
            (LoginPage.route.stepBackAndTo).delay(duration: 2.seconds);
          }
          // status.value = ResetStatus.confirming;
          return;
        }
      }
      if (status.value == ResetStatus.confirming) {
        if (_confirmingFormStateKey.currentState?.validate() ?? false) {
          await _authLogic.firebaseAuth
              .verifyPasswordResetCode(pinController.text);
          status.value = ResetStatus.save;
          return;
        }
      }
      if (_saveFormStateKey.currentState?.validate() ?? false) {
        await _authLogic.firebaseAuth.confirmPasswordReset(
          code: pinController.text,
          newPassword: passwordController.text,
        );
        LoginPage.route.stepBackAndTo();
        if (mounted) {
          context.toast(
            toastMessage: 'Password reset successful',
            type: ToastSnackBarType.success,
          );
        }
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        if (mounted) {
          context.toast(
            toastMessage: 'Account does not exist, please check again.',
            type: ToastSnackBarType.danger,
          );
        }
        return;
      }
      if (mounted) {
        context.toast(
          toastMessage: error.message ?? error.code,
          type: ToastSnackBarType.danger,
        );
      }
    } catch (error) {
      if (mounted) {
        context.toast(
          toastMessage: 'Error resetting password, please try again.',
          type: ToastSnackBarType.danger,
        );
      }
    } finally {
      isLoading.value = false;
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
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                                Validatorless.required(
                                    'This field is required'),
                                Validatorless.email('Invalid email'),
                              ]),
                              autofillHints: <String>[
                                AutofillHints.email,
                                AutofillHints.username
                              ],
                              textCapitalization: TextCapitalization.none,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: GetPlatform.isAndroid
                                  ? TextInputAction.next
                                  : TextInputAction.continueAction,
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
                            separatorBuilder: (index) =>
                                const SizedBox(width: 8),
                            validator: Validatorless.multiple([
                              Validatorless.required('This field is required.'),
                              Validatorless.number(
                                  'Your code should be numbers only'),
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
                                color: context.theme.scaffoldBackgroundColor
                                    .darken(2),
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
                              autofillHints: <String>[
                                AutofillHints.newPassword
                              ],
                              keyboardType: TextInputType.visiblePassword,
                              onFieldSubmitted: (_) => onSubmit(),
                              textInputAction: TextInputAction.done,
                              validator: Validatorless.multiple([
                                Validatorless.required(
                                    "This field can't be empty"),
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
                  Obx(
                    () => ElevatedButton.icon(
                      onPressed: isLoading.isFalse.whenOnly(use: onSubmit),
                      icon: isLoading.isTrue.whenOnly(
                        use: CircularProgressIndicator(
                          backgroundColor:
                              context.theme.primaryColor.lighten(20),
                          color: Colors.white,
                          strokeWidth: 2.cl(2, 4),
                        ).sized(
                          width: 18.cl(20, 34),
                          height: 18.cl(20, 34),
                        ),
                      ),
                      style: ButtonStyle(
                          fixedSize: Size(60.cw(200, 350), 30.cl(30, 50)).all),
                      label: Obx(
                        () => Text(
                          status.value == ResetStatus.pending
                              ? 'SEND RESET CODE'
                              : status.value == ResetStatus.confirming
                                  ? 'CONFIRM'
                                  : 'SAVE RESET',
                        ),
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
                            decorationColor: context.theme.primaryColor
                                .withValues(alpha: 0.5),
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
              ).contain(
                width: 100.cw(100, 500),
                height: 100.h,
                color: context.theme.scaffoldBackgroundColor,
                padding: 20.cl(15, 50).pdX,
              ),
              if (context.breakpoint.largerOrEqualTo(TABLET))
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Smart Hospitality, Seamless Experience.',
                      style: context.textTheme.headlineLarge
                          ?.copyWith(color: Colors.white),
                      textAlign: TextAlign.right,
                    ),
                    Text(
                      'Streamline bookings, automate check-ins, and enhance guest experiences—all in one place.',
                      style: context.textTheme.bodyMedium
                          ?.copyWith(color: Colors.white),
                      textAlign: TextAlign.right,
                    ),
                  ],
                )
                    .contain(
                      width: 100.w,
                      height: 100.h,
                      padding: 10.cl(10, 40).pdAll.copyWith(
                            left: context.breakpoint.largerOrEqualTo(DESKTOP)
                                ? 24.cw(70, 440)
                                : 10.cw(70, 440),
                            bottom: 10.cw(70, 240),
                          ),
                      margin: 10.cl(10, 40).pdAll,
                      decoration: BoxDecoration(
                        color: context.theme.primaryColor.darken(45),
                        borderRadius: 10.cl(10, 20).brcCircle,
                        image: DecorationImage(
                          image: AssetImage(Assets.imagesPattern),
                          alignment: Alignment.center,
                          fit: BoxFit.cover,
                          opacity: 0.6,
                        ),
                      ),
                    )
                    .expand,
            ],
          ),
          IconButton(
            onPressed: Get.back,
            style: ButtonStyle(
              backgroundColor:
                  context.theme.scaffoldBackgroundColor.darken().all,
              fixedSize: Size(
                20.cl(30, 75),
                20.cl(30, 75),
              ).all,
            ),
            icon: HeroIcon(HeroIcons.chevronLeft),
          ).marginOnly(
              top: 15.cl(10, 35).plus(context.mediaQueryPadding.top).toDouble(),
              left: 10.cl(10, 35))
        ],
      )
          .sized(
            width: 100.w,
            height: 100.h,
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
