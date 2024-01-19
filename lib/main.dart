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
import 'package:responsive_framework/breakpoint.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
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
        builder: (context, child) => ResponsiveBreakpoints.builder(
              breakpoints: [
                const Breakpoint(start: 0, end: 450, name: MOBILE),
                const Breakpoint(start: 451, end: 800, name: TABLET),
                const Breakpoint(start: 801, end: 1920, name: DESKTOP),
                const Breakpoint(start: 1921, end: double.infinity, name: '4K')
              ],
              child: child!,
            ));
  }
}
