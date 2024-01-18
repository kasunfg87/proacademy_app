import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:proacademy_app/components/widgets/utilities/app_colors.dart';
import 'package:proacademy_app/provider/category_provider.dart';
import 'package:proacademy_app/provider/course_provider.dart';
import 'package:proacademy_app/provider/favourite_provider.dart';
import 'package:provider/provider.dart';
import '../../components/widgets/utilities/size_config.dart';
import '../../provider/config_provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    Provider.of<CourseProvider>(context, listen: false).fetchCourses();
    Provider.of<FavouriteProvider>(context, listen: false)
        .fetchFavouriteCourses();
    Provider.of<CategoryProvider>(context, listen: false).fetchCategorys();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Consumer<ConfigProvider>(
          builder: (context, value, child) {
            return SizedBox(
              width: SizeConfig.w(context),
              height: SizeConfig.h(context),
              child: Scaffold(
                bottomNavigationBar: CustomNavigationBar(
                    backgroundColor: AppColors.kWhite,
                    onTap: (index) =>
                        setState(() => value.setCurrentIndex(index)),
                    selectedColor: AppColors.kPrimary,
                    unSelectedColor: AppColors.kgray,
                    strokeColor: AppColors.kPrimary,
                    currentIndex: value.currentIndex,
                    items: [
                      CustomNavigationBarItem(
                        icon: const Icon(
                          FlutterRemix.home_fill,
                          size: 30,
                        ),
                      ),
                      CustomNavigationBarItem(
                        icon: const Icon(
                          FlutterRemix.chat_1_line,
                          size: 30,
                        ),
                      ),
                      CustomNavigationBarItem(
                        icon: const Icon(
                          FlutterRemix.bookmark_2_line,
                          size: 30,
                        ),
                      ),
                      CustomNavigationBarItem(
                        icon: const Icon(
                          FlutterRemix.user_3_fill,
                          size: 30,
                        ),
                      ),
                    ]),
                body: value.screens[value.currentIndex],
              ),
            );
          },
        ));
  }
}
