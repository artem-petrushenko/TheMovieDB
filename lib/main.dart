import 'package:flutter/material.dart';

import 'package:themoviedb/theme/app_theme.dart';
import 'package:themoviedb/widgets/auth/auth_widget.dart';
import 'package:themoviedb/widgets/main_screen_widget/main_screen_widget.dart';
import 'package:themoviedb/widgets/movie_details/movie_details_widget.dart';
import 'package:themoviedb/widgets/sign_up/sign_up_widget.dart';
import 'package:themoviedb/widgets/welcome/welcome_widget.dart';

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
        '/welcome': (context) => const WelcomeWidget(),
        '/auth': (context) => const AuthWidget(),
        '/sign_up': (context) => const SignUpWidget(),
        '/main': (context) => const MainScreenWidget(),
        '/main/movie_details': (context) {
          final id = ModalRoute.of(context)?.settings.arguments;
          if (id is int){
            return MovieDetailsWidget(movieId: id);
          } else{
            return const MovieDetailsWidget(movieId: 0);
          }

        },
      },
      initialRoute: '/main/movie_details',
    );
  }
}
