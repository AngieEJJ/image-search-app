import 'package:flutter/material.dart';

class PhotoWidget extends StatelessWidget {
  const PhotoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        image: const DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
              'https://pbs.twimg.com/media/GAALXGibsAEI8cD?format=jpg&name=large'),
        ),
      ),
    );
  }
}
