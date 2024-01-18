import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utilities/app_colors.dart';

class SubTitleText extends StatelessWidget {
  const SubTitleText({
    required this.text,
    this.fontSize = 17,
    this.fontColor = AppColors.kBlack,
    this.textAlign = TextAlign.center,
    this.textOverflow = TextOverflow.visible,
    Key? key,
  }) : super(key: key);

  final String text;
  final double fontSize;
  final Color fontColor;
  final TextAlign textAlign;
  final TextOverflow textOverflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
          color: fontColor.withOpacity(0.6),
          fontSize: fontSize,
          fontWeight: FontWeight.w500),
      textAlign: textAlign,
      overflow: textOverflow,
    );
  }
}
