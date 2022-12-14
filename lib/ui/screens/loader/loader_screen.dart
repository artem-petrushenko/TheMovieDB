import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:themoviedb/ui/screens/loader/loader_model.dart';

import 'package:themoviedb/ui/navigation/main_navigation.dart';

class LoaderScreen extends StatelessWidget {
  const LoaderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoaderViewCubit, LoaderViewCubitState>(
      listenWhen: (prev, current) => current != LoaderViewCubitState.unknown,
      listener: onLoaderViewCubitStateChange,
      child: Scaffold(
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
      ),
    );
  }

  void onLoaderViewCubitStateChange(
      BuildContext context, LoaderViewCubitState state) {
    final nextScreen = state == LoaderViewCubitState.authorized
        ? MainNavigationRouteNames.mainScreen
        : MainNavigationRouteNames.authScreen;
    Navigator.of(context).pushReplacementNamed(nextScreen);
  }
}
