import 'package:eagleflix/models/actor.dart';
import 'package:eagleflix/screens/detail_page.dart';
import 'package:eagleflix/services/actors_service.dart';
import 'package:eagleflix/services/similar_movies_service.dart';
import 'package:eagleflix/widgets/app_drawer.dart';
import 'package:eagleflix/widgets/movie_thumbnail.dart';
import 'package:eagleflix/widgets/navigate_to_detail.dart';
import 'package:eagleflix/widgets/spinner.dart';
import 'package:flutter/material.dart';
import 'package:eagleflix/models/movie.dart';
import 'package:eagleflix/services/movie_service.dart';

class Upcoming extends StatefulWidget {
  Upcoming({Key? key, required this.title}) : super(key: key);
  String title;
  @override
  State<Upcoming> createState() => _UpcomingState();
}

class _UpcomingState extends State<Upcoming> {
  bool isLoading = true;
  int pageNumber = 1;
  List<Movie> movies = [];
  final customIcon = const Icon(Icons.search);
  final MovieService _movieService = MovieService();

  void fetchMoviesByPage(int page) async {
    await _movieService.fetchUpcomingMoviesData(pageNumber: page);

    movies = _movieService.fetchUpcomingMovies();

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
    //print(movies);
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
      drawer: AppDrawer(),
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
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return DetailPage(
                                  id: movies[index].id,
                                  backdropPath: movies[index].backdropPath,
                                  overview: movies[index].overview,
                                  year: _movieService.getYear(
                                      date: movies[index].releaseDate),
                                  title: movies[index].originalTitle,
                                  vote: movies[index].voteAverage,
                                );
                              },
                            ),
                          );
                        },
                        child: MovieThumbnail(
                          image: movies[index].posterPath,
                          title: movies[index].originalTitle,
                          year: _movieService.getYear(
                              date: movies[index].releaseDate),
                        ),
                      );
                    },
                  ),
                ),
                ElevatedButton(
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
