import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:themoviedb/ui/screens/people_details/person_details_model.dart';

class PersonDetailsSocialNetworkWidget extends StatelessWidget {
  const PersonDetailsSocialNetworkWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<PersonDetailsViewModel>();
    final homepage = context.select((PersonDetailsViewModel model) =>
        model.data.socialNetworkData.homepage);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (homepage != null)
          IconButton(
            onPressed: () => model.openLink(homepage),
            icon: const Icon(Icons.link),
          ),
      ],
    );
  }
}
