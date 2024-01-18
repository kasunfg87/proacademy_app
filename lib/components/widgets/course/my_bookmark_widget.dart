import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proacademy_app/controller/courese_controller.dart';
import '../../../models/objects.dart';
import 'bookmark_tile.dart';

class MyBookmarkWidget extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const MyBookmarkWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: CourseController().getBookmarkCourses(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final List<BookmarkModel> bookmarks = snapshot.data!.docs
            .map((doc) =>
                BookmarkModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList();

        return ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: bookmarks.length,
          itemBuilder: (context, index) {
            return StreamBuilder<QuerySnapshot>(
              stream: CourseController()
                  .getCoursesWithId(bookmarks[index].course_id),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final List<CourseModel> courses = snapshot.data!.docs
                    .map((doc) => CourseModel.fromJson(
                        doc.data() as Map<String, dynamic>))
                    .toList();

                return ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: courses.length,
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 50,
                  ),
                  itemBuilder: (context, index) {
                    return BookmarkTile(model: courses[index]);
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
