import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:themoviedb/ui/widgets/movie_list/movie_list_model.dart';

import 'package:themoviedb/domain/api_client/image_downloader.dart';

class MovieListWidget extends StatefulWidget {
  const MovieListWidget({Key? key}) : super(key: key);

  @override
  State<MovieListWidget> createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    context.read<MovieListViewModel>().setupLocale(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 8),
      child: Column(
        children: const [
          _SearchWidget(),
          _MovieListWidget(),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: TextFormField(
        onChanged: model.searchMovie,
        decoration: const InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(11.0),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(11.0),
              ),
              borderSide: BorderSide(
                color: Colors.transparent,
                width: 0,
              ),
            ),
            hintText: 'Search in the App',
        ),
      ),
    );
  }
}

class _MovieListWidget extends StatelessWidget {
  const _MovieListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<MovieListViewModel>();
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        shrinkWrap: true,
        itemCount: model.movies.length,
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(height: 22),
        itemBuilder: (BuildContext context, int index) {
          model.showedMovieAtIndex(index);
          return _MovieListRowWidget(index: index);
        },
      ),
    );
  }
}

class _MovieListRowWidget extends StatelessWidget {
  final int index;

  const _MovieListRowWidget({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<MovieListViewModel>();
    final movie = model.movies[index];
    final posterPath = movie.posterPath;
    return Column(
      children: [
        Stack(
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              width: double.infinity,
              height: 120,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              child: Row(
                children: [
                  if (posterPath != null)
                    Image.network(
                      ImageDownloader.imageUrl(posterPath),
                      width: 95,
                      fit: BoxFit.cover,
                    ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(movie.title),
                          Text(movie.releaseDate),
                          Text(
                            movie.overview,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 120,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  hoverColor: Colors.grey[400],
                  borderRadius: BorderRadius.circular(12),
                  onTap: () => model.onMovieTap(context, index),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
