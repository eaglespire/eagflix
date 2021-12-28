import 'dart:convert';

import 'package:eagleflix/models/movie.dart';
import 'package:http/http.dart' as http;

const kApiKey = 'cc978f199d72d32d06ddd2faa54d1052';

class SimilarMovieService {
  List<Movie> _movies = [];

  List<Movie> fetchSimilarMovies() {
    return _movies;
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
          _movies.add(_movie);
        }
      });
    }
  }
}
