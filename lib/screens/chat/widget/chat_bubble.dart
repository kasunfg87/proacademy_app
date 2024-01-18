import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:flutter/material.dart';
import 'package:proacademy_app/components/widgets/ui_support/sub_title.dart';

import '../../../components/widgets/utilities/app_colors.dart';
import '../../../components/widgets/utilities/util_function.dart';
import '../../../models/objects.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    required this.model,
    required this.isSender,
    Key? key,
  }) : super(key: key);

  final MessageModel model;

  final bool isSender;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        BubbleSpecialOne(
          text: model.message,
          color: isSender ? AppColors.kPrimary : const Color(0xFF1B77F5),
          textStyle: const TextStyle(color: Colors.white, fontSize: 18),
          isSender: isSender,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 24, left: 24),
          child: SubTitleText(
            text: UtilFunction.getTimeAgo(model.messageTime),
            fontColor: AppColors.kgray,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
