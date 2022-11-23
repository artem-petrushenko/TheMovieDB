import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:themoviedb/ui/screens/movie_details/movie_details_model.dart';

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
    final model = context.read<MovieDetailsViewModel>();
    final isFavoriteIcon = context.select((MovieDetailsViewModel model) =>
        model.data.informationData.isFavoriteIcon);
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
                isFavoriteIcon,
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
    final runtime = context.select((MovieDetailsViewModel model) =>
        model.data.informationData.runtimeData);
    return Text(
      runtime,
      style: const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14.0,
        color: Color(0xFF9A9BB2),
      ),
    );
  }
}

class _ContentRatingWidget extends StatelessWidget {
  const _ContentRatingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ageRating = context.select(
        (MovieDetailsViewModel model) => model.data.informationData.ageRating);
    return Text(
      ageRating,
      style: const TextStyle(
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
    final year = context.select(
        (MovieDetailsViewModel model) => model.data.informationData.year);
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
    final genres = context.select(
        (MovieDetailsViewModel model) => model.data.informationData.genres);
    return Wrap(
        alignment: WrapAlignment.start,
        spacing: 8.0,
        children: genres.map((genre) => _GenreWidget(genre: genre)).toList());
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
    final title = context.select(
        (MovieDetailsViewModel model) => model.data.informationData.title);

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
    final overview = context.select(
        (MovieDetailsViewModel model) => model.data.informationData.overview);
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
