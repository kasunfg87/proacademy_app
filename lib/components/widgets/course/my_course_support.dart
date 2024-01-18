import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proacademy_app/components/widgets/course/course_tile_mini.dart';

import '../../../models/objects.dart';
import '../../../screens/course_details/course_details.dart';
import '../utilities/db_helper.dart';
import '../utilities/navigation_function.dart';

class MyCourseTile extends StatefulWidget {
  const MyCourseTile({required this.model, super.key});

  final EnrolledModel model;

  @override
  State<MyCourseTile> createState() => _MyCourseTileState();
}

class _MyCourseTileState extends State<MyCourseTile> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: DBHelper.db
            .collection("courses")
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

          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: filteredData.length,
            itemBuilder: (context, index) {
              return InkWell(
                  onTap: () {
                    NavigationFunction.navigateTo(BuildContext, context, Widget,
                        CourseDetails(courseId: filteredData[index].course_id));
                  },
                  child: CourseTileMini(model: filteredData[index]));
            },
          );
        });
  }
}
