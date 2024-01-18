// ignore_for_file: avoid_types_as_parameter_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class UtilFunction {
  static void navigateTo(BuildContext, context, Widget, widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }

  static String getTimeAgo(String date) => timeago.format(DateTime.parse(date));
}
