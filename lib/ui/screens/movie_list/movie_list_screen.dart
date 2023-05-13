import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:themoviedb/domain/api_client/image_downloader.dart';
import 'package:themoviedb/ui/screens/movie_list/movie_list_model.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({Key? key}) : super(key: key);

  @override
  State<MovieListScreen> createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale = Localizations.localeOf(context);
    context.read<MovieListViewModel>().setupLocale(locale);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          _MovieListMoviesWidget(),
          _SearchWidget(),
        ],
      ),
    );
  }
}

class _SearchWidget extends StatelessWidget {
  const _SearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<MovieListViewModel>();
    return TextFormField(
      onChanged: model.searchMovie,
      decoration: const InputDecoration(
        hintText: 'Search in the App',
      ),
    );
  }
}

class _MovieListMoviesWidget extends StatelessWidget {
  const _MovieListMoviesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<MovieListViewModel>();
    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      itemExtent: 163,
      shrinkWrap: true,
      itemCount: model.movies.length,
      itemBuilder: (BuildContext context, int index) {
        model.showedMovieAtIndex(index);
        return _MovieListMovieWidget(index: index);
      },
    );
  }
}

class _MovieListMovieWidget extends StatelessWidget {
  final int index;

  const _MovieListMovieWidget({Key? key, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<MovieListViewModel>();
    final movie = model.movies[index];
    final posterPath = movie.posterPath;
    return GestureDetector(
      onTap: () => model.onMovieTap(context, index),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: const Color(0xFFFFFFFF),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0D000000),
              offset: Offset(0, 0),
              blurRadius: 5,
              spreadRadius: 5,
            ),
          ],
        ),
        clipBehavior: Clip.hardEdge,
        child: Row(
          children: [
            if (posterPath != null)
              Image.network(
                ImageDownloader.imageUrl(posterPath),
                fit: BoxFit.cover,
                width: 95,
                height: 163,
              ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: const TextStyle(
                        color: Color(0xFF000000),
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                    ),
                    Text(
                      movie.releaseDate,
                      style: const TextStyle(
                        color: Color(0xFF999999),
                        fontWeight: FontWeight.w500,
                        fontSize: 14.4,
                      ),
                      maxLines: 1,
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      movie.overview,
                      style: const TextStyle(
                        color: Color(0xFF000000),
                        fontSize: 14.4,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
    // return GestureDetector(
    //   onTap: () => model.onMovieTap(context, index),
    //   child: Column(
    //     children: [
    //       if (posterPath != null)
    //         Container(
    //           decoration: const BoxDecoration(
    //             borderRadius: BorderRadius.only(
    //               topLeft: Radius.circular(24.0),
    //               topRight: Radius.circular(12.0),
    //               bottomRight: Radius.circular(24.0),
    //               bottomLeft: Radius.circular(12.0),
    //             ),
    //             boxShadow: [
    //               BoxShadow(
    //                 color: Color(0x2612153D),
    //                 offset: Offset(0, 8),
    //                 blurRadius: 8.0,
    //               ),
    //             ],
    //           ),
    //           child: ClipRRect(
    //             borderRadius: const BorderRadius.only(
    //               topLeft: Radius.circular(24.0),
    //               topRight: Radius.circular(12.0),
    //               bottomRight: Radius.circular(24.0),
    //               bottomLeft: Radius.circular(12.0),
    //             ),
    //             child: SizedBox(
    //               child: Image.network(
    //                 ImageDownloader.imageUrl(posterPath),
    //                 fit: BoxFit.cover,
    //               ),
    //             ),
    //           ),
    //         ),
    //       const SizedBox(height: 6.0),
    //       Text(
    //         movie.title,
    //         maxLines: 2,
    //         overflow: TextOverflow.ellipsis,
    //         textAlign: TextAlign.center,
    //         style: const TextStyle(
    //           fontSize: 14.0,
    //           fontWeight: FontWeight.w500,
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}
