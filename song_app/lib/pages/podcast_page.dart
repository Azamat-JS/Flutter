import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:song_app/components/neu_box.dart';
import 'package:song_app/models/playlist_provider.dart';

class PodcastPage extends StatelessWidget {
  const PodcastPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(
      builder: (context, value, child) {
        final playlist = value.playlist;
        final currentPodcast = playlist[value.currentPodcastIndex ?? 0];
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.arrow_back),
                      ),
                      Text('P L A Y L I S T'),
                      IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
                    ],
                  ),
                  SizedBox(height: 25),
                  NeuBox(
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(10),
                          child: Image.asset(currentPodcast.albumArtImagePath),
                        ),

                        Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    currentPodcast.podcastName,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(currentPodcast.speakerName),
                                ],
                              ),

                              Icon(Icons.favorite, color: Colors.red),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 25),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('0:00'),
                            Icon(Icons.shuffle),
                            Icon(Icons.repeat),
                            Text("0:00"),
                          ],
                        ),
                      ),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: 0,
                          ),
                        ),
                        child: Slider(
                          min: 0,
                          max: 100,
                          value: 100,
                          activeColor: Colors.green,
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Expanded(child: NeuBox(child: Icon(Icons.skip_previous))),
                      SizedBox(width: 20),
                      Expanded(
                        flex: 2,
                        child: NeuBox(child: Icon(Icons.play_arrow)),
                      ),
                      SizedBox(width: 20),
                      Expanded(child: NeuBox(child: Icon(Icons.skip_next))),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
