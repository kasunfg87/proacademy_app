import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:proacademy_app/components/widgets/ui_support/sub_title.dart';
import 'package:proacademy_app/components/widgets/utilities/navigation_function.dart';
import 'package:proacademy_app/provider/user_provider.dart';
import 'package:proacademy_app/screens/chat/widget/chat_bubble.dart';
import 'package:proacademy_app/screens/chat/widget/message_typing_widget.dart';
import 'package:provider/provider.dart';

import '../../components/widgets/utilities/app_colors.dart';
import '../../controller/chat_controller.dart';
import '../../models/objects.dart';

class Chat extends StatefulWidget {
  const Chat({required this.convId, required this.model, super.key});

  final String convId;
  final ConversationModel model;

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final List<MessageModel> _list = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Padding(
          padding: const EdgeInsets.only(top: 25),
          child: AppBar(
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: Container(
                  padding: const EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                      color: AppColors.kgray.withOpacity(0.2),
                      shape: BoxShape.circle),
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: AppColors.kBlack,
                    size: 18,
                  ),
                ),
              ),
            ),
            backgroundColor: AppColors.kWhite,
            elevation: 0,
            automaticallyImplyLeading: true,
            actions: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.more_vert_rounded,
                  color: AppColors.kBlack,
                ),
              )
            ],
            title: Consumer<UserProvider>(
              builder: (context, value, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.kgray,
                      radius: 25,
                      backgroundImage: CachedNetworkImageProvider(
                        widget.model.userArray
                            .firstWhere((e) => e.uid != value.userModel!.uid)
                            .img!,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SubTitleText(
                          text:
                              '${widget.model.userArray.firstWhere((e) => e.uid != value.userModel!.uid).firstName} ${widget.model.userArray.firstWhere((e) => e.uid != value.userModel!.uid).lastName}',
                          fontSize: 18,
                        ),
                        SubTitleText(
                          text: NavigationFunction.getTimeAgo(
                              widget.model.lastMassageTime.toString()),
                          fontColor: AppColors.kgray,
                          fontSize: 13,
                        ),
                      ],
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: ChatController().getMessages(widget.convId),
            builder: (context, snapshot) {
              // ----- if snapshot error occurs
              if (snapshot.hasError) {
                return const Center(
                    child: SubTitleText(text: 'No messages, error occured'));
              }
              //----- if the stream is still loading the data
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              //----- if the stream is still loading the data
              if (snapshot.data!.docs.isEmpty) {
                return const Center(
                    child: SubTitleText(text: 'No Messages Yet'));
              }

              // ----- clear list before add data
              _list.clear();

              for (var item in snapshot.data!.docs) {
                //
                Map<String, dynamic> data = item.data() as Map<String, dynamic>;

                var model = MessageModel.fromJson(data);

                _list.add(model);
              }
              Logger().d(_list.length);
              return Expanded(
                child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    reverse: true,
                    itemBuilder: (context, index) {
                      return Consumer<UserProvider>(
                        builder: (context, value, child) {
                          return ChatBubble(
                            model: _list[index],
                            isSender:
                                _list[index].senderId == value.userModel!.uid,
                          );
                        },
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 15,
                        ),
                    itemCount: _list.length),
              );
            },
          ),
          const MessageTypingWidget(),
        ],
      ),
    );
  }
}
