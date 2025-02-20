import 'package:extension_helpers/extension_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:nosk/src/logic/auth/logic.dart';
import 'package:nosk/src/logic/auth/user_model.dart';
import 'package:nosk/src/route/route.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tinycolor2/tinycolor2.dart';
import 'package:validatorless/validatorless.dart';

class PersonalInformationPage extends RouteFulWidget {
  const PersonalInformationPage({super.key});

  static PersonalInformationPage get route => const PersonalInformationPage();

  @override
  State<PersonalInformationPage> createState() =>
      _PersonalInformationPageState();

  @override
  String path() => '/setting/personal-information';

  @override
  String title() => 'Personal Information';
}

class _PersonalInformationPageState extends State<PersonalInformationPage> {
  final AuthLogic _authLogic = AuthLogic.to;
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool editing = false;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    firstNameController.text = _authLogic.user.value?.firstName ?? '';
    lastNameController.text = _authLogic.user.value?.lastName ?? '';
    phoneNumberController.text = _authLogic.user.value?.phoneNumber ?? '';
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
          'Personal Information',
          style: context.textTheme.headlineMedium,
        ),
      ),
      body: Form(
          key: _formStateKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'View and edit your details',
                style: context.textTheme.bodySmall,
              ),
              10.cl(10, 20).hSpacer,
              TextFormField(
                controller: firstNameController,
                style: context.textTheme.bodySmall?.copyWith(
                    color: editing.isFalse.whenOnly(use: Colors.grey)),
                enabled: isLoading.isFalse && editing.isTrue,
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
                    color: editing.isFalse.whenOnly(use: Colors.grey),
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
                style: context.textTheme.bodySmall?.copyWith(
                    color: editing.isFalse.whenOnly(use: Colors.grey)),
                enabled: isLoading.isFalse && editing.isTrue,
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
                    color: editing.isFalse.whenOnly(use: Colors.grey),
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
                style: context.textTheme.bodySmall?.copyWith(
                    color: editing.isFalse.whenOnly(use: Colors.grey)),
                enabled: isLoading.isFalse && editing.isTrue,
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
                    color: editing.isFalse.whenOnly(use: Colors.grey),
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: isLoading.isFalse.whenOnly(
                  use: () async {
                    setState(() {
                      editing = !editing;
                    });
                    if (editing.isFalse) {
                      if (_formStateKey.currentState?.validate() ?? false) {
                        setState(() {
                          isLoading = true;
                        });
                        await _authLogic
                            .updateProfile(_authLogic.user.value!.copyWith(
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                          phoneNumber: phoneNumberController.text,
                        ))
                            .catchError(
                          (e) {
                            if (context.mounted) {
                              context.toast(
                                type: ToastSnackBarType.danger,
                                toastMessage: e.message,
                              );
                            }
                          },
                        ).whenComplete(() {
                          setState(() {
                            isLoading = true;
                          });
                        });
                      }
                    }
                  },
                ),
                style: ButtonStyle(
                  fixedSize: Size(60.cw(200, 350), 30.cl(30, 50)).all,
                  backgroundColor:
                      editing.isFalse.whenOnly(use: Colors.green.all),
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
                  editing.isTrue
                      .when(use: 'SAVE DETAILS', elseUse: 'EDIT DETAILS'),
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
