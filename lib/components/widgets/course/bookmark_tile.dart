import 'package:flutter/material.dart';
import 'package:proacademy_app/models/objects.dart';
import '../ui_support/fav_icon_controller.dart';
import '../ui_support/title_text.dart';
import '../utilities/app_colors.dart';
import '../utilities/size_config.dart';
import 'category.dart';

class BookmarkTile extends StatelessWidget {
  const BookmarkTile({
    required this.model,
    Key? key,
  }) : super(key: key);

  final CourseModel model;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.w(context) * 0.75,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: SizeConfig.h(context) * 0.25,
            decoration: BoxDecoration(
                image: DecorationImage(
                    filterQuality: FilterQuality.low,
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      model.img.toString(),
                    )),
                color: AppColors.kPrimary,
                borderRadius: BorderRadius.circular(15)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FavouriteIconController(model: model),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          CourseCategory(model: model),
          const SizedBox(
            height: 15,
          ),
          TitleText(
            text: model.title.toString(),
            fontSize: 22,
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
