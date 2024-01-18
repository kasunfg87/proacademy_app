import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utilities/app_colors.dart';

class SubTitle02 extends StatelessWidget {
  final String title;
  final double fontSize;
  final Color fontColor;
  final FontWeight fontWeight;
  const SubTitle02({
    required this.title,
    this.fontSize = 15,
    this.fontColor = AppColors.kBlack,
    this.fontWeight = FontWeight.w600,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.poppins(
          color: fontColor.withOpacity(0.8),
          fontSize: fontSize,
          fontWeight: fontWeight),
    );
  }
}
