import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:themoviedb/ui/widgets/movie_details/movie_details_model.dart';

class MovieDetailsInformationWidget extends StatelessWidget {
  const MovieDetailsInformationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _InformationWidget(),
          SizedBox(height: 16),
          _GenresWidget(),
          SizedBox(height: 24),
          _StoryLineWidget(),
        ],
      ),
    );
  }
}

class _InformationWidget extends StatelessWidget {
  const _InformationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _TitleWidget(),
              _BasicInformationWidget(),
            ],
          ),
        ),
        const _FavoriteWidget()
      ],
    );
  }
}

class _FavoriteWidget extends StatelessWidget {
  const _FavoriteWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<MovieDetailsViewModel>();
    return SizedBox.fromSize(
      size: const Size(56, 56),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Material(
          color: const Color(0xFFFE6D8E),
          child: InkWell(
            onTap: () => model.toggleFavorite(context),
            child: Center(
              child: Icon(
                model.isFavorite ?? false
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: const Color(0xFFFFFFFF),
                size: 24.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BasicInformationWidget extends StatelessWidget {
  const _BasicInformationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            _YearWidget(),
            SizedBox(width: 16),
            _ContentRatingWidget(),
            SizedBox(width: 16),
            _MovieLengthWidget(),
          ],
        )
      ],
    );
  }
}

class _MovieLengthWidget extends StatelessWidget {
  const _MovieLengthWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<MovieDetailsViewModel>();
    var runtime = model.movieDetails?.runtime ?? 0;
    final duration = Duration(minutes: runtime);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    return Text(
      '${hours}h ${minutes}min',
      style: const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14.0,
        color: Color(0xFF9A9BB2),
      ),
    );
  }
}

class _ContentRatingWidget extends StatelessWidget {
  //TODO
  const _ContentRatingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'PG-13',
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14.0,
        color: Color(0xFF9A9BB2),
      ),
    );
  }
}

class _YearWidget extends StatelessWidget {
  const _YearWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final year = context
        .select((MovieDetailsViewModel model) =>
            model.movieDetails?.releaseDate?.year)
        .toString();
    return Text(
      year,
      style: const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14.0,
        color: Color(0xFF9A9BB2),
      ),
    );
  }
}

class _GenresWidget extends StatelessWidget {
  const _GenresWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<MovieDetailsViewModel>();
    final genres = model.movieDetails?.genres;
    final genresNames = <String>[];
    if (genres != null) {
      for (var genre in genres) {
        genresNames.add(genre.name);
      }
    }
    return Wrap(
        alignment: WrapAlignment.start,
        spacing: 8.0,
        children: genresNames
            .map(
              (genre) => _GenreWidget(genre: genre),
            )
            .toList());
  }
}

class _GenreWidget extends StatelessWidget {
  final String genre;

  const _GenreWidget({
    Key? key,
    required this.genre,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: const BorderSide(width: 1, color: Color(0x3312153D)),
      ),
      labelStyle: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14.0,
        color: Color(0xFF434670),
      ),
      label: Text(genre),
    );
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title =
        context.select((MovieDetailsViewModel model) => model.data.title);

    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 28.0,
        color: Color(0xFF12153D),
      ),
    );
  }
}

class _StoryLineWidget extends StatelessWidget {
  const _StoryLineWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final overview =
        context.select((MovieDetailsViewModel model) => model.data.overview);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Story line',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 24,
            color: Color(0xFF12153D),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          overview,
          style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14.0,
              color: Color(0xFF737599)),
        ),
      ],
    );
  }
}
