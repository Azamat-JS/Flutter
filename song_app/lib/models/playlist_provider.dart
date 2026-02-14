import 'package:flutter/material.dart';
import 'package:song_app/models/podcast.dart';

class PlaylistProvider extends ChangeNotifier {
  final List<Podcast> _playlist = [
    Podcast(
      albumArtImagePath: "assets/images/logo1.png",
      speakerName: "Orus",
      audioPath: "assets/audios/follow.wav",
      podcastName: "Follow",
    ),
    Podcast(
      albumArtImagePath: "assets/images/logo2.png",
      speakerName: "Orus",
      audioPath: "assets/audios/follow.wav",
      podcastName: "Great",
    ),
    Podcast(
      albumArtImagePath: "assets/images/logo4.png",
      speakerName: "Orus",
      audioPath: "assets/audios/follow.wav",
      podcastName: "Science",
    ),
  ];

  int? _currentPodcastIndex;

  /*
  gettters
  */

  List<Podcast> get playlist => _playlist;
  int? get currentPodcastIndex => _currentPodcastIndex;

  /*
 setters
 */

  set currentPodcastIndex(int? newIndex) {
    _currentPodcastIndex = newIndex;

    notifyListeners();
  }
}
