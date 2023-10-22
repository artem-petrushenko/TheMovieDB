import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/api_client/image_downloader.dart';
import '../bloc/movie_details_bloc.dart';

class MovieDetailsView extends StatelessWidget {
  const MovieDetailsView({
    super.key,
    required int movieId,
  }) : _movieId = movieId;

  final int _movieId;

  @override
  Widget build(BuildContext context) {
    final state = context.select((MovieDetailsBloc bloc) => bloc.state);
    return Scaffold(
      body: Center(
        child: state.map(
          loading: (state) => const CircularProgressIndicator(),
          success: (state) => CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                pinned: false,
                snap: true,
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_vert),
                  ),
                ],
                collapsedHeight: MediaQuery.of(context).size.height / 2,
                expandedHeight: MediaQuery.of(context).size.height / 2,
                flexibleSpace: Stack(
                  fit: StackFit.expand,
                  alignment: Alignment.center,
                  children: [
                    Image.network(
                      ImageDownloader.imageLink(
                          state.details.details.posterPath ?? ''),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 2,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 2,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Theme.of(context)
                                .colorScheme
                                .background
                                .withOpacity(0.5),
                            Theme.of(context).colorScheme.background,
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: FilledButton.tonalIcon(
                        onPressed: () {},
                        icon: const Icon(Icons.play_arrow),
                        label: const Text('Watch Trailer'),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(state.details.details.title),
                      ),
                    )
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton.outlined(
                      onPressed: () {
                        context.read<MovieDetailsBloc>().add(
                              MovieDetailsEvent.changeFavorite(
                                movieId: _movieId,
                                isFavorite: !state.details.isFavorite,
                              ),
                            );
                      },
                      icon: Icon(
                        state.details.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                      ),
                    ),
                    IconButton.outlined(
                      onPressed: () {
                        context.read<MovieDetailsBloc>().add(
                              MovieDetailsEvent.changeWatchlist(
                                movieId: _movieId,
                                isWatchlist: !state.details.isWatchlist,
                              ),
                            );
                      },
                      icon: Icon(
                        state.details.isWatchlist
                            ? Icons.bookmark
                            : Icons.bookmark_border,
                      ),
                    ),
                  ],
                ),
              ),
              SliverList.builder(
                itemBuilder: (BuildContext context, int index) {
                  return  Text('$index');
                },
                itemCount: 10,
              ),
            ],
          ),
          failure: (state) => Text(state.error.toString()),
        ),
      ),
    );
  }
}
