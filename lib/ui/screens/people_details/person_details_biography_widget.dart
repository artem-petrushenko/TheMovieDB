import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:themoviedb/ui/screens/people_details/person_details_model.dart';

class PersonDetailsBiographyWidget extends StatelessWidget {
  const PersonDetailsBiographyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final biography = context.select(
        (PersonDetailsViewModel model) => model.data.biographyData.biography);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Biography',
            style: TextStyle(
              color: Color(0xFF000000),
              fontWeight: FontWeight.w600,
              fontSize: 24.0,
            ),
          ),
          const SizedBox(height: 30.0),
          Text(
            biography,
            style: const TextStyle(
              color: Color(0xFF000000),
              fontWeight: FontWeight.w300,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}
