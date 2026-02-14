import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:song_app/components/my_drawer.dart';
import 'package:song_app/models/playlist_provider.dart';
import 'package:song_app/models/podcast.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("P L A Y L I S T")),
      backgroundColor: Theme.of(context).colorScheme.surface,
      drawer: MyDrawer(),
      body: Consumer<PlaylistProvider>(
        builder: (context, value, child) {
          final List<Podcast> playlist = value.playlist;
          return ListView.builder(
            itemCount: playlist.length,
            itemBuilder: (context, index) {
              final Podcast podcast = playlist[index];
              return ListTile(
                title: Text(podcast.podcastName),
                subtitle: Text(podcast.speakerName),
                leading: Image.asset(podcast.albumArtImagePath),
              );
            },
          );
        },
      ),
    );
  }
}
