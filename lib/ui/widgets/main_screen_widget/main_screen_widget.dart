import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:themoviedb/ui/theme/app_colors.dart';

import 'package:themoviedb/ui/widgets/movie_list/movie_list_widget.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          Text('News'),
          MovieListWidget(),
          Text('Series'),
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
