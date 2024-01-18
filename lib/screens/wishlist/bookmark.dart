import 'package:flutter/material.dart';
import 'package:proacademy_app/components/widgets/course/my_bookmark_widget.dart';
import 'package:proacademy_app/components/widgets/utilities/app_colors.dart';
import '../../components/widgets/ui_support/title_text.dart';

class WishList extends StatelessWidget {
  const WishList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: AppBar(
            leading: null,
            actions: null,
            backgroundColor: AppColors.kWhite,
            elevation: 0,
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TitleText(
                  text: 'My Wishlist',
                  fontSize: 22,
                ),
              ],
            ),
          ),
        ),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              MyBookmarkWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
