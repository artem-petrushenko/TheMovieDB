import 'package:flutter/material.dart';
import 'package:themoviedb/theme/app_colors.dart';

class Movie {
  final String imageName;
  final String title;

  Movie({required this.imageName, required this.title});
}

class MovieListWidget extends StatefulWidget {
  const MovieListWidget({Key? key}) : super(key: key);

  @override
  State<MovieListWidget> createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  final _movies = [
    Movie(imageName: 'assets/images/minions.jpg', title: 'Minions'),
    Movie(imageName: 'assets/images/minions.jpg', title: 'The Batman'),
    Movie(imageName: 'assets/images/minions.jpg', title: 'Moon Knight'),
    Movie(
        imageName: 'assets/images/minions.jpg',
        title: 'Spider-Man: No Way Home'),
    Movie(imageName: 'assets/images/minions.jpg', title: 'Shrek'),
    Movie(imageName: 'assets/images/minions.jpg', title: 'Deadpool'),
    Movie(imageName: 'assets/images/minions.jpg', title: 'After We Fell'),
    Movie(imageName: 'assets/images/minions.jpg', title: 'Knowing'),
    Movie(
        imageName: 'assets/images/minions.jpg', title: 'Sonic the Hedgehog 2'),
    Movie(imageName: 'assets/images/minions.jpg', title: 'Stranger Things'),
    Movie(imageName: 'assets/images/minions.jpg', title: 'The Good Doctor'),
    Movie(
        imageName: 'assets/images/minions.jpg', title: 'The Man from Toronto'),
  ];

  final _searchController = TextEditingController();

  var _filterMovies = <Movie>[];

  void _searchMovies() {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      _filterMovies = _movies.where((Movie movie) {
        return movie.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    } else {
      _filterMovies = _movies;
    }
    setState(() {});
  }

  @override
  void initState() {
    _filterMovies = _movies;
    _searchController.addListener(_searchMovies);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          // physics: const BouncingScrollPhysics(),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 56 + 29),
          children: [
            SizedBox(
              width: double.infinity,
              height: 245,
                child: ListView.separated(
                  // physics: const BouncingScrollPhysics(),
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  scrollDirection: Axis.horizontal,
                  itemCount: _filterMovies.length,
                  itemBuilder: (BuildContext context, int index) {
                    final movie = _filterMovies[index];
                    return Column(children: [
                        Ink(
                          width: 150,
                          height: 215,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            image: DecorationImage(
                              image: AssetImage(
                                movie.imageName,
                              ),
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          child: InkWell(
                            highlightColor:
                                AppColors.kIconColor.withOpacity(0.25),
                            splashColor: AppColors.kIconColor.withOpacity(0.35),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30)),
                            onTap: () {},
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          movie.title,
                          style: Theme.of(context).textTheme.subtitle2,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      ]
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(width: 22);
                  },
                ),
            ),
            Container(
              color: Colors.red,
              width: 100,
              height: 500,
            ),
            Container(
              color: Colors.green,
              width: 100,
              height: 500,
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
              left: 12, right: 12, top: MediaQuery.of(context).padding.top + 8),
          child: TextFormField(
            controller: _searchController,
            decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.kBackgroundWidgetsColor,
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
                hintText: 'Search in the App',
                hintStyle: Theme.of(context).textTheme.bodyText2),
          ),
        ),
      ],
    );

    // return Stack(
    //   children: [
    //     ListView.separated(
    //       keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
    //       padding: const EdgeInsets.only(top: 70),
    //       shrinkWrap: true,
    //       // scrollDirection: Axis.horizontal,
    //       itemCount: _filterMovies.length,
    //       itemBuilder: (BuildContext context, int index) {
    //         final movie = _filterMovies[index];
    //         return Column(
    //           children: [
    //             Ink(
    //               width: 150,
    //               height: 215,
    //               decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(30),
    //                 image: DecorationImage(
    //                     image: AssetImage(movie.imageName), fit: BoxFit.fill),
    //               ),
    //               child: InkWell(
    //                 highlightColor: AppColors.kIconColor.withOpacity(0.25),
    //                 splashColor: AppColors.kIconColor.withOpacity(0.35),
    //                 borderRadius: const BorderRadius.all(Radius.circular(30)),
    //                 onTap: () {},
    //               ),
    //             ),
    //             const SizedBox(height: 12),
    //             Text(movie.title, style: Theme.of(context).textTheme.subtitle2)
    //           ],
    //         );
    //       },
    //       separatorBuilder: (BuildContext context, int index) {
    //         return const SizedBox(width: 22);
    //       },
    //     ),
    //     Padding(
    //       padding: EdgeInsets.only(
    //           left: 12,
    //           right: 12,
    //           top: MediaQuery.of(context).padding.top + 8,
    //           bottom: 29),
    //       child: TextFormField(
    //         controller: _searchController,
    //         decoration: InputDecoration(
    //             filled: true,
    //             fillColor: AppColors.kBackgroundWidgetsColor.withOpacity(0.9),
    //             focusedBorder: const OutlineInputBorder(
    //               borderSide: BorderSide.none,
    //               borderRadius: BorderRadius.all(
    //                 Radius.circular(100.0),
    //               ),
    //             ),
    //             border: const OutlineInputBorder(
    //               borderRadius: BorderRadius.all(
    //                 Radius.circular(100.0),
    //               ),
    //               borderSide: BorderSide(
    //                 color: Colors.transparent,
    //                 width: 0,
    //               ),
    //             ),
    //             prefixIcon: const Icon(
    //               Icons.filter_list_rounded,
    //               color: AppColors.kTextColor,
    //             ),
    //             suffixIcon: IconButton(
    //               splashRadius: 24,
    //               color: AppColors.kIconColor,
    //               icon: const Icon(Icons.mic_rounded),
    //               onPressed: () {},
    //             ),
    //             labelText: 'Search in the App',
    //             labelStyle: Theme.of(context).textTheme.bodyText2),
    //       ),
    //     ),
    //   ],
    // );
  }
}
