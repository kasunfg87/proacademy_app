import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proacademy_app/components/widgets/ui_support/custom_button_03.dart';
import 'package:proacademy_app/components/widgets/utilities/app_colors.dart';
import 'package:proacademy_app/components/widgets/utilities/db_helper.dart';
import 'package:proacademy_app/controller/courese_controller.dart';
import 'package:proacademy_app/provider/course_provider.dart';
import 'package:provider/provider.dart';
import '../../../models/objects.dart';

class EnrollButton extends StatelessWidget {
  const EnrollButton({required this.model, required this.userModel, super.key});
  final CourseModel model;
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: CourseController().getEnrolledUsers(model.course_id),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // ----- list to store snapshot data

          List<EnrolledModel> enrolledUsers = [];

          for (var element in snapshot.data!.docs) {
            // ----- mapping to a single enrolled model

            EnrolledModel model =
                EnrolledModel.fromJson(element.data() as Map<String, dynamic>);

            // ----- adding to list
            enrolledUsers.add(model);
          }

          // ignore: iterable_contains_unrelated_type
          if (enrolledUsers.any((element) =>
              element.user!.uid == DBHelper.auth.currentUser!.uid)) {
            return CustomButton03(
              text: 'Enrolled',
              buttonColor: AppColors.kgray,
              onTap: () {},
            );
          } else {
            return CustomButton03(
              text: 'Enroll Now',
              onTap: () {
                Provider.of<CourseProvider>(context, listen: false)
                    .enrollNow(model, userModel);
              },
              buttonColor: AppColors.kPrimary,
            );
          }
        });
  }
}
