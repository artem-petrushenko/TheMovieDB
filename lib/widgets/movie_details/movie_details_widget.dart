import 'package:flutter/material.dart';

import 'package:themoviedb/widgets/movie_details/movie_details_main_info_widget.dart';
import 'package:themoviedb/widgets/movie_details/movie_details_screen_cast_widget.dart';

import '../../theme/app_colors.dart';

class MovieDetailsWidget extends StatefulWidget {
  final int movieId;

  const MovieDetailsWidget({Key? key, required this.movieId}) : super(key: key);

  @override
  State<MovieDetailsWidget> createState() => _MovieDetailsWidgetState();
}

class _MovieDetailsWidgetState extends State<MovieDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
          children:  const [
            MovieDetailsMainInfoWidget(),
            MovieDetailsScreenCastWidget(),
          ],
        ),
      bottomNavigationBar: BottomAppBar(
        color: AppColors.kBackgroundColor,
        child: Padding(
          padding:
          const EdgeInsets.only(right: 26, left: 26, bottom: 50, top: 16),
          child: Container(
            width: double.infinity,
            height: 47,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11.0)),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.kSecondGradientColor,
                  AppColors.kFirstGradientColor
                ],
              ),
            ),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11.0)),
              onPressed: (){},
              child: Text('Create Account',
                  style: Theme.of(context).textTheme.headline4),
            ),
          ),
        ),
      ),
    );
  }
}
