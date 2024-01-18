// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:proacademy_app/controller/category_controller.dart';
import 'package:proacademy_app/models/objects.dart';

class CategoryProvider extends ChangeNotifier {
  // ----- a list to store the course list

  List<CategoryModel> _categorys = [];

  // ----- getter for course list

  List<CategoryModel> get categorys => _categorys;

  // ----- getter for featured course list

  // ignore: prefer_final_fields
  List<CourseModel> _filteredCategorys = [];

  List<CourseModel> get filteredCategorys => _filteredCategorys;

  // ----- product controller instance

  final CategoryController _categoryController = CategoryController();

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  // ----- loading state

  bool _isLoading = false;

  // ----- get loading state

  bool get isLoading => _isLoading;

  // -----chage loading state

  void setLoading(bool val) {
    _isLoading = val;
  }

  // ----- fetch products function

  Future<void> fetchCategorys() async {
    try {
      // ----- start the loader

      setLoading(true);

      // ----- start fetching products

      _categorys = await _categoryController.getCategorys();

      // Add extra category to the list
      CategoryModel allCoursesCategory =
          CategoryModel(category: '0', category_name: 'All Courses');
      _categorys.insert(0, allCoursesCategory);

      print(_categorys.length);
      notifyListeners();

      // ----- stop the loader

      setLoading(false);
    } catch (e) {
      print(e);
      // ----- stop the loader

      setLoading(false);
    }
  }

  late CategoryModel _categoryModel;

  // ----- get the selected product model

  CategoryModel get categoryModel => _categoryModel;

  // ----- set the product model clicked on the product card

  void setCategory(CategoryModel model) {
    _categoryModel = model;
    notifyListeners();
  }
}
