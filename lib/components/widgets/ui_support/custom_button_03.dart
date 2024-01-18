import 'package:flutter/material.dart';
import 'package:proacademy_app/components/widgets/ui_support/sub_title02.dart';
import 'package:proacademy_app/components/widgets/utilities/size_config.dart';

import '../utilities/app_colors.dart';

class CustomButton03 extends StatelessWidget {
  const CustomButton03({
    required this.text,
    required this.onTap,
    required this.buttonColor,
    super.key,
  });
  final String text;
  final Function() onTap;
  final Color buttonColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashFactory: InkRipple.splashFactory,
      onTap: onTap,
      child: Container(
        height: SizeConfig.w(context) * 0.115,
        width: SizeConfig.w(context) * 0.5,
        decoration: BoxDecoration(
            color: buttonColor, borderRadius: BorderRadius.circular(25)),
        child: Center(
            child: SubTitle02(
          fontSize: 18,
          title: text,
          fontColor: AppColors.kWhite,
        )),
      ),
    );
  }
}
