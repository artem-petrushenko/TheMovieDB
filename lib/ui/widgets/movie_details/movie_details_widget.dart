import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/library/widgets/inherited/provider.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';

import 'package:themoviedb/ui/widgets/movie_details/movie_details_main_info_widget.dart';
import 'package:themoviedb/ui/widgets/movie_details/movie_details_screen_cast_widget.dart';

import 'package:themoviedb/icons.dart';
import 'package:themoviedb/ui/theme/app_colors.dart';

import 'package:themoviedb/ui/widgets/movie_details/movie_details_model.dart';

class MovieDetailsWidget extends StatefulWidget {
  const MovieDetailsWidget({Key? key}) : super(key: key);

  @override
  State<MovieDetailsWidget> createState() => _MovieDetailsWidgetState();
}

class _MovieDetailsWidgetState extends State<MovieDetailsWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    NotifierProvider.read<MovieDetailsModel>(context)?.setupLocale(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _BodyWidget(),
      bottomNavigationBar: _BottomNavigationBarWidget(),
    );
  }
}

class _BottomNavigationBarWidget extends StatelessWidget {
  const _BottomNavigationBarWidget({
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarWidget extends StatelessWidget {
  const _SliverAppBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    final backdropPath = model?.movieDetails?.backdropPath;

    return SliverAppBar(
      leading: IconButton(
        icon: SvgPicture.asset(AppIcons.arrowLeft),
        tooltip: 'Back',
        onPressed: () {},
      ),
      actions: [
        IconButton(
          icon: SvgPicture.asset(
            model?.isFavorite == true ? AppIcons.star : AppIcons.series,
          ),
          tooltip: 'Like',
          onPressed: () => model?.toggleFavorite(),
        ),
      ],
      expandedHeight: 280,
      flexibleSpace: backdropPath != null
          ? Image.network(ApiClient.imageUrl(backdropPath), fit: BoxFit.cover)
          : const SizedBox.shrink(),
    );
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    final movieDetails = model?.movieDetails;
    final videos = movieDetails?.videos.results
        .where((video) => video.type == 'Trailer' && video.site == 'YouTube');
    final trailerKey = videos?.isNotEmpty == true ? videos?.first.key : null;

    if (movieDetails == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return CustomScrollView(
      slivers: [
        const _SliverAppBarWidget(),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              const MovieDetailsMainInfoWidget(),
              const MovieDetailsScreenCastWidget(),
              trailerKey != null
                  ? ElevatedButton(
                      onPressed: () => Navigator.of(context).pushNamed(
                        MainNavigationRouteNames.movieTrailerScreen,
                        arguments: trailerKey,
                      ),
                      child: const Text('Trailer'),
                    )
                  : const SizedBox.shrink()
            ],
          ),
        )
      ],
    );
  }
}
