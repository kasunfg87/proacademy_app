import 'package:age_calculator/age_calculator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_datetime_picker_bdaya/flutter_datetime_picker_bdaya.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:proacademy_app/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'app_colors.dart';
import 'size_config.dart';

class BirthdayPicker {
  static Future<dynamic> showBirthDayPicker(BuildContext context) async {
    DateDuration? duration;
    return DatePickerBdaya.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime(1980, 3, 5),
        maxTime: DateTime(2023, 1, 1),
        theme: DatePickerThemeBdaya(
            itemHeight: 40,
            headerColor: AppColors.kPrimary,
            itemStyle:
                GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),
            doneStyle: GoogleFonts.poppins(
                color: AppColors.kWhite,
                fontSize: 18,
                fontWeight: FontWeight.w600),
            cancelStyle: GoogleFonts.poppins(
                color: AppColors.kWhite,
                fontSize: 16,
                fontWeight: FontWeight.w600),
            containerHeight: SizeConfig.h(context) * 0.3), onConfirm: (date) {
      Provider.of<UserProvider>(context, listen: false)
          .birthDayController
          .text = DateFormat('yyyy/MM/dd').format(date).toString();
      duration = AgeCalculator.age(date);
      Provider.of<UserProvider>(context, listen: false).ageController.text =
          duration!.years.toString();
      Logger().e(date);
    }, currentTime: DateTime.now(), locale: LocaleType.en);
  }
}
