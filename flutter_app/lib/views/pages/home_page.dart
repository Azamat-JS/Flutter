import 'package:flutter/material.dart';
import 'package:flutter_app/views/widgets/container_widget.dart';
import 'package:flutter_app/views/widgets/hero-widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            HeroWidget(),
            ContainerWidget(
              title: 'Welcome to the Home Page!',
              description: 'This is a simple Flutter application.',
            ),
            ContainerWidget(
              title: 'Welcome to the Home Page!',
              description: 'This is a simple Flutter application.',
            ),
            ContainerWidget(
              title: 'Welcome to the Home Page!',
              description: 'This is a simple Flutter application.',
            ),
          ],
        ),
      ),
    );
  }
}
