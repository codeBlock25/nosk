import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:heroicons/heroicons.dart';
import 'package:nosk/generated/assets.dart';
import 'package:nosk/src/logic/logic.dart';
import 'package:nosk/src/route/route.dart';
import 'package:extension_helpers/extension_helpers.dart';
import 'package:nosk/src/screens/screens.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tinycolor2/tinycolor2.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends RouteFulWidget {
  const LoginPage({super.key});

  static LoginPage get route => const LoginPage();

  @override
  State<LoginPage> createState() => _LoginPageState();

  @override
  String path() => '/login';

  @override
  String title() => 'Login to Nosk';
}

class _LoginPageState extends State<LoginPage> {
  final AuthLogic _authLogic = AuthLogic.to;
  RxBool asAdmin = false.obs;
  RxBool isPasswordHidden = true.obs;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();

  bool isLoading = false;

  Future<void> onSubmit() async {
    setState(() {
      isLoading = true;
    });
    try {
      if (_formStateKey.currentState?.validate() ?? false) {
        await _authLogic.firebaseAuth.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        _formStateKey.currentState?.save();
        _formStateKey.currentState?.reset();
        if (mounted) {
          context.toast(
            toastMessage: 'Welcome to Nosk Suite',
            type: ToastSnackBarType.success,
            duration: 2.seconds,
            onClosed: GuestMainPage.route.startAt,
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
          toastMessage: 'Error signing your in, please try again.',
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
    return Scaffold(
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
              'Sign into your Account.',
              style: context.textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ).center,
            10.cl(10, 20).hSpacer,
            Text(
              'Welcome back to Nosk, Please provide your details stating your user type.',
              style: context.textTheme.bodySmall,
              textAlign: TextAlign.center,
            ).center.addOpacity(0.6),
            Stack(
              children: <Widget>[
                Obx(
                  () => AnimatedPositioned(
                    duration: 300.milliseconds,
                    curve: Curves.decelerate,
                    left: asAdmin.isFalse.whenNull(
                      use: 12.cl(5, 10),
                      elseUse: 100.cw(100, 500).division(2) -
                          15.cl(10, 40).square.toDouble(),
                    ),
                    top: 2.cl(2, 5),
                    child: Container(
                      width: 100.cw(100, 500).division(2.2) -
                          15.cl(10, 40).square.toDouble(),
                      height: context.breakpoint.largerThan(MOBILE).when(
                            use: 26.cl(20, 30),
                            elseUse: 26.cl(20, 60),
                          ),
                      decoration: BoxDecoration(
                        color: context.theme.scaffoldBackgroundColor,
                        borderRadius: 50.dp.rc.brAll,
                      ),
                    ).ignore,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        asAdmin.value = false;
                      },
                      style: ButtonStyle(
                        overlayColor: Colors.transparent.all,
                        shadowColor: Colors.transparent.all,
                        surfaceTintColor: Colors.transparent.all,
                        shape: RoundedRectangleBorder(
                          borderRadius: 50.dp.rc.brAll,
                        ).all,
                      ),
                      child: Text(
                        'As Guest',
                        style: context.textTheme.headlineSmall,
                      ),
                    )
                        .marginSymmetric(
                          horizontal: 12.cl(5, 40),
                        )
                        .expand,
                    TextButton(
                      onPressed: () {
                        asAdmin.value = true;
                      },
                      style: ButtonStyle(
                        overlayColor: Colors.transparent.all,
                        shadowColor: Colors.transparent.all,
                        surfaceTintColor: Colors.transparent.all,
                        shape: RoundedRectangleBorder(
                          borderRadius: 50.dp.rc.brAll,
                        ).all,
                      ),
                      child: Text(
                        'As Staff',
                        style: context.textTheme.headlineSmall,
                      ),
                    )
                        .marginSymmetric(
                          horizontal: 12.cl(5, 40),
                        )
                        .expand
                  ],
                ),
              ],
            ).contain(
              width: 100.w,
              padding: 5.cl(5, 10).pdY,
              margin: 10.cl(10, 20).pdX.copyWith(
                    top: 25.cl(35, 55),
                    bottom: 10.cl(15, 45),
                  ),
              decoration: BoxDecoration(
                color: context.theme.scaffoldBackgroundColor.darken(5),
                borderRadius: 50.dp.rc.brAll,
              ),
            ),
            Obx(() {
              return RichText(
                text: TextSpan(
                  text: "Don't have an account yet? ",
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.textTheme.bodySmall?.color
                        ?.withValues(alpha: 0.6),
                  ),
                  children: [
                    TextSpan(
                        text: 'Sign Up here.',
                        style: context.textTheme.headlineSmall?.copyWith(
                          color: context.theme.primaryColor,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = RegisterPage.route.goto)
                  ],
                ),
              )
                  .paddingOnly(
                    bottom:
                        asAdmin.isFalse.when(use: 15.cl(15, 45), elseUse: 0.0),
                  )
                  .conditionalIgnore(condition: asAdmin.isTrue);
            }),
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
              validator: Validatorless.multiple([
                Validatorless.required('This field is required.'),
                Validatorless.email('Invalid email.'),
              ]),
              autofillHints: <String>[
                AutofillHints.email,
                AutofillHints.username
              ],
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.continueAction,
              decoration: InputDecoration(
                prefixIcon: HeroIcon(
                  HeroIcons.envelope,
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
            RichText(
              text: TextSpan(
                text: 'Forgot Password?',
                style: context.textTheme.bodySmall,
                recognizer: TapGestureRecognizer()
                  ..onTap = ForgotPasswordPage.route.goto,
              ),
            ).align(alignment: Alignment.centerRight),
            20.cl(10, 40).hSpacer,
            ElevatedButton.icon(
              onPressed: isLoading.isFalse.whenOnly(use: onSubmit),
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
              style: ButtonStyle(
                fixedSize: Size(60.cw(200, 350), 30.cl(30, 50)).all,
                padding: 10.cl(5, 20).pdY.all,
              ),
              label: Text('SIGN IN'),
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
                            foregroundColor:
                                context.textTheme.bodySmall?.color.all),
                        label: Text('Sign in with Google'),
                      ),
                    ],
                  ),
                  elseUse: 0.wSpacer,
                ),
              );
            }),
            20.cl(10, 80).hSpacer,
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: "By continuing you here by agree to",
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.textTheme.bodySmall?.color?.lighten(30),
                ),
                children: [
                  TextSpan(
                    text: " Nosk's,",
                    style: context.textTheme.headlineSmall?.copyWith(
                      color: context.theme.primaryColor,
                    ),
                  ),
                  TextSpan(
                    text: ' Terms of Service',
                    style: context.textTheme.headlineSmall,
                  ),
                  TextSpan(text: ' and '),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: context.textTheme.headlineSmall,
                  )
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
    );
  }
}
