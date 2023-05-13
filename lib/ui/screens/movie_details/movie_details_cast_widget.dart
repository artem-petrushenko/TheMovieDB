import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:themoviedb/ui/screens/movie_details/movie_details_model.dart';

import 'package:themoviedb/domain/api_client/image_downloader.dart';

class MovieDetailsCastWidget extends StatelessWidget {
  const MovieDetailsCastWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
    List<MovieDetailsActorData> data =
        context.select((MovieDetailsViewModel model) => model.data.castData);
    if (data.isEmpty) return const SizedBox.shrink();
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: data.length,
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
    final actor = model.data.castData[actorIndex];
    final actorPath = actor.profilePath;

    return InkWell(
      onTap: () => model.openDetailsPerson(context, actor.id),
      child: SizedBox(
        width: 72.0,
        child: Column(
          children: [
            actorPath != null
                ? ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    clipBehavior: Clip.hardEdge,
                    child: Image.network(
                      width: 72,
                      height: 72,
                      fit: BoxFit.cover,
                      ImageDownloader.imageUrl(actorPath),
                    ),
                  )
                : const SizedBox(height: 72, width: 72),
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
      ),
    );
  }
}
