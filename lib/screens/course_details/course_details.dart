import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:proacademy_app/components/widgets/course/enroll_button.dart';
import 'package:proacademy_app/components/widgets/course/enrolled_users_widget.dart';
import 'package:proacademy_app/components/widgets/ui_support/fav_icon_controller.dart';
import 'package:proacademy_app/components/widgets/ui_support/sub_title02.dart';
import 'package:proacademy_app/components/widgets/utilities/db_helper.dart';
import 'package:proacademy_app/components/widgets/utilities/size_config.dart';
import 'package:proacademy_app/models/objects.dart';
import 'package:proacademy_app/provider/course_provider.dart';
import 'package:proacademy_app/provider/user_provider.dart';
import 'package:provider/provider.dart';
import '../../components/widgets/course/category.dart';
import '../../components/widgets/course/course_icon.dart';
import '../../components/widgets/course/instructor_profile.dart';
import '../../components/widgets/ui_support/sub_title.dart';
import '../../components/widgets/ui_support/title_text.dart';
import '../../components/widgets/utilities/app_colors.dart';
import '../../provider/favourite_provider.dart';

class CourseDetails extends StatefulWidget {
  const CourseDetails({required this.courseId, super.key});

  final int courseId;

  @override
  State<CourseDetails> createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  @override
  void initState() {
    Provider.of<CourseProvider>(context, listen: false)
        .isEnrolledHasUsers(widget.courseId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<CourseProvider>(
      builder: (context, value, child) {
        final courseModel = value.courseModel;
        final enrolledUsers = value.enrolledUsers;
        final isUserEnrolled = enrolledUsers.any(
            (element) => element.user!.uid == DBHelper.auth.currentUser!.uid);

        return Scaffold(
          backgroundColor: AppColors.kWhite,
          body: Stack(
            children: [
              Container(
                height: double.maxFinite,
                width: double.maxFinite,
                color: const Color.fromARGB(246, 0, 3, 17),
              ),
              Image.network(
                courseModel.img.toString(),
                width: double.infinity,
                height: size.height * 0.4,
                fit: BoxFit.cover,
              ),
              const Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.transparent, AppColors.kWhite],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.1, 0.43],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: SizeConfig.h(context) * 0.050,
                left: 15,
                right: 15,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: AppColors.kWhite.withOpacity(0.7),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.arrow_back_ios_new),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Provider.of<FavouriteProvider>(context, listen: false)
                            .initAddToFav(
                          BookmarkModel(
                            category: courseModel.category,
                            course_id: courseModel.course_id,
                            title: courseModel.title.toString(),
                            uid: DBHelper.auth.currentUser!.uid,
                          ),
                          context,
                        );
                      },
                      child: FavouriteIconController(
                        model: courseModel,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: size.height * 0.36,
                left: 25,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CourseCategory(model: courseModel),
                          const SizedBox(height: 15),
                          SizedBox(
                            width: size.width * 0.9,
                            child: TitleText(
                              text: courseModel.title.toString(),
                              fontSize: 22,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              CourseIcon(
                                title01: 'Lessons',
                                title02: '${courseModel.lesson} Videos',
                                shapeIcon: FlutterRemix.video_line,
                                shapeColor: AppColors.kPrimary.withOpacity(0.1),
                                iconColor: Colors.green,
                              ),
                              const SizedBox(width: 30),
                              CourseIcon(
                                title01: 'Duration',
                                title02: courseModel.duration.toString(),
                                shapeIcon: FlutterRemix.time_line,
                                shapeColor: Colors.purple.withOpacity(0.1),
                                iconColor: Colors.purple,
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          InstructorProfile(model: courseModel),
                          const SizedBox(height: 20),
                          if (!isUserEnrolled && enrolledUsers.isNotEmpty)
                            Column(
                              children: [
                                SizedBox(
                                  height: 30,
                                  width: SizeConfig.w(context) * 0.9,
                                  child: const SubTitle02(
                                    title: 'People have joined',
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  height: 50,
                                  width: SizeConfig.w(context) * 0.9,
                                  child: EnrolledUsers(
                                    model: courseModel,
                                  ),
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          const TitleText(
                            text: 'Description',
                            fontSize: 20,
                          ),
                          const SizedBox(height: 15),
                          SizedBox(
                            height: SizeConfig.h(context) * 0.138,
                            width: size.width * 0.9,
                            child: Scrollbar(
                              thickness: 6.0,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: SubTitleText(
                                  text: courseModel.description.toString(),
                                  textAlign: TextAlign.justify,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 15,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SubTitleText(text: 'Price'),
                          const SizedBox(
                            height: 5,
                          ),
                          TitleText(
                              fontSize: 22,
                              text: '\$:${value.courseModel.price.toString()}'
                                  '.00')
                        ],
                      ),
                      Consumer<UserProvider>(
                        builder: (context, value, child) {
                          return EnrollButton(
                            model: courseModel,
                            userModel: value.userModel!,
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
