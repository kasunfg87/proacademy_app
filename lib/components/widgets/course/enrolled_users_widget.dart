import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:proacademy_app/components/widgets/utilities/app_colors.dart';
import 'package:proacademy_app/components/widgets/utilities/db_helper.dart';
import 'package:proacademy_app/controller/courese_controller.dart';
import 'package:proacademy_app/provider/chat_provider.dart';
import 'package:provider/provider.dart';
import '../../../models/objects.dart';

class EnrolledUsers extends StatefulWidget {
  const EnrolledUsers({required this.model, super.key});
  final CourseModel model;

  @override
  State<EnrolledUsers> createState() => _EnrolledUsersState();
}

class _EnrolledUsersState extends State<EnrolledUsers> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: CourseController().getEnrolledUsers(widget.model.course_id),
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
          Logger().d(enrolledUsers.length);

          return ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: enrolledUsers.length,
            separatorBuilder: (context, index) => const SizedBox(
              width: 0,
            ),
            itemBuilder: (context, index) {
              return StreamBuilder<QuerySnapshot>(
                  stream: CourseController()
                      .getUsersDetails(enrolledUsers[index].user!.uid),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    // ----- list to store snapshot data

                    List<UserModel> filteredData = [];

                    for (var element in snapshot.data!.docs) {
                      // ----- mapping to a single enrolled model

                      UserModel model = UserModel.fromJson(
                          element.data() as Map<String, dynamic>);

                      // ----- checking current user exsist or not then adding to the list
                      if (model.uid != DBHelper.auth.currentUser!.uid) {
                        filteredData.add(model);
                      }
                    }

                    return ListView.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Consumer<ChatProvider>(
                            builder: (context, value, child) {
                              return InkWell(
                                onTap: () {
                                  value.startCreateConversation(
                                      context, filteredData[index], index);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: CircleAvatar(
                                    backgroundColor: AppColors.kgray,
                                    radius: 30,
                                    backgroundImage: CachedNetworkImageProvider(
                                      filteredData[index].img.toString(),
                                    ),
                                    child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: filteredData[index].isOnline ==
                                                true
                                            ? Container(
                                                height: 10,
                                                width: 10,
                                                decoration: const BoxDecoration(
                                                  color: AppColors.kPrimary,
                                                  shape: BoxShape.circle,
                                                ),
                                              )
                                            : const SizedBox()),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                              width: 0,
                            ),
                        itemCount: filteredData.length);
                  });
            },
          );
        });
  }
}
