import 'package:flutter/material.dart';

class HeroWidget extends StatelessWidget {
  const HeroWidget({super.key, this.title, this.nextPage});

  final String? title;
  final Widget? nextPage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return nextPage!;
            },
          ),
        );
      },
      child: Hero(
        tag: 'hero-image',
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            'assets/images/bg.jpg',
            color: Colors.teal,
            colorBlendMode: BlendMode.darken,
          ),
        ),
      ),
    );
  }
}
