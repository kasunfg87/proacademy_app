import 'package:flutter/material.dart';
import 'package:proacademy_app/components/widgets/utilities/app_colors.dart';
import 'package:proacademy_app/models/objects.dart';
import '../ui_support/title_text.dart';
import '../utilities/size_config.dart';
import 'category_mini.dart';

class CourseTileMini extends StatefulWidget {
  const CourseTileMini({
    required this.model,
    super.key,
  });

  final CourseModel model;

  @override
  State<CourseTileMini> createState() => _CourseTileMiniState();
}

class _CourseTileMiniState extends State<CourseTileMini> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.kgray.withOpacity(0.1)),
      child: Row(
        children: [
          Container(
            width: SizeConfig.w(context) * 0.18,
            height: SizeConfig.w(context) * 0.18,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      widget.model.img.toString(),
                    ))),
          ),
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            width: SizeConfig.w(context) * 0.65,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CourseCategoryMini(category: widget.model.category),
                const SizedBox(
                  height: 20,
                ),
                TitleText(
                  text: widget.model.title.toString(),
                  fontSize: 18,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
