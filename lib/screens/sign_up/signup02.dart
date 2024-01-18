import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proacademy_app/provider/user_provider.dart';
import 'package:proacademy_app/screens/sign_up/signup03.dart';
import 'package:provider/provider.dart';

import '../../components/widgets/ui_support/custom_button_02.dart';
import '../../components/widgets/ui_support/custom_textfield.dart';
import '../../components/widgets/ui_support/title_text.dart';
import '../../components/widgets/utilities/app_colors.dart';
import '../../components/widgets/utilities/birthday_picker.dart';
import '../../components/widgets/utilities/gender_dropdown.dart';
import '../../components/widgets/utilities/navigation_function.dart';
import '../../components/widgets/utilities/size_config.dart';

class SignUp02 extends StatefulWidget {
  const SignUp02({super.key});

  @override
  State<SignUp02> createState() => _SignUp02State();
}

bool isChecked = false;

class _SignUp02State extends State<SignUp02> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeInRight(
        duration: const Duration(milliseconds: 500),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: SizeConfig.w(context),
                height: SizeConfig.h(context) * 0.5,
                decoration: const BoxDecoration(
                  color: AppColors.kPrimary,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: SizeConfig.h(context) * 0.15,
                      ),
                      const TitleText(
                        text: 'Personal Details',
                        fontColor: AppColors.kWhite,
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 6,
                            width: 70,
                            decoration: BoxDecoration(
                                color: AppColors.kWhite.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          Container(
                            height: 6,
                            width: 70,
                            decoration: BoxDecoration(
                                color: AppColors.kWhite,
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          Container(
                            height: 6,
                            width: 70,
                            decoration: BoxDecoration(
                                color: AppColors.kWhite.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          Container(
                            height: 6,
                            width: 70,
                            decoration: BoxDecoration(
                                color: AppColors.kWhite.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          Container(
                            height: 6,
                            width: 70,
                            decoration: BoxDecoration(
                                color: AppColors.kWhite.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(5)),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SingleChildScrollView(
                child: Container(
                    width: SizeConfig.w(context),
                    height: SizeConfig.h(context) * 0.75,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                      color: Colors.white,
                    ),
                    child: Consumer<UserProvider>(
                      builder: (context, value, child) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 28),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              const TitleText(
                                text: 'Student Registration',
                                fontColor: AppColors.kBlack,
                                fontWeight: FontWeight.w800,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                width: SizeConfig.w(context) * 0.9,
                                child: Text(
                                  'Please complete the form below with your personal details to register your student account with Proacademy ',
                                  style: GoogleFonts.poppins(
                                      color: Colors.black.withOpacity(0.6),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              CustomTextfield(
                                hintText: 'First Name',
                                controller: value.firstNameController,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              CustomTextfield(
                                hintText: 'Last Name',
                                controller: value.lastNameController,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              CustomTextfield(
                                readOnly: true,
                                hintText: 'Birth Day',
                                controller: value.birthDayController,
                                textOnTap: () {
                                  BirthdayPicker.showBirthDayPicker(context);
                                },
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              CustomTextfield(
                                readOnly: true,
                                hintText: 'Age',
                                controller: value.ageController,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              GenderDropDown(
                                controller: value.genderController,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        );
                      },
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, bottom: 30),
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: Consumer<UserProvider>(
                    builder: (context, value, child) {
                      return CustomButton02(
                        onTap: () {
                          if (value.personalFieldValidate(context)) {
                            NavigationFunction.navigateTo(BuildContext, context,
                                Widget, const SignUp03());
                          }
                        },
                      );
                    },
                  )),
            )
          ],
        ),
      ),
    );
  }
}
