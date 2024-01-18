// ignore_for_file: avoid_print

import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:proacademy_app/components/widgets/utilities/app_colors.dart';
import 'package:proacademy_app/provider/chat_provider.dart';
import 'package:provider/provider.dart';

class MessageTypingWidget extends StatelessWidget {
  const MessageTypingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MessageBar(
      
      messageBarColor: AppColors.kWhite,
      sendButtonColor: AppColors.kPrimary,
      
      onSend: (String msg) {
        Logger().d(msg);
        if (msg.trim().isNotEmpty) {
          //----- start send message

          Provider.of<ChatProvider>(context, listen: false)
              .startSendMessage(context, msg);
        }
      },
      actions: [
        InkWell(
          child: const Icon(
            Icons.add,
            color: Colors.black,
            size: 24,
          ),
          onTap: () {},
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: InkWell(
            child: const Icon(
              Icons.camera_alt,
              color: Colors.green,
              size: 24,
            ),
            onTap: () {},
          ),
        ),
      ],
    );
  }
}
