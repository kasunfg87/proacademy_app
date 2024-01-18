// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:proacademy_app/controller/courese_controller.dart';
import 'package:proacademy_app/models/objects.dart';

class CourseProvider extends ChangeNotifier {
  CollectionReference enrolled =
      FirebaseFirestore.instance.collection('enrolled');
  // ----- a list to store the course list

  List<CourseModel> _courses = [];

  // ----- getter for course list

  List<CourseModel> get courses => _courses;

  // ----- getter for featured course list

  List<CourseModel> _filteredCourses = [];

  List<CourseModel> get filteredCourses => _filteredCourses;

  List<CourseModel> get featuredCourses {
    List<CourseModel> temp = [];
    // ----- filtering the course list
    // ----- removing the already selceted courese
    for (var i = 0; i < _courses.length; i++) {
      if (_courses[i].course_id != _courseModel.course_id) {
        temp.add(_courses[i]);
      }
    }
    return temp;
  }

  // ----- product controller instance

  final CourseController _courseController = CourseController();

  // ----- loading state

  bool _isLoading = false;

  // ----- get loading state

  bool get isLoading => _isLoading;

  // -----chage loading state

  void setLoading(bool val) {
    _isLoading = val;
  }

  // ----- fetch products function

  Future<void> fetchCourses() async {
    try {
      // ----- start the loader

      setLoading(true);

      // ----- start fetching products

      _courses = await _courseController.getCourses();

      print(courses.length);
      notifyListeners();

      // ----- stop the loader

      setLoading(false);
    } catch (e) {
      print(e);
      // ----- stop the loader

      setLoading(false);
    }
  }

  Future<void> filterCourses(String searchText) async {
    // create an empty list to store filtered courses
    List<CourseModel> filteredList = [];

    // if search text is empty, show all courses
    if (searchText.isEmpty) {
      filteredList = _courses;
    } else {
      // loop through each course and check if its title contains the search text
      for (var course in _courses) {
        if (course.title!.toLowerCase().contains(searchText.toLowerCase())) {
          // if the course title contains the search text, add it to the filtered list
          filteredList.add(course);
        }
      }
    }

    // update the state of the filtered courses list
    _filteredCourses = filteredList;
    notifyListeners();
  }

  Future<void> filterCoursesWithCategory(String category) async {
    // create an empty list to store filtered courses
    List<CourseModel> filteredList = [];

    // if search text is empty or equal to 0, show all courses
    if (category.isEmpty || category == '0') {
      filteredList = _courses;
    } else {
      // loop through each course and check if its title contains the search text
      for (var course in _courses) {
        if (course.category.contains(category)) {
          // if the course title contains the search text, add it to the filtered list
          filteredList.add(course);
        }
      }
    }

    // update the state of the filtered courses list
    _filteredCourses = filteredList;
    notifyListeners();
  }

  // ----- add to favourites

  // ----- a list to store the favourites product list

  final List<CourseModel> _favCourses = [];

  // ----- getter for favourites product list

  List<CourseModel> get favCourses => _favCourses;

  // ----- adding clicked fav product to the list

  void initAddToFav(CourseModel model, BuildContext context) {
    if (_favCourses.contains(model)) {
      // ----- removing clicked fav porduct from the list
      _favCourses.remove(model);
      // show snackbar

      // AlertHelper.showSanckBar(
      //     context, 'Removed from favourites !', AnimatedSnackBarType.info);

      notifyListeners();
    } else {
      // ----- adding clicked fav porduct to the list
      _favCourses.add(model);
      // show snackbar

      // AlertHelper.showSanckBar(
      //     context, 'Added to favourites !', AnimatedSnackBarType.success);
      notifyListeners();
    }
  }

  // ----- product details screen

  // ----- to store the selected product model

  late CourseModel _courseModel;

  // ----- get the selected product model

  CourseModel get courseModel => _courseModel;

  // ----- set the product model clicked on the product card

  void setCourse(CourseModel model) {
    _courseModel = model;
    notifyListeners();
  }

  late List<EnrolledModel> _enrolledUsers = [];

  // ----- getter for favourites product list

  List<EnrolledModel> get enrolledUsers => _enrolledUsers;

  Future<void> isEnrolledHasUsers(int courseId) async {
    _enrolledUsers = await CourseController().checkEnrolled(courseId);
    notifyListeners();
  }

  // ---- start enroll user

  Future<void> enrollNow(CourseModel model, UserModel userModel) async {
    try {
      await CourseController().enrollUser(model, userModel);
    } catch (e) {
      Logger().e(e);
    }
  }
}
