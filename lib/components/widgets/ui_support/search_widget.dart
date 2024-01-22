import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proacademy_app/provider/course_provider.dart';
import 'package:provider/provider.dart';
import '../utilities/app_colors.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({
    super.key,
  });

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        setState(() {
          Provider.of<CourseProvider>(context, listen: false)
              .filterCourses(value);
        });
      },
      focusNode: FocusNode(canRequestFocus: false),
      style: GoogleFonts.poppins(fontSize: 16),
      decoration: InputDecoration(
        // filled: true,
        // fillColor: AppColors
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: const EdgeInsets.all(5),
        prefixIcon: Icon(
          Icons.search,
          color: AppColors.kBlack.withOpacity(0.3),
        ),
        hintText: 'Search ...',
        hintStyle: GoogleFonts.plusJakartaSans(
            color: AppColors.kBlack.withOpacity(0.4)),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
          borderSide: BorderSide(
            width: 2,
            color: Color.fromARGB(132, 65, 63, 63),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(30),
          ),
          borderSide: BorderSide(color: AppColors.kBlack.withOpacity(0.2)),
        ),
      ),
    );
  }
}
