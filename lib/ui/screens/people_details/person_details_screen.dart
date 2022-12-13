import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:themoviedb/ui/screens/people_details/person_details_acting_list_widget.dart';
import 'package:themoviedb/ui/screens/people_details/person_details_biography_widget.dart';
import 'package:themoviedb/ui/screens/people_details/person_details_information_widget.dart';
import 'package:themoviedb/ui/screens/people_details/person_details_known_for_widget.dart';
import 'package:themoviedb/ui/screens/people_details/person_details_model.dart';
import 'package:themoviedb/ui/screens/people_details/person_details_photo_widget.dart';
import 'package:themoviedb/ui/screens/people_details/person_details_social_network_widget.dart';

class PersonDetailsScreen extends StatefulWidget {
  const PersonDetailsScreen({Key? key}) : super(key: key);

  @override
  State<PersonDetailsScreen> createState() => _PersonDetailsScreenState();
}

class _PersonDetailsScreenState extends State<PersonDetailsScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale = Localizations.localeOf(context);
    Future.microtask(
      () => context.read<PersonDetailsViewModel>().setupLocale(context, locale),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLoading =
        context.select((PersonDetailsViewModel model) => model.data.isLoading);
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView(
      children: const [
        SizedBox(height: 16.0),
        PersonDetailsPhotoWidget(),
        SizedBox(height: 16.0),
        PersonDetailsSocialNetworkWidget(),
        SizedBox(height: 16.0),
        PersonDetailsInformationWidget(),
        SizedBox(height: 16.0),
        PersonDetailsBiographyWidget(),
        SizedBox(height: 16.0),
        PersonDetailsKnownForWidget(),
        SizedBox(height: 16.0),
        PersonDetailsActingListWidget(),
      ],
    );
  }
}
