import 'dart:convert';

import 'package:eagleflix/models/movie.dart';
import 'package:http/http.dart' as http;

const kApiKey = 'cc978f199d72d32d06ddd2faa54d1052';
const kImageUrl = 'https://image.tmdb.org/t/p/w185/SPECIFICMOVIEPOSTERPATH';
//https://image.tmdb.org/t/p/w185/SPECIFICMOVIEPOSTERPATH

class MovieService {
  List<Movie> movies = [];
  List<Movie> searches = [];
  List<Movie> upcoming = [];

  List<Movie> fetchHighestRatedMovies() {
    return movies;
  }

  List<Movie> fetchUpcomingMovies() {
    return movies;
  }

  List<Movie> searchResults() {
    return searches;
  }

  List<Movie> fetchSimilarMovies() {
    return movies;
  }

  String getYear({required String? date}) {
    var dateReleased = date;
    var arr = dateReleased!.split("-");
    String result = arr[0];
    return result;
  }

  String getVote({required num value}) {
    return value.toStringAsFixed(2);
  }

  Future<void> searchTMDBMovies(String query) async {
    String apiUrl = 'https://api.themoviedb'
        '.org/3/search/movie?api_key=$kApiKey&language=en-US&query=$query';

    var parsedUri = Uri.parse(apiUrl);
    var response = await http.get(parsedUri);

    var data = jsonDecode(response.body);
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      data["results"].forEach((element) {
        Movie result = Movie(
          id: element['id'],
          posterPath: element['poster_path'],
          releaseDate: element['release_date'],
          originalTitle: element['original_title'],
          backdropPath: element['backdrop_path'],
          overview: element['overview'],
          voteAverage: element['vote_average'],
        );
        searches.add(result);
      });
    }
  }

  Future<void> fetchMovies({required int pageNumber}) async {
    String apiUrl = 'https://api.themoviedb'
        '.org/3/movie/popular?api_key=$kApiKey&language=en-US&page=$pageNumber';

    var parsedUri = Uri.parse(apiUrl);
    var response = await http.get(parsedUri);

    var data = jsonDecode(response.body);
    //print(response.statusCode);

    if (response.statusCode == 200) {
      data["results"].forEach((element) {
        Movie _movie = Movie(
            id: element['id'],
            backdropPath: element['backdrop_path'],
            originalTitle: element['original_title'],
            overview: element['overview'],
            posterPath: element['poster_path'],
            releaseDate: element['release_date'],
            voteAverage: element['vote_average']);
        movies.add(_movie);
      });
    }
  }

  Future<void> fetchSimilarMoviesData({required int id}) async {
    String apiUrl = 'https://api.themoviedb'
        '.org/3/movie/$id/similar?api_key=$kApiKey&language=en-US&page=1';

    var parsedUri = Uri.parse(apiUrl);
    var response = await http.get(parsedUri);

    var data = jsonDecode(response.body);
    //print(response.statusCode);

    if (response.statusCode == 200) {
      data["results"].forEach((element) {
        print(data['results']);
        if (element['original_title'] != null &&
            element['vote_average'] != null &&
            element['overview'] != null &&
            element['release_date'] != null) {
          Movie _movie = Movie(
              id: element['id'],
              backdropPath: element['backdrop_path'],
              originalTitle: element['original_title'],
              overview: element['overview'],
              releaseDate: element['release_date'],
              posterPath: element['poster_path'],
              voteAverage: element['vote_average']);
          movies.add(_movie);
        }
      });
    }
  }

  Future<void> fetchUpcomingMoviesData({required int pageNumber}) async {
    String apiUrl = 'https://api.themoviedb'
        '.org/3/movie/upcoming?api_key=$kApiKey&language=en-US&page=$pageNumber';

    var parsedUri = Uri.parse(apiUrl);
    var response = await http.get(parsedUri);

    var data = jsonDecode(response.body);
    //print(response.body);

    if (response.statusCode == 200) {
      data["results"].forEach((element) {
        print(data['results']);
        if (element['original_title'] != null &&
            element['vote_average'] != null &&
            element['overview'] != null &&
            element['release_date'] != null) {
          Movie _movie = Movie(
              id: element['id'],
              backdropPath: element['backdrop_path'],
              originalTitle: element['original_title'],
              overview: element['overview'],
              releaseDate: element['release_date'],
              posterPath: element['poster_path'],
              voteAverage: element['vote_average']);
          movies.add(_movie);
        }
      });
    }
  }
}
