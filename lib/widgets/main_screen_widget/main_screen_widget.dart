import 'package:flutter/material.dart';

import 'package:themoviedb/theme/app_colors.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'News',
    ),
    Text(
      'Movies',
    ),
    Text(
      'Series',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
            decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(100.0),
                  ),
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(100.0),
                  ),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 0,
                  ),
                ),
                prefixIcon: const Icon(
                  Icons.filter_list_rounded,
                  color: AppColors.kTextColor,
                ),
                suffixIcon: IconButton(
                  splashRadius: 24,
                  color: AppColors.kIconColor,
                  icon: const Icon(Icons.mic_rounded),
                  onPressed: () {},
                ),
                labelText: 'Search in the App',
                labelStyle: Theme.of(context).textTheme.bodyText2),
            style: Theme.of(context).textTheme.bodyText2),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Material(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: BottomNavigationBar(
            elevation: 0,
            backgroundColor: AppColors.kBackgroundWidgetsColor,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.featured_play_list_rounded), label: 'News'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.movie_filter_rounded), label: 'Movies'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.tv_rounded), label: 'Series')
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}