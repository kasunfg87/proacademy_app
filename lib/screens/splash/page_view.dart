import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proacademy_app/provider/data_provider.dart';
import 'package:proacademy_app/screens/sign_in/signIn.dart';
import 'package:proacademy_app/screens/sign_up/signup01.dart';
import 'package:provider/provider.dart';
import '../../components/widgets/ui_support/custom_button_01.dart';
import '../../components/widgets/ui_support/sub_title.dart';
import '../../components/widgets/ui_support/sub_title02.dart';
import '../../components/widgets/ui_support/title_text.dart';
import '../../components/widgets/utilities/app_colors.dart';
import '../../components/widgets/utilities/navigation_function.dart';
import '../../components/widgets/utilities/size_config.dart';

class CustomPageView extends StatefulWidget {
  const CustomPageView({super.key});

  @override
  State<CustomPageView> createState() => _CustomPageViewState();
}

class _CustomPageViewState extends State<CustomPageView> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    super.initState();
  }

  // --- page controller
  final PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<DataProvider>(
      builder: (context, value, child) {
        return PageView.builder(
          controller: controller,
          itemCount: value.imageList.length,
          itemBuilder: (context, index) {
            return Container(
              width: double.maxFinite,
              height: double.maxFinite,
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(value.imageList[index]),
              )),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TitleText(text: value.titleList01[index]),
                    TitleText(text: value.titleList02[index]),
                    const SizedBox(
                      height: 15,
                    ),
                    SubTitleText(text: value.subTitle[index]),
                    const SizedBox(
                      height: 30,
                    ),
                    index == 2
                        ? const SizedBox()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(3, (indexDots) {
                              return SlideInLeft(
                                duration: const Duration(milliseconds: 400),
                                child: Container(
                                  margin: const EdgeInsets.only(left: 6),
                                  width: index == indexDots ? 25 : 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: index == indexDots
                                          ? AppColors.kPrimary
                                          : AppColors.kPrimary
                                              .withOpacity(0.3)),
                                ),
                              );
                            })),
                    const SizedBox(
                      height: 10,
                    ),
                    index == 2
                        ? BounceInDown(
                            duration: const Duration(milliseconds: 400),
                            child: Column(
                              children: [
                                CustomButton(
                                  buttonText: 'Register',
                                  onTap: () {
                                    NavigationFunction.navigateTo(BuildContext,
                                        context, Widget, const SignUp01());
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SubTitle02(
                                        title: 'Already Have an Account?'),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        NavigationFunction.navigateTo(
                                            BuildContext,
                                            context,
                                            Widget,
                                            const SignIn());
                                      },
                                      child: const SubTitle02(
                                        title: 'Login',
                                        fontColor: AppColors.kPrimary,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ))
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () => controller.animateToPage(3,
                                      duration:
                                          const Duration(milliseconds: 400),
                                      curve: Curves.easeInOut),
                                  child: Text(
                                    'Skip',
                                    style: GoogleFonts.poppins(
                                        color: Colors.black.withOpacity(0.5),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                FloatingActionButton(
                                  onPressed: () => controller.animateToPage(
                                      index + 1,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut),
                                  backgroundColor: AppColors.kPrimary,
                                  child: const Icon(
                                    Icons.arrow_forward_ios,
                                    color: AppColors.kWhite,
                                  ),
                                ),
                              ],
                            ),
                          ),
                    SizedBox(
                      height: SizeConfig.h(context) * 0.03,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    ));
  }
}
