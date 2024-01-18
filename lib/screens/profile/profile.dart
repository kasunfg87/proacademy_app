import 'package:flutter/material.dart';
import 'package:proacademy_app/components/widgets/course/my_course_widget.dart';
import 'package:proacademy_app/components/widgets/utilities/navigation_function.dart';
import 'package:proacademy_app/controller/auth_controller.dart';
import 'package:proacademy_app/screens/sign_in/signin.dart';
import 'package:provider/provider.dart';
import '../../components/widgets/ui_support/sub_title02.dart';
import '../../components/widgets/ui_support/title_text.dart';
import '../../components/widgets/utilities/app_colors.dart';
import '../../provider/user_provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, value, child) {
        return Scaffold(
            backgroundColor: AppColors.kWhite,
            body: SafeArea(
                child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    const TitleText(
                      text: 'Profile',
                      fontSize: 22,
                    ),
                    IconButton(
                        onPressed: () {
                          AuthController().logOut(context).whenComplete(() {
                            NavigationFunction.navigateTo(
                                BuildContext, context, Widget, const SignIn());
                          });
                        },
                        icon: const Icon(
                          Icons.logout,
                          size: 28,
                        ))
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                value.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : InkWell(
                        onTap: () => value.selectImageAndUpload(),
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 65,
                          backgroundImage:
                              NetworkImage(value.userModel!.img.toString()),
                        ),
                      ),
                const SizedBox(
                  height: 20,
                ),
                SubTitle02(
                  title:
                      '${value.userModel!.firstName} ${value.userModel!.lastName}',
                  fontSize: 20,
                  fontColor: AppColors.kBlack.withOpacity(0.5),
                ),
                const SubTitle02(
                  title: 'Member',
                  fontSize: 14,
                  fontColor: Colors.grey,
                ),
                const SizedBox(
                  height: 40,
                ),
                // CustomButton03(
                //   buttonColor: AppColors.kPrimary,
                //   text: 'Sign Out',
                //   onTap: () {
                //     AuthController().logOut(context).whenComplete(() =>
                //         NavigationFunction.navigateTo(
                //             BuildContext, context, Widget, const SignIn()));
                //   },
                // ),

                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    TitleText(
                      text: 'My Courses',
                      fontSize: 18,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const MyCourseWidget())
              ],
            )));
      },
    );
  }
}
