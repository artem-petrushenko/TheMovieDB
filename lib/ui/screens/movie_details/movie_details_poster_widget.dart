import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:themoviedb/ui/screens/movie_details/movie_details_model.dart';

import 'package:themoviedb/domain/api_client/image_downloader.dart';

import 'package:themoviedb/ui/navigation/main_navigation.dart';

class MovieDetailsPosterWidget extends StatelessWidget {
  const MovieDetailsPosterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: const [
            _PosterWidget(),
            _ActionsWidget(),
            _RankingBlockWidget(),
          ],
        ),
      ],
    );
  }
}

class _ActionsWidget extends StatelessWidget {
  const _ActionsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40,
      left: 24,
      right: 24,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          _BackWidget(),
          _WatchlistWidget(),
        ],
      ),
    );
  }
}

class _PosterWidget extends StatelessWidget {
  const _PosterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final backdropPath = context.select(
        (MovieDetailsViewModel model) => model.data.posterData.backdropPath);
    return AspectRatio(
      aspectRatio: 1.45,
      child: Column(
        children: [
          if (backdropPath != null)
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(60),
              ),
              child: Image.network(
                ImageDownloader.imageUrl(backdropPath),
                fit: BoxFit.fitWidth,
              ),
            )
          else
            const SizedBox.shrink(),
        ],
      ),
    );
  }
}

class _BackWidget extends StatelessWidget {
  const _BackWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<MovieDetailsViewModel>();
    return SizedBox.fromSize(
      size: const Size(40, 40),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Material(
          color: const Color(0x4DFFFFFF),
          child: InkWell(
            onTap: () => model.backToMovies(context),
            child: const Icon(
              Icons.arrow_back_ios_new,
              size: 24,
              color: Color(0xFF12153D),
            ),
          ),
        ),
      ),
    );
  }
}

class _WatchlistWidget extends StatelessWidget {
  const _WatchlistWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<MovieDetailsViewModel>();
    final isWatchlistIcon = context.select(
        (MovieDetailsViewModel model) => model.data.posterData.isWatchlistIcon);
    return SizedBox.fromSize(
      size: const Size(40, 40),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Material(
          color: const Color(0x4DFFFFFF),
          child: InkWell(
            onTap: () => model.addToWatchlist(context),
            child: Icon(
              isWatchlistIcon,
              size: 24,
              color: const Color(0xFF12153D),
            ),
          ),
        ),
      ),
    );
  }
}

class _RankingBlockWidget extends StatelessWidget {
  const _RankingBlockWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.only(
            left: 60.0, top: 18.0, bottom: 18.0, right: 30.0),
        margin: const EdgeInsets.only(left: 20.0),
        decoration: const BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(44),
            bottomLeft: Radius.circular(44),
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0x0512153D),
              offset: Offset(0, 5),
              blurRadius: 10.0,
              spreadRadius: 10.0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _RankingWidget(),
            SizedBox(width: 32),
            _RateWidget(),
            SizedBox(width: 32),
            _TrailerWidget(),
          ],
        ),
      ),
    );
  }
}

class _TrailerWidget extends StatelessWidget {
  const _TrailerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final trailerKey = context.select(
        (MovieDetailsViewModel model) => model.data.posterData.trailerKey);
    return Column(
      children: [
        if (trailerKey != null)
          Column(
            children: [
              InkWell(
                onTap: () => Navigator.of(context).pushNamed(
                  MainNavigationRouteNames.movieTrailerScreen,
                  arguments: trailerKey,
                ),
                child: const Icon(
                  Icons.play_arrow,
                  size: 32,
                  color: Color(0xFF51CF66),
                ),
              ),
              const Text(
                'Play Trailer',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                  color: Color(0xFF12153D),
                ),
              ),
            ],
          )
      ],
    );
  }
}

class _RateWidget extends StatelessWidget {
  const _RateWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Icon(
          Icons.star_border_rounded,
          size: 32,
          color: Color(0xFF434670),
        ),
        Text(
          'Rate This',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
            color: Color(0xFF12153D),
          ),
        ),
      ],
    );
  }
}

class _RankingWidget extends StatelessWidget {
  const _RankingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data =
        context.select((MovieDetailsViewModel model) => model.data.posterData);
    return Column(
      children: [
        const Icon(
          Icons.star,
          size: 32,
          color: Color(0xFFFCC419),
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: data.voteAverage,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                  color: Color(0xFF12153D),
                ),
              ),
              const TextSpan(
                text: "/10",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13.0,
                  color: Color(0xFF434670),
                ),
              ),
            ],
          ),
        ),
        Text(
          data.voteCount,
          style: const TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w400,
            color: Color(0xFF9A9BB2),
          ),
        )
      ],
    );
  }
}
