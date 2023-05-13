import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:themoviedb/ui/screens/people_details/person_details_model.dart';

class PersonDetailsInformationWidget extends StatelessWidget {
  const PersonDetailsInformationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final birthday = context.select((PersonDetailsViewModel model) =>
    model.data.personInformationData.birthday);
    final deathday = context.select((PersonDetailsViewModel model) =>
    model.data.personInformationData.deathday);
    final placeOfBirth = context.select((PersonDetailsViewModel model) =>
    model.data.personInformationData.placeOfBirth);
    final gender = context.select((PersonDetailsViewModel model) =>
    model.data.personInformationData.gender);
    final knownForDepartment = context.select((PersonDetailsViewModel model) =>
    model.data.personInformationData.knownForDepartment);

    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 4,
      ),
      children: [
        if (birthday != null)
          Column(
            children: [
              const Text('Birthday'),
              Text(birthday),
            ],
          ),
        if (deathday != null)
          Column(
            children: [
              const Text('Deathday'),
              Text(deathday),
            ],
          ),
        if (placeOfBirth != null)
          Column(
            children: [
              const Text('Place of Birthday'),
              Text(placeOfBirth),
            ],
          ),
        Column(
          children: [
            const Text('Gender'),
            Text(gender),
          ],
        ),
        Column(
          children: [
            const Text('Known For'),
            Text(knownForDepartment),
          ],
        ),
      ],
    );
  }
}