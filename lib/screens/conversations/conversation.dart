import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:proacademy_app/components/widgets/ui_support/search_widget.dart';
import 'package:proacademy_app/components/widgets/ui_support/sub_title.dart';
import 'package:proacademy_app/components/widgets/utilities/app_colors.dart';
import 'package:proacademy_app/controller/chat_controller.dart';
import 'package:proacademy_app/models/objects.dart';
import 'package:proacademy_app/provider/chat_provider.dart';
import 'package:proacademy_app/provider/user_provider.dart';
import 'package:proacademy_app/screens/conversations/widget/conversation_card.dart';
import 'package:proacademy_app/screens/conversations/widget/header_widget.dart';
import 'package:provider/provider.dart';

class Conversations extends StatefulWidget {
  const Conversations({super.key});

  @override
  State<Conversations> createState() => _ConversationsState();
}

class _ConversationsState extends State<Conversations> {
  final List<ConversationModel> _list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const HeaderWidget(),
              const SizedBox(
                height: 10,
              ),
              const SearchWidget(),
              const SizedBox(
                height: 10,
              ),
              Consumer<UserProvider>(
                builder: (context, value, child) {
                  return StreamBuilder<QuerySnapshot>(
                    stream:
                        ChatController().getConversations(value.userModel!.uid),
                    builder: (context, snapshot) {
                      // ----- if snapshot error occurs
                      if (snapshot.hasError) {
                        return const Center(
                            child:
                                SubTitleText(text: 'No users, error occured'));
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
                        Map<String, dynamic> data =
                            item.data() as Map<String, dynamic>;

                        var model = ConversationModel.fromJson(data);

                        _list.add(model);
                      }
                      Provider.of<ChatProvider>(context, listen: false)
                          .setConvList(_list);
                      Logger().d(_list.length);
                      return Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              return ConversationCard(
                                model: _list[index],
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 15,
                                ),
                            itemCount: _list.length),
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
