import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proacademy_app/components/widgets/ui_support/sub_title02.dart';

import '../../../models/objects.dart';
import 'instrutor_widget.dart';

class InstructorProfile extends StatelessWidget {
  const InstructorProfile({
    super.key,
    required this.model,
  });

  final CourseModel model;

  @override
  Widget build(BuildContext context) {
    CollectionReference instructor =
        FirebaseFirestore.instance.collection('instructor');
    return FutureBuilder<DocumentSnapshot>(
      future: instructor.doc(model.instructor).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return InstructorWidget(
              name: '${data['name']}', image: '${data['img']}');
        }

        return const SubTitle02(title: 'Loading..');
      },
    );
  }
}
