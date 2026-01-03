import 'package:flutter/material.dart';

class HeroWidget extends StatelessWidget {
  const HeroWidget({super.key, this.title, this.nextPage});

  final String? title;
  final Widget? nextPage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: nextPage == null
          ? null
          : () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => nextPage!),
              );
            },
      child: Hero(
        tag: 'hero-image',
        child: AspectRatio(
          aspectRatio: 1920 / 1080,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              fit: StackFit.expand,
              children: [
                /// Background image
                Image.asset(
                  'assets/images/bg.jpg',
                  fit: BoxFit.cover,
                  color: Colors.teal.withValues(alpha: 0.6),
                  colorBlendMode: BlendMode.darken,
                ),

                /// Optional title overlay
                if (title != null)
                  Positioned(
                    left: 20,
                    bottom: 20,
                    child: Text(
                      title!,
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
