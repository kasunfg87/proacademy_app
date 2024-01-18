// ignore_for_file: avoid_print, unnecessary_null_comparison

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:proacademy_app/controller/courese_controller.dart';
import 'package:proacademy_app/models/objects.dart';

import '../components/widgets/utilities/alert_helper.dart';

class FavouriteProvider extends ChangeNotifier {
  // ----- add to favourites

  // ----- a list to store the favourites courses list

  List<BookmarkModel> _favCourses = [];

  // ----- getter for favourites product list

  List<BookmarkModel> get favCourses => _favCourses;

  bool _isLoading = false;

  // ----- get loading state

  bool get isLoading => _isLoading;

  // -----chage loading state

  void setLoading(bool val) {
    _isLoading = val;
  }

  final CourseController _courseController = CourseController();
  // ----- fetch products function

  Future<void> fetchFavouriteCourses() async {
    try {
      // ----- start the loader

      setLoading(true);

      // ----- start fetching products

      _favCourses = await _courseController.getFavoriteCourses();
      Logger().e(favCourses.length);
      notifyListeners();

      // ----- stop the loader

      setLoading(false);
    } catch (e) {
      print(e);
      // ----- stop the loader

      setLoading(false);
    }
  }

  // ----- adding clicked fav courses to the firebase

  void initAddToFav(BookmarkModel model, BuildContext context) {
    if (_favCourses.map((e) => e.course_id).contains(model.course_id)) {
      _courseController
          .removeFromBookmark(model)
          .whenComplete(() => fetchFavouriteCourses());

      AlertHelper.showSanckBar(
          context, 'Removed from Wishlist !', AnimatedSnackBarType.error);
      notifyListeners();
    } else {
      _courseController
          .addToBookmark(model)
          .whenComplete(() => fetchFavouriteCourses());

      AlertHelper.showSanckBar(
          context, 'Added to Wishlist !', AnimatedSnackBarType.success);
      notifyListeners();
    }
  }
}
