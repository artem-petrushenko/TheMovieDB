import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:themoviedb/ui/screens/people_details/person_details_model.dart';


class PersonDetailsActingListWidget extends StatelessWidget {
  const PersonDetailsActingListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final credits = context
        .select((PersonDetailsViewModel model) => model.data.creditsMovieData);
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) =>
          _ActorInformationWidget(actor: credits[index]),
      itemCount: credits.length,
    );
  }
}

class _ActorInformationWidget extends StatelessWidget {
  final PersonDetailsActorCreditsData actor;

  const _ActorInformationWidget({
    Key? key,
    required this.actor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final releaseYear = actor.releaseDate;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          if (releaseYear != null) Text(releaseYear),
          Expanded(
            child: RichText(
              text: TextSpan(
                text: actor.name,
                style: DefaultTextStyle.of(context).style,
                children: [
                  const TextSpan(
                    text: '\tas\t',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: actor.character),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
