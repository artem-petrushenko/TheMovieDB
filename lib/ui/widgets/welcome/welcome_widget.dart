import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:themoviedb/icons.dart';
import 'package:themoviedb/ui/theme/app_colors.dart';

class WelcomeWidget extends StatefulWidget {
  const WelcomeWidget({Key? key}) : super(key: key);

  @override
  State<WelcomeWidget> createState() => _WelcomeWidgetState();
}

class _WelcomeWidgetState extends State<WelcomeWidget> {
  void _nextPage() {
    Navigator.of(context).pushReplacementNamed('/auth');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 92),
                child: SvgPicture.asset(AppIcons.movit)),
          ),
          Positioned(
            bottom: 131,
            left: 26,
            right: 26,
            child: Container(
              width: double.infinity,
              height: 47,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11.0)),
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    AppColors.kSecondGradientColor,
                    AppColors.kFirstGradientColor
                  ],
                ),
              ),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11.0)),
                onPressed: _nextPage,
                child: Text('Get started',
                    style: Theme.of(context).textTheme.headline4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
