import 'package:flutter/material.dart';

import 'package:themoviedb/theme/app_colors.dart';
import 'package:themoviedb/widgets/auth/auth_widget.dart';
import 'package:themoviedb/widgets/sign_up_widget/sign_up_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TMDB',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.kBackgroundColor,
        appBarTheme: const AppBarTheme(backgroundColor: AppColors.kBackgroundColor),
          fontFamily: 'Roboto', backgroundColor: AppColors.kBackgroundColor),
      home: const AuthWidget(),
    );
  }
}
