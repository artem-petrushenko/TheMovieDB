import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:themoviedb/ui/screens/people_details/person_details_model.dart';

import 'package:themoviedb/domain/api_client/image_downloader.dart';

class PersonDetailsPhotoWidget extends StatelessWidget {
  const PersonDetailsPhotoWidget({Key? key}) : super(key: key);

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
