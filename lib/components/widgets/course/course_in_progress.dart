import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proacademy_app/components/widgets/course/course_in_progress_tile.dart';
import 'package:proacademy_app/components/widgets/utilities/db_helper.dart';
import 'package:proacademy_app/controller/courese_controller.dart';

import '../../../models/objects.dart';
import '../../../screens/course_details/course_details.dart';
import '../utilities/navigation_function.dart';

class CourseInProgress extends StatefulWidget {
  const CourseInProgress({super.key});

  @override
  State<CourseInProgress> createState() => _CourseInProgressState();
}

class _CourseInProgressState extends State<CourseInProgress> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: CourseController().getCourseInProgress(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // ----- list to store snapshot data

          List<EnrolledModel> filteredData = [];

          for (var element in snapshot.data!.docs) {
            // ----- mapping to a single enrolled model

            EnrolledModel model =
                EnrolledModel.fromJson(element.data() as Map<String, dynamic>);

            // ----- adding to list
            if (model.user!.uid == DBHelper.auth.currentUser!.uid) {
              filteredData.add(model);
            }
          }

          return ListView.separated(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: filteredData.length,
            itemBuilder: (context, index) {
              return StreamBuilder<QuerySnapshot>(
                  stream: CourseController()
                      .getCoursesWithId(filteredData[index].course_id),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasError) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    // ----- list to store snapshot data

                    List<CourseModel> filteredData = [];

                    for (var element in snapshot.data!.docs) {
                      // ----- mapping to a single enrolled model

                      CourseModel model = CourseModel.fromJson(
                          element.data() as Map<String, dynamic>);

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
                              NavigationFunction.navigateTo(
                                  BuildContext,
                                  context,
                                  Widget,
                                  CourseDetails(
                                      courseId: filteredData[index].course_id));
                            },
                            child: CourseInProgressTile(
                                model: filteredData[index]));
                      },
                    );
                  });
            },
            separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
          );
        });
  }
}
