import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../utilities/app_colors.dart';

class FavouriteIcon extends StatelessWidget {
  const FavouriteIcon({
    this.isfavourite = false,
    super.key,
  });
  final bool isfavourite;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.only(top: 15, right: 15),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: AppColors.kWhite.withOpacity(0.9), shape: BoxShape.circle),
      child: isfavourite
          ? const Icon(
              FlutterRemix.bookmark_2_fill,
              color: AppColors.kPrimary,
            )
          : const Icon(FlutterRemix.bookmark_2_line),
    );
  }
}
