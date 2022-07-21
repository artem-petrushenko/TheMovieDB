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
        title: 'Spider-Man: No Way Home', id: 4),
    Movie(imageName: 'assets/images/minions.jpg', title: 'Shrek', id: 5),
    Movie(imageName: 'assets/images/minions.jpg', title: 'Deadpool', id: 6),
    Movie(imageName: 'assets/images/minions.jpg', title: 'After We Fell', id: 7),
    Movie(imageName: 'assets/images/minions.jpg', title: 'Knowing', id: 8),
    Movie(
        imageName: 'assets/images/minions.jpg', title: 'Sonic the Hedgehog 2', id: 9),
    Movie(imageName: 'assets/images/minions.jpg', title: 'Stranger Things', id: 10),
    Movie(imageName: 'assets/images/minions.jpg', title: 'The Good Doctor', id: 11),
    Movie(
        imageName: 'assets/images/minions.jpg', title: 'The Man from Toronto', id: 12),
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

  void _onMovieTap(int index){
    final id = _movies[index].id;
    Navigator.of(context).pushNamed('/main/movie_details', arguments: id);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
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
                      Radius.circular(32.0),
                    ),
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(32.0),
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
                    padding: const EdgeInsets.only(
                      left: 20,
                      bottom: 24,
                    ),
                    child: Text(
                      'Most Popular',
                      style: Theme.of(context).textTheme.button,
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 245,
                    child: ListView.separated(
                      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                              highlightColor: AppColors.kIconColor.withOpacity(0.25),
                              splashColor: AppColors.kIconColor.withOpacity(0.35),
                              borderRadius: const BorderRadius.all(Radius.circular(30)),
                              onTap: () => _onMovieTap(index)
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            movie.title,
                            style: Theme.of(context).textTheme.subtitle2,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )
                        ]);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(width: 22);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 24, top: 24),
                    child: Text(
                      'New',
                      style: Theme.of(context).textTheme.button,
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 245,
                    child: ListView.separated(
                      // physics: const BouncingScrollPhysics(),
                      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                              highlightColor: AppColors.kIconColor.withOpacity(0.25),
                              splashColor: AppColors.kIconColor.withOpacity(0.35),
                              borderRadius: const BorderRadius.all(Radius.circular(30)),
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
                        ]);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(width: 22);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
