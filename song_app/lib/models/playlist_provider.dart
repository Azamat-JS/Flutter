import 'package:audioplayers/audioplayers.dart';
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
  Audio players
  */

  final AudioPlayer _audioPlayer = AudioPlayer();

  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  PlaylistProvider() {
    listenToDuration();
  }

  bool _isPlaying = false;

  void play() async {
    final String path = _playlist[_currentPodcastIndex!].audioPath;
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(path));
    _isPlaying = true;
    notifyListeners();
  }

  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  void pauseOrResume() async {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }

  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  void playNextPodcast() {
    if (_currentPodcastIndex != null) {
      if (_currentPodcastIndex! < _playlist.length - 1) {
        currentPodcastIndex = _currentPodcastIndex! + 1;
      } else {
        currentPodcastIndex = 0;
      }
    }
  }

  void playPreviousPodcast() async {
    if (_currentDuration.inSeconds > 2) {
    } else {
      if (_currentPodcastIndex! > 0) {
        currentPodcastIndex = _currentPodcastIndex! - 1;
      } else {
        currentPodcastIndex = _playlist.length - 1;
      }
    }
  }

  void listenToDuration() {
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });

    _audioPlayer.onDurationChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      playNextPodcast();
    });
  }

  /*
  gettters
  */

  List<Podcast> get playlist => _playlist;
  int? get currentPodcastIndex => _currentPodcastIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  /*
 setters
 */

  set currentPodcastIndex(int? newIndex) {
    _currentPodcastIndex = newIndex;

    if (newIndex != null) {
      play();
    }

    notifyListeners();
  }
}
