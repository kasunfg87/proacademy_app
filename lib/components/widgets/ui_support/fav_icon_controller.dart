import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:proacademy_app/components/widgets/ui_support/fav_icon_widget.dart';

import '../../../models/objects.dart';
import '../utilities/db_helper.dart';

class FavouriteIconController extends StatefulWidget {
  const FavouriteIconController({required this.model, super.key});
  final CourseModel model;

  @override
  State<FavouriteIconController> createState() =>
      _FavouriteIconControllerState();
}

class _FavouriteIconControllerState extends State<FavouriteIconController> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: DBHelper.db
            .collection("bookmark")
            .where('uid', isEqualTo: DBHelper.auth.currentUser!.uid)
            .where("course_id", isEqualTo: widget.model.course_id)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // ----- list to store snapshot data

          List<CourseModel> filteredData = [];

          for (var element in snapshot.data!.docs) {
            // ----- mapping to a single enrolled model

            CourseModel model =
                CourseModel.fromJson(element.data() as Map<String, dynamic>);

            // ----- adding to list
            filteredData.add(model);
          }
          Logger().e(filteredData.length);
          if (filteredData.isNotEmpty) {
            return const FavouriteIcon(isfavourite: true);
          } else {
            return const FavouriteIcon();
          }
        });
  }
}
