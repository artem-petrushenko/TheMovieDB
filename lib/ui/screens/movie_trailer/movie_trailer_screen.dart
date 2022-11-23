import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:themoviedb/ui/screens/movie_trailer/movie_trailer_model.dart';


class MovieTrailerScreen extends StatelessWidget {
  const MovieTrailerScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<MovieTrailerViewModel>();
    final player = YoutubePlayer(
      controller: model.youtubePlayerController,
      showVideoProgressIndicator: true,
    );
    return YoutubePlayerBuilder(
      player: player,
      builder: (context, player) {
        return Scaffold(
          body: Center(
            child: player,
          ),
        );
      },
    );
  }
}
