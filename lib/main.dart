import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:quotes_app/firebase_options.dart';
import 'package:quotes_app/pages/aboutusPage.dart';
import 'package:quotes_app/pages/feedbackPage.dart';
import 'package:quotes_app/pages/loginPage.dart';
import 'package:quotes_app/pages/quotesPage.dart';
import 'package:quotes_app/pages/userquotesPage.dart';
import 'package:quotes_app/utils/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/homePage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late String name = "";

  // This is used to run the function once the app is run
  @override
  void initState() {
    super.initState();
    loadName();
  }

  // Function used to load the name if that is already entered by the user
  Future<void> loadName() async {
    final prefs = await SharedPreferences.getInstance();
    name = (prefs.getString('name') ?? "");
    setState(() {
      name = (prefs.getString('name') ?? "");
    });
  }

  // This function is used to check if the name is "" or not
  // if the name is "" we have to direct the user to LoginPage
  // else we will direct the user to HomePage
  bool nameChecker() {
    bool toreturn;
    if (name == "") {
      toreturn = false;
    } else {
      toreturn = true;
    }
    // print(toreturn);
    return toreturn;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      title: 'QUOTES APP',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),

      // we will render HomePage if we know the username else we will
      // render LoginPage to get the username
      home: nameChecker() ? HomePage() : LoginPage(),

      // initialRoute: MyRoutes.loginRoute,
      routes: {
        MyRoutes.quotesRoute: ((context) => QuotesPage()),
        MyRoutes.aboutusRoute: ((context) => AboutusPage()),
        MyRoutes.feedbackRoute: ((context) => FeedbackPage()),
        MyRoutes.loginRoute: ((context) => LoginPage()),
        MyRoutes.homeRoute: ((context) => HomePage()),
        MyRoutes.userquotesRoute: ((context) => UserQuotesPage()),
      },
    );
  }
}
