import 'package:flutter/material.dart';
import 'package:themoviedb/theme/app_theme.dart';
import 'package:themoviedb/widgets/auth/auth_widget.dart';
import 'package:themoviedb/widgets/main_screen_widget/main_screen_widget.dart';
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
      theme: themeData,
      routes:{
        '/auth': (context) => const AuthWidget(),
        '/sign_up': (context) => const SignUpWidget(),
        '/main': (context) => const MainScreenWidget(),
      },
      initialRoute: '/auth',
    );
  }
}
