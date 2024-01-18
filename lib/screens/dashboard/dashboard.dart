import 'package:badges/badges.dart' as badges;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proacademy_app/components/widgets/course/course_in_progress.dart';
import 'package:proacademy_app/provider/category_provider.dart';
import 'package:proacademy_app/provider/course_provider.dart';
import 'package:proacademy_app/provider/user_provider.dart';
import 'package:proacademy_app/screens/course_details/course_details.dart';
import 'package:provider/provider.dart';
import '../../components/widgets/course/course_tile.dart';
import '../../components/widgets/ui_support/search_widget.dart';
import '../../components/widgets/ui_support/title_text.dart';
import '../../components/widgets/utilities/app_colors.dart';
import '../../components/widgets/utilities/navigation_function.dart';
import '../../components/widgets/utilities/size_config.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_loadMoreCourses);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_loadMoreCourses);
    _scrollController.dispose();
    super.dispose();
  }

  void _loadMoreCourses() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_isLoadingMore) {
      setState(() {
        _isLoadingMore = true;
      });

      // Perform additional loading here
      // For example, you can call a method in your CourseProvider to fetch more courses

      setState(() {
        _isLoadingMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CourseProvider>(
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: AppColors.kWhite,
          body: SafeArea(
              child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Consumer<UserProvider>(
                            builder: (context, value, child) {
                              return value.isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.kPrimary,
                                      ),
                                    )
                                  : Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          radius: 23,
                                          backgroundImage:
                                              CachedNetworkImageProvider(
                                            value.userModel!.img.toString(),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TitleText(
                                              text:
                                                  'Hi, ${value.userModel!.firstName} ${value.userModel!.lastName}',
                                              fontSize: 19,
                                            ),
                                            Text(
                                              "Just a study lover",
                                              style: GoogleFonts.poppins(
                                                color: Colors.grey.shade500,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                            },
                          ),
                          const Row(
                            children: [
                              badges.Badge(
                                child: FaIcon(FontAwesomeIcons.bell),
                              ),
                              SizedBox(width: 25),
                              badges.Badge(
                                child: FaIcon(FontAwesomeIcons.message),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Search box not implemented
                    const SearchWidget(),
                    const SizedBox(height: 25),
                    SizedBox(
                      height: 48,
                      width: SizeConfig.w(context) * 0.9,
                      child: Consumer2<CategoryProvider, CourseProvider>(
                        builder: (context, value, value2, child) {
                          return ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return InkWell(
                                borderRadius: BorderRadius.circular(20),
                                onTap: () {
                                  setState(() {
                                    value.setSelectedIndex(index);
                                    value2.filterCoursesWithCategory(
                                      value.categorys[index].category
                                          .toString(),
                                    );
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 5,
                                    vertical: 5,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 17,
                                  ),
                                  decoration: BoxDecoration(
                                    color: value.selectedIndex == index
                                        ? AppColors.kPrimary
                                        : AppColors.kWhite,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: value.selectedIndex == index
                                          ? AppColors.kPrimary
                                          : AppColors.kBlack.withOpacity(0.3),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      value.categorys[index].category_name
                                          .toString(),
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 13,
                                        color: value.selectedIndex == index
                                            ? AppColors.kWhite
                                            : AppColors.kBlack.withOpacity(0.4),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(),
                            itemCount: value.categorys.length,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TitleText(
                          text: 'Featured Class',
                          fontSize: 22,
                        ),
                        TitleText(
                          text: 'See All',
                          fontSize: 15,
                          fontColor: Colors.amber,
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      width: SizeConfig.w(context),
                      height: SizeConfig.h(context) * 0.45,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Consumer<CourseProvider>(
                            builder: (context, value, child) {
                              return InkWell(
                                onTap: () {
                                  value.setCourse(
                                    value.filteredCourses.isNotEmpty
                                        ? value.filteredCourses[index]
                                        : value.courses[index],
                                  );

                                  NavigationFunction.navigateTo(
                                    BuildContext,
                                    context,
                                    Widget,
                                    CourseDetails(
                                      courseId: value.courseModel.course_id,
                                    ),
                                  );
                                },
                                child: CourseTile(
                                  model: value.filteredCourses.isEmpty
                                      ? value.courses[index]
                                      : value.filteredCourses[index],
                                ),
                              );
                            },
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 30),
                        itemCount: _isLoadingMore
                            ? value.courses.length + 1
                            : value.filteredCourses.isEmpty
                                ? value.courses.length
                                : value.filteredCourses.length,
                      ),
                    ),
                    if (_isLoadingMore)
                      const SizedBox(
                        height: 100,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.kPrimary,
                          ),
                        ),
                      ),
                    const SizedBox(height: 20),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TitleText(
                          text: 'Course in progress',
                          fontSize: 22,
                        ),
                        TitleText(
                          text: 'See All',
                          fontSize: 15,
                          fontColor: Colors.amber,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: SizeConfig.h(context) * 0.3,
                      child: const CourseInProgress(),
                    ),
                  ],
                ),
              ),
            ],
          )),
        );
      },
    );
  }
}
