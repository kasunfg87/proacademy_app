import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:proacademy_app/components/widgets/ui_support/sub_title02.dart';
import 'package:proacademy_app/provider/data_provider.dart';
import 'package:provider/provider.dart';

class GenderDropDown extends StatelessWidget {
  const GenderDropDown({
    required this.controller,
    super.key,
  });
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 8),
          child: SubTitle02(title: 'Gender'),
        ),
        const SizedBox(
          height: 5,
        ),
        CustomDropdown(
          excludeSelected: true,
          hintText: 'Select Gender',
          items: Provider.of<DataProvider>(context).genderList,
          onChanged: (value) {},
        ),
      ],
    );
  }
}
