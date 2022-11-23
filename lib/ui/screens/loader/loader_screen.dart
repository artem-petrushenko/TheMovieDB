import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoaderScreen extends StatelessWidget {
  const LoaderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/svg/TMDB.svg',
              height: 200,
              color: const Color(0xFFFE6D8E),
            ),
            const SizedBox(height: 16.0),
            const CircularProgressIndicator(
              color: Color(0xFFFE6D8E),
              strokeWidth: 8,
            ),
          ],
        ),
      ),
    );
  }
}
