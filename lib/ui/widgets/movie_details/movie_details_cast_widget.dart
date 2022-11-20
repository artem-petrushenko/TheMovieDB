import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:themoviedb/ui/widgets/movie_details/movie_details_model.dart';

import 'package:themoviedb/domain/api_client/image_downloader.dart';

class MovieDetailsCastWidget extends StatelessWidget {
  const MovieDetailsCastWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Padding(
          padding: EdgeInsets.only(left: 19.0, bottom: 22.0),
          child: Text(
            'Cast & Crew',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 24,
              color: Color(0xFF12153D),
            ),
          ),
        ),
        SizedBox(
          height: 153,
          child: _ActorListWidget(),
        )
      ],
    );
  }
}

class _ActorListWidget extends StatelessWidget {
  const _ActorListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<MovieDetailsViewModel>();
    var cast = model.movieDetails?.credits.cast;
    if (cast == null || cast.isEmpty) return const SizedBox.shrink();
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: model.movieDetails?.credits.cast.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        return _ActorListItemWidget(actorIndex: index);
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(width: 22.0);
      },
    );
  }
}

class _ActorListItemWidget extends StatelessWidget {
  final int actorIndex;

  const _ActorListItemWidget({
    Key? key,
    required this.actorIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<MovieDetailsViewModel>();
    final actor = model.movieDetails!.credits.cast[actorIndex];
    final actorPath = actor.profilePath;

    return SizedBox(
      width: 72.0,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            clipBehavior: Clip.hardEdge,
            child: actorPath != null
                ? Image.network(
                    width: 72,
                    height: 72,
                    fit: BoxFit.cover,
                    ImageDownloader.imageUrl(actorPath),
                  )
                : const SizedBox.shrink(),
          ),
          const SizedBox(height: 12.0),
          Text(
            actor.name,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Color(0xFF12153D),
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            actor.character,
            textAlign: TextAlign.center,
            maxLines: 1,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Color(0xFF9A9BB2),
            ),
          ),
        ],
      ),
    );
  }
}
