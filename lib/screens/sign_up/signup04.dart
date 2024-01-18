import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proacademy_app/components/widgets/utilities/app_colors.dart';
import 'package:proacademy_app/components/widgets/utilities/navigation_function.dart';
import 'package:proacademy_app/provider/user_provider.dart';
import 'package:proacademy_app/screens/sign_in/signin.dart';
import 'package:provider/provider.dart';
import '../../components/widgets/ui_support/custom_button_01.dart';
import '../../components/widgets/ui_support/custom_textfield.dart';
import '../../components/widgets/ui_support/title_text.dart';
import '../../components/widgets/utilities/size_config.dart';

class SignUp04 extends StatefulWidget {
  const SignUp04({super.key});

  @override
  State<SignUp04> createState() => _SignUp04State();
}

bool isChecked = false;

class _SignUp04State extends State<SignUp04> {
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
                        text: 'Educational Details',
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
                                color: AppColors.kWhite,
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
                                height: 20,
                              ),
                              SizedBox(
                                width: SizeConfig.w(context) * 0.9,
                                child: Text(
                                  'Please complete the form below with your educational details to register your student account with Proacademy ',
                                  style: GoogleFonts.poppins(
                                      color: Colors.black.withOpacity(0.6),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              CustomTextfield(
                                hintText: 'School or University',
                                controller: value.schoolController,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Checkbox(
                                    checkColor: Colors.white,
                                    value: value.isChecked,
                                    onChanged: (bool? valueCheckBox) {
                                      value.isChecked
                                          ? value.setIsCheck(false)
                                          : value.setIsCheck(true);
                                    },
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: SizeConfig.w(context) * 0.70,
                                    child: Text(
                                      'By clicking, I also confirmed that all information I entered in this form is true and accurate.',
                                      style: GoogleFonts.plusJakartaSans(
                                          color:
                                              AppColors.kBlack.withOpacity(0.6),
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                ],
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
              padding: const EdgeInsets.only(bottom: 220),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Consumer<UserProvider>(
                    builder: (context, value, child) {
                      return value.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : CustomButton(
                              buttonText: 'Sign Up',
                              onTap: () {
                                if (value.educationalFieldValidate(context)) {
                                  value.startSignUp(context).whenComplete(() =>
                                      NavigationFunction.navigateTo(
                                          BuildContext,
                                          context,
                                          Widget,
                                          const SignIn()));
                                }
                              },
                            );
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
