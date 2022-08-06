import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:themoviedb/ui/widgets/movie_details/movie_details_main_info_widget.dart';
import 'package:themoviedb/ui/widgets/movie_details/movie_details_screen_cast_widget.dart';

import 'package:themoviedb/icons.dart';
import 'package:themoviedb/ui/theme/app_colors.dart';

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
        body: CustomScrollView(
          slivers: [
            const _MovieDetailsSliverAppBarWidget(),
            SliverList(
              delegate: SliverChildListDelegate([
                const MovieDetailsMainInfoWidget(),
                const MovieDetailsScreenCastWidget()
              ]),
            )
          ],
        ),
        bottomNavigationBar: const _MovieDetailsBottomNavigationBarWidget());
  }
}

class _MovieDetailsBottomNavigationBarWidget extends StatelessWidget {
  const _MovieDetailsBottomNavigationBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
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
            onPressed: () {},
            child: Row(
              children: [
                Expanded(
                  child: Text('In your area',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline4),
                ),
                const SizedBox(
                    width: 1,
                    height: 42,
                    child: ColoredBox(color: Colors.black)),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 15, bottom: 14, right: 9, left: 18),
                  child: SvgPicture.asset(
                    AppIcons.bell,
                    width: 16,
                    height: 18,
                    color: const Color.fromRGBO(17, 24, 39, 1),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MovieDetailsSliverAppBarWidget extends StatelessWidget {
  const _MovieDetailsSliverAppBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _backToMovies() {
      Navigator.of(context).pop();
    }

    return SliverAppBar(
      leading: IconButton(
        icon: SvgPicture.asset(AppIcons.arrowLeft),
        tooltip: 'Back',
        onPressed: _backToMovies,
      ),
      actions: [
        IconButton(
          icon: SvgPicture.asset(AppIcons.star),
          tooltip: 'Comment Icon',
          onPressed: () {},
        ),
      ],
      expandedHeight: 280,
      flexibleSpace: Stack(
        children: <Widget>[
          Positioned.fill(
              child: Image.asset(
            "assets/images/image.jpg",
            fit: BoxFit.cover,
          ))
        ],
      ),
    );
  }
}
