import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:themoviedb/theme/app_colors.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Text('News'),
    Text('Movies'),
    Text('Series'),
  ];

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: TextFormField(
      //       decoration: InputDecoration(
      //           focusedBorder: const OutlineInputBorder(
      //             borderSide: BorderSide.none,
      //             borderRadius: BorderRadius.all(
      //               Radius.circular(100.0),
      //             ),
      //           ),
      //           border: const OutlineInputBorder(
      //             borderRadius: BorderRadius.all(
      //               Radius.circular(100.0),
      //             ),
      //             borderSide: BorderSide(
      //               color: Colors.transparent,
      //               width: 0,
      //             ),
      //           ),
      //           prefixIcon: const Icon(
      //             Icons.filter_list_rounded,
      //             color: AppColors.kTextColor,
      //           ),
      //           suffixIcon: IconButton(
      //             splashRadius: 24,
      //             color: AppColors.kIconColor,
      //             icon: const Icon(Icons.mic_rounded),
      //             onPressed: () {},
      //           ),
      //           labelText: 'Search in the App',
      //           labelStyle: Theme.of(context).textTheme.bodyText2),
      //       style: Theme.of(context).textTheme.bodyText2),
      // ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
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
