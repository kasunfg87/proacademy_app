// ignore_for_file: file_names

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proacademy_app/provider/user_provider.dart';
import 'package:provider/provider.dart';
import '../../components/widgets/ui_support/custom_button_01.dart';
import '../../components/widgets/ui_support/custom_textfield.dart';
import '../../components/widgets/ui_support/title_text.dart';
import '../../components/widgets/utilities/app_colors.dart';
import '../../components/widgets/utilities/size_config.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

bool isChecked = false;

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
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
                            height: SizeConfig.h(context) * 0.20,
                          ),
                          const TitleText(
                            text: 'Account Details',
                            fontColor: AppColors.kWhite,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 28),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  const TitleText(
                                    text: 'Forgot Password?',
                                    fontColor: AppColors.kBlack,
                                    fontWeight: FontWeight.w800,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width: SizeConfig.w(context) * 0.9,
                                    child: Text(
                                      'Please complete the form below with your email to receive password reset link ',
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
                                    hintText: 'Enter E-mail',
                                    controller: value.emailController,
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Align(
                                      alignment: Alignment.center,
                                      child: Consumer<UserProvider>(
                                        builder: (context, value, child) {
                                          return value.isLoading
                                              ? const Center(
                                                  child:
                                                      CircularProgressIndicator())
                                              : CustomButton(
                                                  buttonText: "Send Link",
                                                  onTap: () {
                                                    value.sendPasswordResetLink(
                                                        context);
                                                  });
                                        },
                                      )),
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
              ],
            ),
          ),
        ));
  }
}
