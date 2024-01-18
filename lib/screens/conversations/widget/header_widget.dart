import 'package:flutter/material.dart';
import 'package:proacademy_app/components/widgets/ui_support/title_text.dart';
import 'package:proacademy_app/provider/user_provider.dart';
import 'package:provider/provider.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, value, child) {
        return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    TitleText(
                      text: 'Message',
                      fontSize: 22,
                    ),
                  ],
                ),
              ],
            ));
      },
    );
  }
}
