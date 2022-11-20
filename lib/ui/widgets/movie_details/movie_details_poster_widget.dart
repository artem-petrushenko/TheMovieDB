import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:themoviedb/ui/widgets/movie_details/movie_details_model.dart';

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
          _MarkWidget(),
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
        (MovieDetailsViewModel model) => model.movieDetails?.backdropPath);
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
            ),
          ),
        ),
      ),
    );
  }
}

class _MarkWidget extends StatelessWidget {
  const _MarkWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: const Size(40, 40),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Material(
          color: const Color(0x4DFFFFFF),
          child: InkWell(
            onTap: () {},
            child: const Icon(
              Icons.bookmark_border_rounded,
              size: 24,
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
    final model = context.watch<MovieDetailsViewModel>();
    final movieDetails = model.movieDetails;
    final videos = movieDetails?.videos.results
        .where((video) => video.type == 'Trailer' && video.site == 'YouTube');
    final trailerKey = videos?.isNotEmpty == true ? videos?.first.key : null;
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
        else
          const SizedBox.shrink(),
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
    final voteAverage = context
        .select((MovieDetailsViewModel model) =>
            model.movieDetails?.voteAverage ?? 0)
        .toStringAsFixed(1);
    final voteCount = context
        .select(
            (MovieDetailsViewModel model) => model.movieDetails?.voteCount ?? 0)
        .toString();
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
                text: voteAverage,
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
          voteCount,
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
