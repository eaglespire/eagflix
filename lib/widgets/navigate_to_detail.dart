import 'package:eagleflix/models/actor.dart';
import 'package:eagleflix/models/movie.dart';
import 'package:eagleflix/services/actors_service.dart';
import 'package:eagleflix/services/similar_movies_service.dart';
import 'package:flutter/material.dart';

import 'movie_thumbnail.dart';

class NavigateToDetail extends StatelessWidget {
  const NavigateToDetail(
      {Key? key,
      required this.movies,
      // required this.movieList,
      required this.index})
      : super(key: key);

  final List<Movie> movies;
  //final List<Map> movieList;
  final int index;

  @override
  Widget build(BuildContext context) {
    /*
        Get the year the movie was released
         */
    var date = movies[index].releaseDate;
    var result = date!.split("-");
    var year = result[0];
    return GestureDetector(
      onTap: () async {
        List<Actor> actors = [];
        List<Movie> similarMovies = [];
        //make the api call to fetch movie cast  and similar movies
        //only navigate when call is successful
        ActorService _actorService = ActorService();

        await _actorService.fetchMovieCast(id: movies[index].id);
        actors = _actorService.fetchCast();
        //print(actors.length);

        SimilarMovieService _similarMovieService = SimilarMovieService();

        await _similarMovieService.fetchSimilarMoviesData(id: movies[index].id);
        similarMovies = _similarMovieService.fetchSimilarMovies();
        print(similarMovies.length);

        Navigator.pushNamed(context, '/movies/detail', arguments: {
          'id': movies[index].id,
          'title': movies[index].originalTitle,
          'year': year,
          'image': movies[index].posterPath,
          'backdrop': movies[index].backdropPath,
          'overview': movies[index].overview,
          'actors': actors,
          'vote': movies[index].voteAverage,
          'similarMovies': similarMovies
        });
      },
      child: MovieThumbnail(
          image: movies[index].posterPath,
          title: movies[index].originalTitle,
          year: year),
    );
  }
}
