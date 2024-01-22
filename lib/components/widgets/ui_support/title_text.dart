import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utilities/app_colors.dart';

class TitleText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color fontColor;
  final FontWeight fontWeight;

  const TitleText({
    required this.text,
    this.fontSize = 25,
    this.fontColor = AppColors.kBlack,
    this.fontWeight = FontWeight.w700,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      // overflow: TextOverflow.ellipsis,
      style: GoogleFonts.plusJakartaSans(
        color: fontColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
