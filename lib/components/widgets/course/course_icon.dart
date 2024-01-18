// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../ui_support/sub_title02.dart';
import '../utilities/app_colors.dart';

class CourseIcon extends StatelessWidget {
  const CourseIcon({
    required this.title01,
    required this.title02,
    required this.shapeIcon,
    required this.shapeColor,
    required this.iconColor,
    super.key,
  });
  final String title01;
  final String title02;
  final IconData shapeIcon;
  final Color shapeColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            padding: const EdgeInsets.all(12.0),
            decoration:
                BoxDecoration(color: shapeColor, shape: BoxShape.circle),
            child: Icon(
              shapeIcon,
              color: iconColor,
              size: 22,
            )),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SubTitle02(
              title: title01,
              fontSize: 14,
              fontColor: Colors.grey.shade500,
              fontWeight: FontWeight.w400,
            ),
            SubTitle02(
              title: title02,
              fontSize: 15,
              fontColor: AppColors.kBlack.withOpacity(0.5),
              fontWeight: FontWeight.w600,
            )
          ],
        )
      ],
    );
  }
}
