import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:proacademy_app/components/widgets/utilities/db_helper.dart';
import 'package:proacademy_app/models/objects.dart';

// ----- CourseController class
class CourseController {
  // ----- Reference to the 'courses' collection in Firestore
  CollectionReference courses =
      FirebaseFirestore.instance.collection('courses');

  // ----- Reference to the 'bookmark' collection in Firestore
  CollectionReference bookmarks =
      FirebaseFirestore.instance.collection('bookmark');

  // ----- Reference to the 'enrolled' collection in Firestore
  CollectionReference enrolled =
      FirebaseFirestore.instance.collection('enrolled');

  // ----- Reference to the 'users' collection in Firestore
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  // ----- Fetch all courses
  Future<List<CourseModel>> getCourses() async {
    try {
      // ----- Query for fetching all the courses list
      QuerySnapshot snapshot = await courses.get();

      // ----- List to store the courses
      List<CourseModel> list = [];

      // ----- Mapping fetched data to CourseModel and storing them in the courses list
      for (var element in snapshot.docs) {
        // ----- Mapping to a single CourseModel
        CourseModel model =
            CourseModel.fromJson(element.data() as Map<String, dynamic>);
        // ----- Adding to the list
        list.add(model);
      }

      // ----- Return the courses list
      return list;
    } catch (e) {
      // ----- Error handling
      // ignore: avoid_print
      Logger().e(e);
      return [];
    }
  }

  // ----- Search courses by title
  Future<List<CourseModel>> searchCourseWithTitle(String searchText) async {
    try {
      // ----- Query for fetching courses that match the search text in their title
      QuerySnapshot snapshot =
          await courses.where('title', arrayContains: searchText).get();

      // ----- List to store the courses
      List<CourseModel> list = [];

      // ----- Mapping fetched data to CourseModel and storing them in the courses list
      for (var element in snapshot.docs) {
        // ----- Mapping to a single CourseModel
        CourseModel model =
            CourseModel.fromJson(element.data() as Map<String, dynamic>);
        // ----- Adding to the list
        list.add(model);
      }

      // ----- Return the courses list
      return list;
    } catch (e) {
      // ----- Error handling
      // ignore: avoid_print
      Logger().e(e);
      return [];
    }
  }

  // ----- Fetch favorite courses
  Future<List<BookmarkModel>> getFavoriteCourses() async {
    try {
      // ----- Query for fetching bookmarks that belong to the current user
      QuerySnapshot snapshot = await bookmarks
          .where('uid', isEqualTo: DBHelper.auth.currentUser!.uid)
          .get();

      // ----- List to store the bookmarks
      List<BookmarkModel> list = [];

      // ----- Mapping fetched data to BookmarkModel and storing them in the bookmarks list
      for (var element in snapshot.docs) {
        // ----- Mapping to a single BookmarkModel
        BookmarkModel model =
            BookmarkModel.fromJson(element.data() as Map<String, dynamic>);
        // ----- Adding to the list
        list.add(model);
      }

      // ----- Return the bookmarks list
      return list;
    } catch (e) {
      // ----- Error handling
      // ignore: avoid_print
      Logger().e(e);
      return [];
    }
  }

  // ----- Add a course to bookmarks
  Future<void> addToBookmark(BookmarkModel model) async {
    return bookmarks
        .doc()
        .set(
          model.toJson(),
          SetOptions(merge: true),
        )
        .then((value) => Logger().i("Added to favorites"))
        .catchError((error) => Logger().e("Failed to save data: $error"));
  }

  // ----- Remove a course from bookmarks
  Future<void> removeFromBookmark(BookmarkModel model) async {
    return await bookmarks
        .where('uid', isEqualTo: model.uid)
        .where('course_id', isEqualTo: model.course_id)
        .get()
        .then((value) => bookmarks.doc(value.docs[0].id).delete())
        .then((value) => Logger().i("Deleted from favorites"))
        .catchError((error) => Logger().e("Failed to delete data: $error"));
  }

  // ----- Check if a user is enrolled in a course
  Future<List<EnrolledModel>> checkEnrolled(int courseId) async {
    try {
      // ----- Query for fetching enrolled users for the given course ID
      QuerySnapshot snapshot =
          await enrolled.where('course_id', isEqualTo: courseId).get();

      // ----- List to store the enrolled users
      List<EnrolledModel> list = [];

      // ----- Mapping fetched data to EnrolledModel and storing them in the enrolled users list
      for (var element in snapshot.docs) {
        // ----- Mapping to a single EnrolledModel
        EnrolledModel model =
            EnrolledModel.fromJson(element.data() as Map<String, dynamic>);
        // ----- Adding to the list
        list.add(model);
      }

      // ----- Return the enrolled users list
      return list;
    } catch (e) {
      // ----- Error handling
      // ignore: avoid_print
      print(e);
      return [];
    }
  }

  // ----- Stream to get bookmarks for the current user
  Stream<QuerySnapshot> getBookmarkCourses() => bookmarks
      .where('uid', isEqualTo: DBHelper.auth.currentUser!.uid)
      .snapshots();

  // ----- Stream to get courses with a specific course ID
  Stream<QuerySnapshot> getCoursesWithId(int courseId) =>
      courses.where('course_id', isEqualTo: courseId).snapshots();

  // ----- Stream to get enrolled users for a specific course
  Stream<QuerySnapshot> getEnrolledUsers(int courseId) =>
      enrolled.where('course_id', isEqualTo: courseId).snapshots();

  // ----- Stream to get user details for a specific UID
  Stream<QuerySnapshot> getUsersDetails(String uid) =>
      users.where('uid', isEqualTo: uid).snapshots();

  // ----- Stream to get courses in which the current user is enrolled
  Stream<QuerySnapshot> getMyCoursesId() => enrolled.snapshots();

  // ----- Stream to get courses in progress for the current user
  Stream<QuerySnapshot> getCourseInProgress() =>
      enrolled.where('status', isEqualTo: 'on going').snapshots();

  // ----- Enroll a user in a course
  Future<void> enrollUser(CourseModel model, UserModel userModel) async {
    String docid = enrolled.doc().id;

    await enrolled
        .doc(docid)
        .set({
          'course_id': model.course_id,
          'status': 'on going',
          'user': userModel.toJson(),
          'last_update': DateTime.now().toString(),
        })
        .then((value) => Logger().i("Enrollment saved"))
        .catchError((error) => Logger().e("Failed to save data: $error"));
  }
}
