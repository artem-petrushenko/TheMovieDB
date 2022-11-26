import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:themoviedb/ui/screens/movie_list/movie_list_model.dart';

import 'package:themoviedb/domain/api_client/image_downloader.dart';

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
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 8),
      child: Stack(
        children: const [
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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85),
        boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            offset: Offset(0, 5),
            blurRadius: 10.0,
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(12.0),
          bottomRight: Radius.circular(24.0),
          bottomLeft: Radius.circular(12.0),
        ),
      ),
      child: TextFormField(
        onChanged: model.searchMovie,
        decoration: const InputDecoration(
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          hintText: 'Search in the App',
        ),
      ),
    );
  }
}

class _MovieListMoviesWidget extends StatelessWidget {
  const _MovieListMoviesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<MovieListViewModel>();
    return GridView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      shrinkWrap: true,
      itemCount: model.movies.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisExtent: 210,
        crossAxisSpacing: 16,
        mainAxisSpacing: 8,
        crossAxisCount: 3,
      ),
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
      child: Column(
        children: [
          if (posterPath != null)
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  topRight: Radius.circular(12.0),
                  bottomRight: Radius.circular(24.0),
                  bottomLeft: Radius.circular(12.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x2612153D),
                    offset: Offset(0, 8),
                    blurRadius: 8.0,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  topRight: Radius.circular(12.0),
                  bottomRight: Radius.circular(24.0),
                  bottomLeft: Radius.circular(12.0),
                ),
                child: SizedBox(
                  child: Image.network(
                    ImageDownloader.imageUrl(posterPath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          const SizedBox(height: 6.0),
          Text(
            movie.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
