import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:themoviedb/icons.dart';

import 'package:themoviedb/library/widgets/inherited/provider.dart';

import 'package:themoviedb/ui/widgets/movie_details/movie_details_model.dart';

class MovieDetailsMainInfoWidget extends StatelessWidget {
  const MovieDetailsMainInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _MovieNameWidget(),
        _StoryLineWidget(),
      ],
    );
  }
}

class _MovieNameWidget extends StatelessWidget {
  const _MovieNameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    var runtime = model?.movieDetails?.runtime ?? 0;
    var voteAverage = model?.movieDetails?.voteAverage ?? 0;
    final duration = Duration(minutes: runtime);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final genres = model?.movieDetails?.genres;
    var genresNames = <String>[];
    String genresFilm = '';
    if (genres != null) {
      for (var genr in genres) {
        genresNames.add(genr.name);
      }
      genresFilm = genresNames.join(', ').toString();
    }
    return Padding(
      padding: const EdgeInsets.only(top: 21, left: 21, right: 21, bottom: 19),
      child: Column(
        children: [
          Text(model?.movieDetails?.title ?? '',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline3),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    width: 18,
                    height: 18,
                    AppIcons.star,
                    color: const Color.fromRGBO(250, 255, 0, 1),
                  ),
                  const SizedBox(width: 5),
                  Text(voteAverage.toStringAsFixed(0)),
                ],
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    width: 18,
                    height: 18,
                    AppIcons.clock,
                    color: const Color.fromRGBO(153, 153, 153, 1),
                  ),
                  const SizedBox(width: 11),
                  Text('${hours}h ${minutes}m'),
                ],
              ),
              Text(genresFilm)
            ],
          )
        ],
      ),
    );
  }
}

class _StoryLineWidget extends StatelessWidget {
  const _StoryLineWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    final overview = model?.movieDetails?.overview ?? '';
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 19.0, bottom: 21.0),
            child: Text(
              'Story line',
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4.0, bottom: 23.0, right: 4.0),
            child: Text(
              overview,
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
