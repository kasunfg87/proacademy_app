import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proacademy_app/components/widgets/ui_support/sub_title02.dart';
import '../utilities/app_colors.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    this.controller,
    this.textInputType = TextInputType.name,
    required this.hintText,
    this.isObscure = false,
    this.suffixIcon,
    this.readOnly = false,
    this.textOnTap,
    Key? key,
  }) : super(key: key);
  final TextEditingController? controller;

  final String hintText;
  final bool isObscure;
  final Widget? suffixIcon;
  final TextInputType textInputType;
  final bool readOnly;
  final Function()? textOnTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: SubTitle02(title: hintText),
        ),
        const SizedBox(
          height: 5,
        ),
        TextField(
          onTap: textOnTap,
          readOnly: readOnly,
          keyboardType: textInputType,
          style: GoogleFonts.poppins(fontSize: 16),
          obscureText: isObscure,
          controller: controller,
          decoration: InputDecoration(
            // floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: const EdgeInsets.only(left: 25),
            suffixIcon: suffixIcon,

            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              borderSide: BorderSide(
                width: 2,
                color: AppColors.kPrimary,
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }
}
