import 'package:flutter/cupertino.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieTrailerViewModel extends ChangeNotifier {
  final String youTubeKey;

  MovieTrailerViewModel({
    required this.youTubeKey,
  });

  late final YoutubePlayerController youtubePlayerController =
      YoutubePlayerController(
    initialVideoId: youTubeKey,
    flags: const YoutubePlayerFlags(
      autoPlay: true,
      mute: true,
      loop: false,
    ),
  );
}
