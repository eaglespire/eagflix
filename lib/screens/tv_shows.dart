import 'package:eagleflix/models/tv.dart';
import 'package:eagleflix/screens/detail_page.dart';
import 'package:eagleflix/screens/tv_detail.dart';
import 'package:eagleflix/services/tv_services.dart';
import 'package:eagleflix/widgets/app_drawer.dart';
import 'package:eagleflix/widgets/movie_thumbnail.dart';
import 'package:eagleflix/widgets/spinner.dart';
import 'package:flutter/material.dart';
import 'package:eagleflix/models/movie.dart';
import 'package:eagleflix/services/movie_service.dart';

class TVShows extends StatefulWidget {
  const TVShows({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<TVShows> createState() => _TVShowsState();
}

class _TVShowsState extends State<TVShows> {
  bool isLoading = true;
  int pageNumber = 1;
  List<Tv> movies = [];
  final customIcon = const Icon(Icons.search);
  final TvServices _tvServices = TvServices();

  void fetchMoviesByPage(int page) async {
    await _tvServices.fetchTVShowsData(pageNumber: page);

    movies = _tvServices.getPopularTVShows();

    setState(() {
      isLoading = false;
      //movies = _movieService.fetchHighestRatedMovies();
    });

    //print(movies);
  }

  @override
  void initState() {
    super.initState();
    fetchMoviesByPage(pageNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/search');
            },
            icon: customIcon,
          )
        ],
      ),
      drawer: const AppDrawer(),
      body: isLoading
          ? const Spinner()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 10.0,
                            crossAxisSpacing: 10.0,
                            childAspectRatio: 1 / 2),
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      // return NavigateToDetail(
                      //   movies: movies,
                      //   index: index,
                      // );
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return TvDetail(
                                  id: movies[index].id,
                                  backdropPath: movies[index].backdropPath,
                                  overview: movies[index].overview,
                                  year: _tvServices.getYear(
                                      date: movies[index].firstAirDate),
                                  title: movies[index].originalName,
                                  vote: movies[index].voteAverage,
                                  posterPath: movies[index].posterPath,
                                );
                              },
                            ),
                          );
                        },
                        child: MovieThumbnail(
                          image: movies[index].posterPath,
                          title: movies[index].originalName,
                          year: _tvServices.getYear(
                              date: movies[index].firstAirDate),
                        ),
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey.shade800,
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                  ),
                  onPressed: () {
                    setState(() {
                      pageNumber++;
                      fetchMoviesByPage(pageNumber);
                    });
                    debugPrint('$pageNumber');
                  },
                  child: const Text('LOAD MORE'),
                )
              ],
            ),
    );
  }
}
