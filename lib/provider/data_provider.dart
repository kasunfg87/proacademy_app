import 'package:flutter/material.dart';
import '../components/widgets/utilities/assets_constants.dart';

class DataProvider extends ChangeNotifier {
  // ----- image list

  final List<String> _imageList = [
    AssetConstants.image01,
    AssetConstants.image02,
    AssetConstants.image03,
  ];

  // -----get image list items

  List<String> get imageList => _imageList;

  // ----- title list 01

  final List<String> _titleList01 = [
    'Make it easy for yourself,',
    'Find The Best Online',
    'Learning Can be'
  ];

  // -----get title list 01 items

  List<String> get titleList01 => _titleList01;

  // ----- title list 02

  final List<String> _titleList02 = [
    'to learn anywhere',
    'Course',
    'Fun',
  ];

  // -----get title list 02 items

  List<String> get titleList02 => _titleList02;

  // ----- sub title list

  final List<String> _subTitle = [
    'One of the most important areas we can develop as professionals is competence in accessing and sharing knowledge.',
    'E-learning provides fantastic flexibility, and aids in making the task of arranging development opportunities far easier',
    "Learning should always be fun. They should be having a ball. It's amazing how much they remember when it is fun.",
  ];

  // -----get sub title list items

  List<String> get subTitle => _subTitle;

  // ----- gender list

  final List<String> _genderList = ['Male', 'Female', 'Other'];

  // -----get gender list items

  List<String> get genderList => _genderList;

  // --- list to store genre

  final List _genre = [
    'All Course',
    'Flutter',
    'UI Design',
    'UX Design',
    'Game Devolop',
  ];

  // ---- getter for genre list

  List get genere => _genre;

  String getCourseByIndex(int index) {
    switch (index) {
      case 1:
        return 'Flutter & Dart';
      case 2:
        return 'Game Development';
      case 3:
        return 'UX and UI Design';
      case 4:
        return 'React Native';
      default:
        return 'None';
    }
  }
}
