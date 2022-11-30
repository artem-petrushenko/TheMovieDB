import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:themoviedb/domain/api_client/image_downloader.dart';
import 'package:themoviedb/ui/screens/people_details/person_details_model.dart';

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
        _PhotoWidget(),
        _SocialNetworkWidget(),
        _PersonalInformationWidget(),
        _BiographyWidget(),
        _KnownForWidget(),
        _ActingListWidget(),
      ],
    );
  }
}

class _PhotoWidget extends StatelessWidget {
  const _PhotoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profilePath = context.select(
        (PersonDetailsViewModel model) => model.data.photoData.profilePath);
    final name = context
        .select((PersonDetailsViewModel model) => model.data.photoData.name);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          if (profilePath != null)
            SizedBox(
              height: 160,
              width: 160,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6.0),
                child: Image.network(
                  ImageDownloader.imageUrl(profilePath),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          const SizedBox(height: 16.0),
          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF000000),
              fontWeight: FontWeight.w700,
              fontSize: 36.0,
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialNetworkWidget extends StatelessWidget {
  const _SocialNetworkWidget({Key? key}) : super(key: key);

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
            onPressed: () => model.openLink(context, homepage),
            icon: const Icon(Icons.link),
          ),
      ],
    );
  }
}

class _PersonalInformationWidget extends StatelessWidget {
  const _PersonalInformationWidget({Key? key}) : super(key: key);

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
        childAspectRatio: 2,
      ),
      children: [
        if (birthday != null)
          Column(
            children: [
              Text('Birthday'),
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
              Text('Place of Birthday'),
              Text(placeOfBirth),
            ],
          ),
        Column(
          children: [
            Text('Gender'),
            Text(gender),
          ],
        ),
        Column(
          children: [
            Text('Known For'),
            Text(knownForDepartment),
          ],
        ),
      ],
    );
  }
}

class _BiographyWidget extends StatelessWidget {
  const _BiographyWidget({Key? key}) : super(key: key);

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

class _KnownForWidget extends StatelessWidget {
  const _KnownForWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'Known As',
            style: TextStyle(
              color: Color(0xFF000000),
              fontWeight: FontWeight.w600,
              fontSize: 24.0,
            ),
          ),
        ),
        const SizedBox(height: 30.0),
        SizedBox(
          height: 224,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return SizedBox(
                width: 120,
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: Image.network(
                        ImageDownloader.imageUrl(
                            '/zUybYvxWdAJy5hhYovsXtHSWI1l.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'The Good, The Bad and The Ugly',
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Color(0xFF000000),
                        fontWeight: FontWeight.w300,
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              );
            },
            itemCount: 10,
          ),
        )
      ],
    );
  }
}

class _ActingListWidget extends StatelessWidget {
  const _ActingListWidget({Key? key}) : super(key: key);

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
    print(actor.name);
    return Column(children: [
      Text(actor.releaseDate),
      Text(actor.character),
      Text(actor.name),
    ]);
  }
}
