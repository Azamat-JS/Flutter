import 'package:flutter/material.dart';
import 'package:song_app/components/neu_box.dart';

class PodcastPage extends StatelessWidget {
  const PodcastPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(title: Text('Podcast page')),
      body: Center(child: NeuBox(child: Icon(Icons.mic))),
    );
  }
}
