import 'package:flutter/material.dart';
import 'package:themoviedb/theme/app_colors.dart';

class Movie {
  final int id;
  final String imageName;
  final String title;

  Movie({required this.id, required this.imageName, required this.title});
}

class MovieListWidget extends StatefulWidget {
  const MovieListWidget({Key? key}) : super(key: key);

  @override
  State<MovieListWidget> createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  final _movies = [
    Movie(imageName: 'assets/images/minions.jpg', title: 'Minions', id: 1),
    Movie(imageName: 'assets/images/minions.jpg', title: 'The Batman', id: 2),
    Movie(imageName: 'assets/images/minions.jpg', title: 'Moon Knight', id: 3),
    Movie(
        imageName: 'assets/images/minions.jpg',
        title: 'Spider-Man: No Way Home',
        id: 4),
    Movie(imageName: 'assets/images/minions.jpg', title: 'Shrek', id: 5),
    Movie(imageName: 'assets/images/minions.jpg', title: 'Deadpool', id: 6),
    Movie(
        imageName: 'assets/images/minions.jpg', title: 'After We Fell', id: 7),
    Movie(imageName: 'assets/images/minions.jpg', title: 'Knowing', id: 8),
    Movie(
        imageName: 'assets/images/minions.jpg',
        title: 'Sonic the Hedgehog 2',
        id: 9),
    Movie(
        imageName: 'assets/images/minions.jpg',
        title: 'Stranger Things',
        id: 10),
    Movie(
        imageName: 'assets/images/minions.jpg',
        title: 'The Good Doctor',
        id: 11),
    Movie(
        imageName: 'assets/images/minions.jpg',
        title: 'The Man from Toronto',
        id: 12),
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

  void _onMovieTap(int index) {
    final id = _movies[index].id;
    Navigator.of(context).pushNamed('/main/movie_details', arguments: id);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 8),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: TextFormField(
              controller: _searchController,
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
                  hintText: 'Search in the App',
                  hintStyle: Theme.of(context).textTheme.bodyText2),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 21, left: 26, bottom: 24),
                    child: Text('Search Result',
                        maxLines: 1, style: Theme.of(context).textTheme.button),
                  ),
                  ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _filterMovies.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(height: 22),
                    itemBuilder: (BuildContext context, int index) {
                      final movie = _filterMovies[index];
                      return Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                clipBehavior: Clip.hardEdge,
                                width: double.infinity,
                                height: 120,
                                decoration: const BoxDecoration(
                                  color: AppColors.kBackgroundWidgetsColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Image.asset(movie.imageName),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(movie.title),
                                            const Text('April 7, 2021'),
                                            const Text(
                                              'A fanboy of a supervillain supergroup known as the Vicious 6, Gru hatches a plan to become evil enough to join them, with the backup of his followers, the Minions.',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: 120,
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    hoverColor: Colors.grey[400],
                                    borderRadius: BorderRadius.circular(12),
                                    onTap: () => _onMovieTap(index),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      );
                    },
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 26),
                  //   child: Text('Most popular',
                  //       maxLines: 1, style: Theme.of(context).textTheme.button),
                  // ),
                  // SizedBox(
                  //   height: 247,
                  //   child: ListView.separated(
                  //     scrollDirection: Axis.horizontal,
                  //     padding: const EdgeInsets.symmetric(horizontal: 25),
                  //     shrinkWrap: true,
                  //     itemCount: _movies.length,
                  //     separatorBuilder: (BuildContext context, int index) =>
                  //         const SizedBox(width: 22),
                  //     itemBuilder: (BuildContext context, int index) {
                  //       final movie = _filterMovies[index];
                  //       return Column(children: [
                  //         Container(
                  //           clipBehavior: Clip.hardEdge,
                  //           width: 150,
                  //           height: 215,
                  //           decoration: const BoxDecoration(
                  //             color: AppColors.kBackgroundWidgetsColor,
                  //             borderRadius: BorderRadius.all(
                  //               Radius.circular(12),
                  //             ),
                  //           ),
                  //           child: Image.asset(
                  //             movie.imageName,
                  //             fit: BoxFit.fitWidth,
                  //           ),
                  //         ),
                  //         SizedBox(height: 12),
                  //         Text(movie.title)
                  //       ]);
                  //     },
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 26),
                  //   child: Text('New',
                  //       maxLines: 1, style: Theme.of(context).textTheme.button),
                  // ),
                  // SizedBox(
                  //   height: 247,
                  //   child: ListView.separated(
                  //     scrollDirection: Axis.horizontal,
                  //     padding: const EdgeInsets.symmetric(horizontal: 25),
                  //     shrinkWrap: true,
                  //     itemCount: _movies.length,
                  //     separatorBuilder: (BuildContext context, int index) =>
                  //         const SizedBox(width: 22),
                  //     itemBuilder: (BuildContext context, int index) {
                  //       final movie = _filterMovies[index];
                  //       return Column(children: [
                  //         Container(
                  //           clipBehavior: Clip.hardEdge,
                  //           width: 150,
                  //           height: 215,
                  //           decoration: const BoxDecoration(
                  //             color: AppColors.kBackgroundWidgetsColor,
                  //             borderRadius: BorderRadius.all(
                  //               Radius.circular(12),
                  //             ),
                  //           ),
                  //           child: Image.asset(
                  //             movie.imageName,
                  //             fit: BoxFit.fitWidth,
                  //           ),
                  //         ),
                  //         const SizedBox(height: 12),
                  //         Text(movie.title)
                  //       ]);
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
