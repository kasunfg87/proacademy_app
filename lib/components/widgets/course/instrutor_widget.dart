import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proacademy_app/components/widgets/ui_support/title_text.dart';

class InstructorWidget extends StatelessWidget {
  const InstructorWidget({
    required this.name,
    required this.image,
    super.key,
  });
  final String name;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
          backgroundImage: CachedNetworkImageProvider(image),
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleText(
              text: name,
              fontSize: 17,
            ),
            Text(
              "Instructor",
              style: GoogleFonts.poppins(
                  color: Colors.grey.shade500,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ],
    );
  }
}
