import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:proacademy_app/components/widgets/utilities/navigation_function.dart';
import 'package:proacademy_app/controller/chat_controller.dart';
import 'package:proacademy_app/models/objects.dart';
import 'package:proacademy_app/provider/user_provider.dart';
import 'package:proacademy_app/screens/chat/chat.dart';
import 'package:provider/provider.dart';

class ChatProvider extends ChangeNotifier {
  final ChatController _chatController = ChatController();

  // ----- create conversation loading index

  // ----- assigning a dummy value
  int _loadingIndex = -1;

  // ----- get loading index
  int get loadingIndex => _loadingIndex;

  // ----- set loading index
  void setLoadingIndex([int i = -1]) {
    _loadingIndex = i;
    notifyListeners();
  }

  late ConversationModel _conversationModel;

  ConversationModel get conversationModel => _conversationModel;

  void setConvModel(ConversationModel model) {
    _conversationModel = model;
    notifyListeners();
  }

  // ----- start crating a conversation

  Future<void> startCreateConversation(
      BuildContext context, UserModel peeruser, int i) async {
    try {
      // ----- getting the logged in userModel
      UserModel me =
          Provider.of<UserProvider>(context, listen: false).userModel!;

      // ----- srart the loader
      setLoadingIndex(i);

      _conversationModel =
          await _chatController.createConversation(me, peeruser);
      notifyListeners();

      // ----- stop the loader
      setLoadingIndex();
      // ----- navigate the user to the chat screen after creating the conversation
      // ignore: use_build_context_synchronously
      NavigationFunction.navigateTo(
          BuildContext,
          context,
          Widget,
          Chat(
            convId: _conversationModel.id,
            model: conversationModel,
          ));
    } catch (e) {
      // ----- stop the loader
      setLoadingIndex();
      Logger().i(e);
    }
  }

  //------ send message

  Future<void> startSendMessage(BuildContext context, String message) async {
    try {
      UserModel? me =
          Provider.of<UserProvider>(context, listen: false).userModel;

      await _chatController.sendMessage(
        conversationModel.id,
        me!.firstName,
        me.uid,
        conversationModel.userArray.firstWhere((e) => e.uid != me.uid).uid,
        message,
      );
    } catch (e) {
      Logger().e(e);
    }
  }
  //------- peer user model

  late UserModel _peerUser;

  UserModel get peerUser => _peerUser;

  void setPeeuser(UserModel model) {
    _peerUser = model;
  }

  //------ Conversation list
  List<ConversationModel> _convList = [];

  List<ConversationModel> get conList => _convList;

  void setConvList(List<ConversationModel> list) {
    _convList = list;
  }

  // ---- set conversation  model and send user to chat screen when notification is clicked
  void setNotificationData(BuildContext context, String id) {
    try {
      // find and set conv model
      ConversationModel temp = _convList.firstWhere((e) => e.id == id);

      setConvModel(temp);

      // ----- navigate the user to chat screen
      NavigationFunction.navigateTo(
        BuildContext,
        context,
        Widget,
        Chat(
          convId: id,
          model: conversationModel,
        ),
      );
    } catch (e) {
      Logger().e(e);
    }
  }
}
