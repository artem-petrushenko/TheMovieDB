import 'package:flutter/material.dart';
import 'package:themoviedb/library/widgets/inherited/provider.dart';
import 'package:themoviedb/ui/theme/app_colors.dart';
import 'package:themoviedb/ui/widgets/movie_list/movie_list_model.dart';
import 'package:themoviedb/domain/api_client/image_downloader.dart';

class MovieListWidget extends StatelessWidget {
  const MovieListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieListModel>(context);
    if (model == null) return const SizedBox.shrink();
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 8),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: TextFormField(
              onChanged: model.searchMovie,
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
                    itemCount: model.movies.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(height: 22),
                    itemBuilder: (BuildContext context, int index) {
                      model.showedMovieAtIndex(index);
                      final movie = model.movies[index];
                      final posterPath = movie.posterPath;
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
                                    posterPath != null
                                        ? Image.network(
                                            ImageDownloader.imageUrl(
                                                posterPath),
                                            width: 95,
                                          )
                                        : const SizedBox.shrink(),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(movie.title),
                                            Text(
                                              model.stringFromDate(
                                                  movie.releaseDate),
                                            ),
                                            Text(
                                              movie.overview,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
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
                                    onTap: () =>
                                        model.onMovieTap(context, index),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      );
                    },
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
