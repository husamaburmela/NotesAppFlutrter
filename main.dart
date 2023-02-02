import 'package:flutter/material.dart';
import 'package:flutter_frontend_api_php_wael/addnotes.dart';
import 'package:flutter_frontend_api_php_wael/editnotes.dart';
import 'package:flutter_frontend_api_php_wael/success.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';
import 'signup.dart';
import 'home.dart';

SharedPreferences? sharedPreferences;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute:
            sharedPreferences!.getString("id") == null ? "login" : "home",
        routes: {
          "login": (context) => login(),
          "signup": (context) => signup(),
          "home": (context) => home(),
          "success": (context) => Success(),
          "editnotes": (context) => editnotes(),
          "addnotes": (context) => addnotes(),
        });
  }
}
