import 'package:flutter/material.dart';
import 'package:proacademy_app/screens/wishlist/bookmark.dart';
import 'package:proacademy_app/screens/conversations/conversation.dart';

import '../screens/dashboard/dashboard.dart';
import '../screens/profile/profile.dart';

class ConfigProvider extends ChangeNotifier {
  // ----- current index
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setCurrentIndex(int val) {
    _currentIndex = val;
    notifyListeners();
  }

  final List _screens = [
    const Dashboard(),
    const Conversations(),
    const WishList(),
    const Profile()
  ];

  List get screens => _screens;

  // ----- current index
  final int _categoryIndex = 0;

  int get categoryIndex => _categoryIndex;
}
