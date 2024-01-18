import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../ui_support/title_text.dart';
import '../utilities/db_helper.dart';

class CourseCategoryMini extends StatelessWidget {
  const CourseCategoryMini({
    super.key,
    required this.category,
  });

  final String category;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DBHelper.db
          .collection("course_category")
          .where("category", isEqualTo: category)
          .snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasData) {
          var arr = snapshot.data!.docs;
          if (arr.isEmpty) {
            return const Center(
              child: Text("Loading.."),
            );
          }
          return SizedBox(
            height: 17,
            width: 200,
            child: ListView.builder(
              itemCount: arr.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return TitleText(
                  text: arr[index].get("category_name"),
                  fontSize: 15,
                  fontColor: const Color.fromARGB(255, 197, 149, 5),
                );
              },
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
