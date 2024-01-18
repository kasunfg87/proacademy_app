import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:proacademy_app/provider/category_provider.dart';
import 'package:proacademy_app/provider/chat_provider.dart';
import 'package:proacademy_app/provider/config_provider.dart';
import 'package:proacademy_app/provider/course_provider.dart';
import 'package:proacademy_app/provider/data_provider.dart';
import 'package:proacademy_app/provider/favourite_provider.dart';
import 'package:proacademy_app/provider/location_provider.dart';
import 'package:proacademy_app/provider/user_provider.dart';
import 'package:proacademy_app/screens/splash/splash.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: ((context) => DataProvider())),
    ChangeNotifierProvider(create: ((context) => ConfigProvider())),
    ChangeNotifierProvider(create: ((context) => CourseProvider())),
    ChangeNotifierProvider(create: ((context) => LocationProvider())),
    ChangeNotifierProvider(create: ((context) => UserProvider())),
    ChangeNotifierProvider(create: ((context) => FavouriteProvider())),
    ChangeNotifierProvider(create: ((context) => CategoryProvider())),
    ChangeNotifierProvider(create: ((context) => ChatProvider())),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Proacademy App',
        home: const Splash(),
        builder: (context, child) => ResponsiveWrapper.builder(
              BouncingScrollWrapper.builder(context, child!),
              maxWidth: 1200,
              minWidth: 450,
              defaultScale: true,
              breakpoints: [
                const ResponsiveBreakpoint.resize(450, name: MOBILE),
                const ResponsiveBreakpoint.autoScale(800, name: TABLET),
                const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
                const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
                const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
              ],
            ));
  }
}
