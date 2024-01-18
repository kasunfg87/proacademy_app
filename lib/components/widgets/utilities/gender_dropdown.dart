import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proacademy_app/components/widgets/ui_support/sub_title02.dart';
import 'package:proacademy_app/provider/data_provider.dart';
import 'package:provider/provider.dart';
import 'app_colors.dart';

class GenderDropDown extends StatelessWidget {
  const GenderDropDown({
    required this.controller,
    Key? key,
  }) : super(key: key);
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 8),
          child: SubTitle02(title: 'Gender'),
        ),
        const SizedBox(
          height: 5,
        ),
        CustomDropdown(
          excludeSelected: true,
          hintText: 'Select Gender',
          hintStyle:
              GoogleFonts.poppins(color: AppColors.kBlack.withOpacity(0.6)),
          listItemStyle: GoogleFonts.poppins(),
          selectedStyle: GoogleFonts.poppins(),
          borderRadius: BorderRadius.circular(20),
          items: Provider.of<DataProvider>(context).genderList,
          controller: controller,
          borderSide: BorderSide(width: 1.0, color: Colors.grey.shade400),
        ),
      ],
    );
  }
}
