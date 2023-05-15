import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:themoviedb/domain/api_client/image_downloader.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';
import 'package:themoviedb/ui/screens/movie_list/movie_list_cubit.dart';

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
    context.read<MovieListCubit>().setupLocale(locale.languageCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
      ),
      body: const Stack(
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
    final cubit = context.read<MovieListCubit>();
    return TextFormField(
      onChanged: cubit.searchMovie,
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
    final cubit = context.watch<MovieListCubit>();
    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      itemExtent: 163,
      shrinkWrap: true,
      itemCount: cubit.state.movies.length,
      itemBuilder: (BuildContext context, int index) {
        cubit.showedMovieAtIndex(index);
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
    final cubit = context.read<MovieListCubit>();
    final movie = cubit.state.movies[index];
    final posterPath = movie.posterPath;
    return GestureDetector(
      onTap: () => _onMovieTap(context, movie.id),
      child: Row(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            clipBehavior: Clip.hardEdge,
            child: Column(
              children: [
                Image.network(
                  ImageDownloader.imageUrl(posterPath ?? ''),
                  fit: BoxFit.cover,
                  height: 155,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: Theme.of(context).textTheme.headline6,
                      maxLines: 2,
                      softWrap: false,
                      overflow: TextOverflow.fade,
                    ),
                    Text(
                      movie.releaseDate,
                      style: Theme.of(context).textTheme.subtitle1,
                      maxLines: 1,
                      softWrap: false,
                      overflow: TextOverflow.fade,
                    ),
                    Text(
                      movie.overview,
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 2,
                      softWrap: false,
                      overflow: TextOverflow.fade,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onMovieTap(BuildContext context, int movieID) {
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.movieDetailsScreen,
      arguments: movieID,
    );
  }
}
