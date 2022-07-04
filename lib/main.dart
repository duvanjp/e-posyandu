import 'package:e_posyandu/app_color.dart';
import 'package:e_posyandu/view/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: AppColor.darkPrimary));

    return MaterialApp(
          title: "E-Posyandu",
          debugShowCheckedModeBanner: false,
          color: AppColor.primary,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            colorScheme: ColorScheme.light(primary: AppColor.primary),
          ),
          home: LoginPage(),
        );
  }
}
