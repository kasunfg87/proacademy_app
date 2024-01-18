// ignore_for_file: file_names

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proacademy_app/provider/user_provider.dart';
import 'package:proacademy_app/screens/forgot_password/forgot_password.dart';
import 'package:provider/provider.dart';
import '../../components/widgets/ui_support/custom_button_01.dart';
import '../../components/widgets/ui_support/custom_textfield.dart';
import '../../components/widgets/ui_support/sub_title02.dart';
import '../../components/widgets/ui_support/title_text.dart';
import '../../components/widgets/utilities/app_colors.dart';
import '../../components/widgets/utilities/navigation_function.dart';
import '../../components/widgets/utilities/size_config.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

bool isChecked = false;

class _SignInState extends State<SignIn> {
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
                                    text: 'Student Sign In',
                                    fontColor: AppColors.kBlack,
                                    fontWeight: FontWeight.w800,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width: SizeConfig.w(context) * 0.9,
                                    child: Text(
                                      'Please complete the form below with your credentials to sign in your student account with Proacademy ',
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
                                    height: 15,
                                  ),
                                  CustomTextfield(
                                    isObscure: true,
                                    hintText: 'Enter Password',
                                    controller: value.passwordController,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  InkWell(
                                    onTap: () => NavigationFunction.navigateTo(
                                        BuildContext,
                                        context,
                                        Widget,
                                        const ForgotPassword()),
                                    child: const Align(
                                      alignment: Alignment.centerRight,
                                      child: SubTitle02(
                                        title: 'Forgot Password?',
                                        fontColor: AppColors.kPrimary,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
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
                                                  buttonText: "Sign In",
                                                  onTap: () {
                                                    value
                                                        .startLogin(context)
                                                        .whenComplete(() =>
                                                            value
                                                                .initializeUser(
                                                                    context));
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
