import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../models/objects.dart';
import '../ui_support/sub_title02.dart';
import '../ui_support/title_text.dart';

class CourseCategory extends StatelessWidget {
  const CourseCategory({
    super.key,
    required this.model,
  });

  final CourseModel model;

  @override
  Widget build(BuildContext context) {
    CollectionReference category =
        FirebaseFirestore.instance.collection('course_category');
    return FutureBuilder<DocumentSnapshot>(
      future: category.doc(model.category).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return TitleText(
            text: '${data['category_name']}',
            fontSize: 16,
            fontColor: const Color.fromARGB(255, 197, 149, 5),
          );
        }

        return const SubTitle02(title: 'Loading..');
      },
    );
  }
}
