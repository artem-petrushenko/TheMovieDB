import 'package:flutter/material.dart';
import 'package:themoviedb/widgets/auth/auth_widget.dart';
import 'package:themoviedb/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.kBackgroundColor,
        appBarTheme: const AppBarTheme(backgroundColor: AppColors.kBackgroundColor),
          fontFamily: 'Roboto', backgroundColor: AppColors.kBackgroundColor),
      home: const AuthWidget(),
    );
  }
}
