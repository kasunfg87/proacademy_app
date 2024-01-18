import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utilities/app_colors.dart';

class CustomButton02 extends StatelessWidget {
  const CustomButton02({
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        borderRadius: BorderRadius.circular(25),
        splashFactory: InkRipple.splashFactory,
        splashColor: Colors.blue.shade100,
        onTap: onTap,
        child: Container(
            height: 60,
            width: 70,
            decoration: BoxDecoration(
              color: AppColors.kPrimary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
                child: FaIcon(
              FontAwesomeIcons.arrowRight,
              color: AppColors.kWhite,
              size: 27,
            ))));
  }
}
