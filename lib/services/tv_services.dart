import 'dart:convert';

import 'package:eagleflix/models/tv.dart';
import 'package:http/http.dart' as http;

const kApiKey = 'cc978f199d72d32d06ddd2faa54d1052';

class TvServices {
  List<Tv> tvShows = [];

  List<Tv> getPopularTVShows() {
    return tvShows;
  }

  List<Tv> getSimilarTVShows() {
    return tvShows;
  }

  String getYear({required String? date}) {
    var dateReleased = date;
    var arr = dateReleased!.split("-");
    String result = arr[0];
    return result;
  }

  Future<void> fetchTVShowsData({required int pageNumber}) async {
    String apiUrl = 'https://api.themoviedb'
        '.org/3/tv/popular?api_key=$kApiKey&language=en-US&page=$pageNumber';

    var parsedUri = Uri.parse(apiUrl);
    var response = await http.get(parsedUri);

    var data = jsonDecode(response.body);
    //print(response.statusCode);

    if (response.statusCode == 200) {
      data["results"].forEach((element) {
        Tv _movie = Tv(
            id: element['id'],
            backdropPath: element['backdrop_path'],
            originalName: element['original_name'],
            overview: element['overview'],
            posterPath: element['poster_path'],
            firstAirDate: element['first_air_date'],
            voteAverage: element['vote_average']);
        tvShows.add(_movie);
      });
    }
  }

  Future<void> fetchSimilarTVShowsData({required int id}) async {
    String apiUrl = 'https://api.themoviedb'
        '.org/3/tv/$id/similar?api_key=$kApiKey&language=en-US&page=1';

    var parsedUri = Uri.parse(apiUrl);
    var response = await http.get(parsedUri);

    var data = jsonDecode(response.body);
    //print(response.statusCode);

    if (response.statusCode == 200) {
      data["results"].forEach((element) {
        print(data['results']);
        Tv _movie = Tv(
            id: element['id'],
            backdropPath: element['backdrop_path'],
            originalName: element['original_name'],
            overview: element['overview'],
            posterPath: element['poster_path'],
            firstAirDate: element['first_air_date'],
            voteAverage: element['vote_average']);
        tvShows.add(_movie);
      });
    }
  }
}
