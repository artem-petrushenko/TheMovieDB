import 'package:flutter/material.dart';

import 'package:themoviedb/domain/factory/screen_factory.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int _selectedIndex = 0;
  final _screenFactory = ScreenFactory();

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
        children: [
          _screenFactory.makeNewsList(),
          _screenFactory.makeMoviesList(),
          _screenFactory.makeTVShowsList(),
          _screenFactory.makeUser(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        showSelectedLabels: false,
        unselectedIconTheme: const IconThemeData(color: Colors.purple),
        selectedIconTheme: const IconThemeData(color: Colors.purple),
        currentIndex: _selectedIndex,
        onTap: (index) => _onItemTapped(index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie_filter_rounded),
            label: 'Movies',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tv_rounded),
            label: 'Series',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'User',
          ),
        ],
      ),
    );
  }
}
