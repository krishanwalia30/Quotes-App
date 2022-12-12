import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:quotes_app/pages/aboutusPage.dart';
import 'package:quotes_app/pages/feedbackPage.dart';
import 'package:quotes_app/pages/loginPage.dart';
import 'package:quotes_app/pages/quotesPage.dart';
import 'package:quotes_app/utils/routes.dart';

import 'pages/homePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
      home: LoginPage(),
      initialRoute: MyRoutes.loginRoute,
      routes: {
        MyRoutes.quotesRoute: ((context) => QuotesPage()),
        MyRoutes.aboutusRoute: ((context) => AboutusPage()),
        MyRoutes.feedbackRoute: ((context) => FeedbackPage()),
        MyRoutes.loginRoute: ((context) => LoginPage()),
        MyRoutes.homeRoute: ((context) => HomePage()),
      },
    );
  }
}
