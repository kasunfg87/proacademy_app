import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:proacademy_app/components/widgets/ui_support/sub_title.dart';
import 'package:proacademy_app/components/widgets/utilities/app_colors.dart';
import 'package:proacademy_app/components/widgets/utilities/navigation_function.dart';
import 'package:proacademy_app/components/widgets/utilities/size_config.dart';
import 'package:proacademy_app/models/objects.dart';
import 'package:proacademy_app/provider/chat_provider.dart';
import 'package:proacademy_app/provider/user_provider.dart';
import 'package:proacademy_app/screens/chat/chat.dart';
import 'package:provider/provider.dart';

class ConversationCard extends StatefulWidget {
  const ConversationCard({
    required this.model,
    Key? key,
  }) : super(key: key);
  final ConversationModel model;

  @override
  State<ConversationCard> createState() => _ConversationCardState();
}

class _ConversationCardState extends State<ConversationCard> {
  @override
  void initState() {
    Logger().d(widget.model.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<ChatProvider>(context, listen: false)
            .setConvModel(widget.model);
        NavigationFunction.navigateTo(
            BuildContext,
            context,
            Widget,
            Chat(
              convId: widget.model.id,
              model: widget.model,
            ));
      },
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 0),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          decoration: BoxDecoration(
              color: AppColors.kgray.withOpacity(0.04),
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Consumer<UserProvider>(
                builder: (context, value, child) {
                  return Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.kgray,
                        radius: 35,
                        backgroundImage: CachedNetworkImageProvider(
                          widget.model.userArray
                              .firstWhere((e) => e.uid != value.userModel!.uid)
                              .img!,
                        ),
                        child: Align(
                            alignment: Alignment.bottomRight,
                            child: widget.model.userArray
                                        .firstWhere((e) =>
                                            e.uid != value.userModel!.uid)
                                        .isOnline ==
                                    true
                                ? Container(
                                    height: 15,
                                    width: 15,
                                    decoration: const BoxDecoration(
                                      color: AppColors.kPrimary,
                                      shape: BoxShape.circle,
                                    ),
                                  )
                                : const SizedBox()),
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
                          SizedBox(
                            width: SizeConfig.w(context) * 0.65,
                            child: SubTitleText(
                              textAlign: TextAlign.left,
                              textOverflow: TextOverflow.ellipsis,
                              text: widget.model.lastMassage.toString(),
                              fontColor: AppColors.kgray,
                              fontSize: 15,
                            ),
                          ),
                          SubTitleText(
                            text: NavigationFunction.getTimeAgo(
                                widget.model.lastMassageTime.toString()),
                            fontColor: AppColors.kgray,
                            fontSize: 12,
                          ),
                        ],
                      )
                    ],
                  );
                },
              ),
            ],
          )),
    );
  }
}
