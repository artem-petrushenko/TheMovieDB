import 'package:flutter/cupertino.dart';

import 'package:themoviedb/domain/api_client/image_downloader.dart';

class PersonDetailsKnownForWidget extends StatelessWidget {
  const PersonDetailsKnownForWidget({Key? key}) : super(key: key);

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