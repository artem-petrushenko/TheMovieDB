import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:themoviedb/domain/data_providers/session_data_provider.dart';

import 'package:themoviedb/ui/theme/app_colors.dart';
import 'package:themoviedb/ui/widgets/movie_list/movie_list_model.dart';

import 'package:themoviedb/ui/widgets/movie_list/movie_list_widget.dart';

import 'package:themoviedb/library/widgets/inherited/provider.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int _selectedIndex = 0;
  final movieListModel = MovieListModel();

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    movieListModel.setupLocale(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          const Text('News'),
          NotifierProvider(
            model: movieListModel,
            child: const MovieListWidget(),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () => SessionDataProvider().setSessionId(null),
              child: const Text('Log Out'),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: GNav(
            backgroundColor: AppColors.kBackgroundColor,
            color: AppColors.kIconColor,
            activeColor: AppColors.kIconColor,
            tabBackgroundColor: AppColors.kIconColor.withOpacity(0.2),
            gap: 8,
            padding: const EdgeInsets.all(16),
            onTabChange: (index) {
              _onItemTapped(index);
            },
            selectedIndex: _selectedIndex,
            tabs: const [
              GButton(icon: Icons.home_rounded, text: 'News'),
              GButton(icon: Icons.movie_filter_rounded, text: 'Movies'),
              GButton(icon: Icons.tv_rounded, text: 'Series'),
            ],
          ),
        ),
      ),
    );
  }
}
