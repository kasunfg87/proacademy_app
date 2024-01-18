import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:proacademy_app/models/objects.dart';

import '../components/widgets/utilities/db_helper.dart';

class CourseInProgressController {
  // ----- Initialize CollectionReference for 'courses' and 'enrolled' in Firestore.

  CollectionReference courses =
      FirebaseFirestore.instance.collection('courses');

  CollectionReference enrolled =
      FirebaseFirestore.instance.collection('enrolled');

  // ----- Asynchronously fetches the list of enrolled courses for the current user with 'on going' status.

  Future<List<EnrolledModel>> getEnrolled() async {
    try {
      // ----- Query for fetching all the enrolled courses for the current user with 'on going' status.

      QuerySnapshot snapshot = await enrolled
          .where('uid', isEqualTo: DBHelper.auth.currentUser!.uid)
          .where("status", isEqualTo: "on going")
          .get();

      // ----- Initialize an empty list to store EnrolledModel objects.

      List<EnrolledModel> list = [];

      // ----- Map the fetched data to EnrolledModel objects and store them in the 'list'.

      for (var element in snapshot.docs) {
        // ----- Map to a single EnrolledModel object.
        EnrolledModel model =
            EnrolledModel.fromJson(element.data() as Map<String, dynamic>);
        // ----- Add the EnrolledModel object to the list.
        list.add(model);
      }

      // ----- Return the list of enrolled courses.
      return list;
    } catch (e) {
      // ----- If an error occurs during the process, print the error and return an empty list.
      // ignore: avoid_print
      print(e);
      return [];
    }
  }

  // ----- Asynchronously fetches the list of CourseModel objects for a specific courseId.

  Future<List<CourseModel>> getCourseInProgress(String courseId) async {
    try {
      // ----- Print the courseId for debugging purposes.
      Logger().d(courseId);

      // ----- Query for fetching all the courses with the specified courseId.
      QuerySnapshot snapshot =
          await courses.where("course_id", isEqualTo: courseId).get();

      // ----- Initialize an empty list to store CourseModel objects.
      List<CourseModel> list = [];

      // ----- Map the fetched data to CourseModel objects and store them in the 'list'.

      for (var element in snapshot.docs) {
        // ----- Map to a single CourseModel object.
        CourseModel model =
            CourseModel.fromJson(element.data() as Map<String, dynamic>);
        // ----- Add the CourseModel object to the list.
        list.add(model);
      }

      // ----- Return the list of courses with the specified courseId.
      return list;
    } catch (e) {
      // ----- If an error occurs during the process, print the error and return an empty list.
      // ignore: avoid_print
      print(e);
      return [];
    }
  }
}
