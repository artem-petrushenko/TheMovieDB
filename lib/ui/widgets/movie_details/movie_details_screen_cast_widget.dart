import 'package:flutter/material.dart';
import 'package:themoviedb/ui/widgets/movie_details/movie_details_model.dart';
import 'package:themoviedb/library/widgets/inherited/provider.dart';
import 'package:themoviedb/domain/api_client/image_downloader.dart';

class MovieDetailsScreenCastWidget extends StatelessWidget {
  const MovieDetailsScreenCastWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 19.0, bottom: 22.0),
          child: Text(
            'Cast',
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        const SizedBox(
          height: 123,
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
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    var cast = model?.movieDetails?.credits.cast;
    if (cast == null || cast.isEmpty) return const SizedBox.shrink();
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 19),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: model?.movieDetails?.credits.cast.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        return _ActorListItemWidget(actorIndex: index);
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(width: 19);
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
    final model = NotifierProvider.read<MovieDetailsModel>(context);
    final actor = model!.movieDetails!.credits.cast[actorIndex];
    final actorPath = actor.profilePath;

    return Column(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          clipBehavior: Clip.hardEdge,
          child: actorPath != null
              ? Image.network(
                  width: 79,
                  height: 79,
                  fit: BoxFit.cover,
                  ImageDownloader.imageUrl(actorPath),
                )
              : const SizedBox.shrink(),
        ),
        SizedBox(
          width: 79,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(actor.name,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: Theme.of(context).textTheme.headline5),
          ),
        )
      ],
    );
  }
}
