import 'package:extension_helpers/extension_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:nosk/src/logic/auth/user_model.dart';
import 'package:nosk/src/logic/user/logic.dart';
import 'package:nosk/src/route/route.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tinycolor2/tinycolor2.dart';
import 'package:validatorless/validatorless.dart';

class CreateAdminPage extends RouteFulWidget {
  const CreateAdminPage({super.key});

  static CreateAdminPage get route => const CreateAdminPage();

  @override
  State<CreateAdminPage> createState() => _CreateAdminPageState();

  @override
  String path() => '/create-admin';

  @override
  String title() => 'Create Admin';

  @override
  Transition transition() => Transition.rightToLeftWithFade;
}

class _CreateAdminPageState extends State<CreateAdminPage> {
  final UserLogic _userLogic = UserLogic.to;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _othersNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  final RxBool _isLoading = false.obs;
  final _formKey = GlobalKey<FormState>();

  Future<void> onSubmit() async {
    if (_isLoading.isTrue) return;
    _isLoading.value = true;
    try {
      if (_formKey.currentState!.validate()) {
        final newUser = UserModel(
          email: _emailController.text,
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          otherNames: _othersNameController.text,
          phoneNumber: _phoneNumberController.text,
          type: UserType.admin,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        await _userLogic.createUser(newUser);
        _formKey.currentState?.reset();
        if (mounted) {
          context.toast(
            toastMessage: 'Staff Created',
            type: ToastSnackBarType.success,
          );
        }
      }
    } catch (error) {
      if (mounted) {
        context.toast(
          toastMessage: error.toString(),
          type: ToastSnackBarType.danger,
        );
      }
    } finally {
      _isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Admin'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Please provide the following to add admin.',
              style: context.textTheme.bodySmall,
            ).addOpacity(0.6),
            10.cl(10, 20).hSpacer,
            Text(
              'First Name',
              style: context.textTheme.headlineSmall,
            ).align(
              alignment: Alignment.centerLeft,
            ),
            10.cl(10, 20).hSpacer,
            TextFormField(
              controller: _firstNameController,
              style: context.textTheme.bodySmall,
              enabled: _isLoading.isFalse,
              validator: Validatorless.multiple([
                Validatorless.required('This field is required.'),
              ]),
              autofillHints: <String>[
                AutofillHints.givenName,
              ],
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.name,
              textInputAction: GetPlatform.isAndroid
                  ? TextInputAction.next
                  : TextInputAction.continueAction,
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
              controller: _lastNameController,
              style: context.textTheme.bodySmall,
              enabled: _isLoading.isFalse,
              validator: Validatorless.required('This field is required.'),
              autofillHints: <String>[AutofillHints.familyName],
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.name,
              textInputAction: GetPlatform.isAndroid
                  ? TextInputAction.next
                  : TextInputAction.continueAction,
              decoration: InputDecoration(
                hintText: 'Enter your Last name e.g Deo',
                prefixIcon: HeroIcon(
                  HeroIcons.user,
                  style: HeroIconStyle.outline,
                ),
              ),
            ), 10.cl(10, 20).hSpacer,
            Text(
              'Other Names',
              style: context.textTheme.headlineSmall,
            ).align(
              alignment: Alignment.centerLeft,
            ),
            10.cl(10, 20).hSpacer,
            TextFormField(
              controller: _othersNameController,
              style: context.textTheme.bodySmall,
              enabled: _isLoading.isFalse,
              autofillHints: <String>[AutofillHints.familyName],
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.name,
              textInputAction: GetPlatform.isAndroid
                  ? TextInputAction.next
                  : TextInputAction.continueAction,
              decoration: InputDecoration(
                hintText: 'Enter your others names e.g Deo',
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
              controller: _emailController,
              style: context.textTheme.bodySmall,
              enabled: _isLoading.isFalse,
              validator: Validatorless.email('Invalid email'),
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
              controller: _phoneNumberController,
              style: context.textTheme.bodySmall,
              enabled: _isLoading.isFalse,
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
              textInputAction: GetPlatform.isAndroid
                  ? TextInputAction.next
                  : TextInputAction.continueAction,
              decoration: InputDecoration(
                hintText: 'Enter your phone number e.g +23480.....',
                prefixIcon: HeroIcon(
                  HeroIcons.phone,
                  style: HeroIconStyle.outline,
                ),
              ),
            ),
            10.cl(10, 20).hSpacer,
            Obx(
              () => ElevatedButton.icon(
                onPressed: _isLoading.isFalse.whenOnly(use: onSubmit),
                style: ButtonStyle(minimumSize: Size(240, 26.cl(30, 55)).all),
                icon: _isLoading.isTrue.whenOnly(
                  use: CircularProgressIndicator(
                    backgroundColor: context.theme.primaryColor.lighten(20),
                    color: Colors.white,
                    strokeWidth: 2.cl(2, 4),
                  ).sized(
                    width: 18.cl(20, 34),
                    height: 18.cl(20, 34),
                  ),
                ),
                label: Text('Create User'),
              ),
            ).center,
            50.cl(50, 140).hSpacer
          ],
        ),
      )
          .scrollable()
          .contain(
            width: 100.w,
            height: 100.h,
            padding: 15.cl(15, 35).pdX,
            color: context.theme.scaffoldBackgroundColor,
          )
          .gestureHandler(
            onTap: context.focus.unfocus,
          ),
    );
  }
}
