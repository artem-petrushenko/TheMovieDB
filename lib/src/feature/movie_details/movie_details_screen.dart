import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:themoviedb/src/feature/movie_details/movie_details_information_widget.dart';
import 'package:themoviedb/src/feature/movie_details/movie_details_cast_widget.dart';

import 'package:themoviedb/src/feature/movie_details/movie_details_model.dart';

import 'package:themoviedb/src/feature/movie_details/movie_details_poster_widget.dart';

class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({Key? key}) : super(key: key);

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale = Localizations.localeOf(context);
    Future.microtask(
      () => context.read<MovieDetailsViewModel>().setupLocale(context, locale),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _BodyWidget(),
    );
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLoading =
        context.select((MovieDetailsViewModel model) => model.data.isLoading);

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MovieDetailsPosterWidget(),
          SizedBox(height: 24),
          MovieDetailsInformationWidget(),
          SizedBox(height: 24),
          MovieDetailsCastWidget(),
          //TODO
          //SOCIAL
          //MEDIA
          //RECOMMENDATION
        ],
      ),
    );
  }
}