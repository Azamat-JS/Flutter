import 'package:flutter/material.dart';
import 'package:flutter_app/data/constants.dart';
import 'package:flutter_app/views/widgets/container_widget.dart';
import 'package:flutter_app/views/widgets/hero-widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> items = [
      KValue.welcomeText,
      KValue.cleanUI,
      KValue.fixBug,
      KValue.descriptionText,
    ];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            HeroWidget(),
            ...List.generate(items.length, (index) {
              return ContainerWidget(
                title: items[index],
                description: KValue.descriptionText,
                icon: Icons.check_circle_outline,
              );
            }),
          ],
        ),
      ),
    );
  }
}
