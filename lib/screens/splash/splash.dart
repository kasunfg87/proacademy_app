import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proacademy_app/screens/splash/page_view.dart';
import '../../components/widgets/utilities/assets_constants.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CustomPageView()),
      );
    });

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      decoration: (const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AssetConstants.splashImage),
              fit: BoxFit.cover))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 3.1,
          ),
          ZoomIn(
            duration: const Duration(seconds: 1),
            child: Image.asset(
              AssetConstants.logoImage,
              height: 90,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          ZoomIn(
            duration: const Duration(seconds: 1),
            child: Text(
              'PROACADEMY',
              style: GoogleFonts.notoSerif(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w600),
            ),
          ),
          ZoomIn(
            duration: const Duration(seconds: 1),
            child: Text(
              'Enhance your career with professionals',
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w300),
            ),
          )
        ],
      ),
    ));
  }
}
