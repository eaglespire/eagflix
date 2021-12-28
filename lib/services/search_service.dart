import 'dart:convert';

import 'package:eagleflix/models/search_result.dart';
import 'package:http/http.dart' as http;

const kApiKey = 'cc978f199d72d32d06ddd2faa54d1052';

class SearchService {
  List<SearchResult> results = [];

  List<SearchResult> getSearchResult() {
    return results;
  }

  String getYear({required String? date}) {
    var dateReleased = date;
    var arr = dateReleased!.split("-");
    String result = arr[0];
    return result;
  }

  Future<void> fetchMovies(String query) async {
    String apiUrl = 'https://api.themoviedb'
        '.org/3/search/movie?api_key=$kApiKey&language=en-US&query=$query';

    var parsedUri = Uri.parse(apiUrl);
    var response = await http.get(parsedUri);

    var data = jsonDecode(response.body);
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      data["results"].forEach((element) {
        SearchResult result = SearchResult(
          id: element['id'],
          posterPath: element['poster_path'],
          releaseDate: element['release_date'],
          originalTitle: element['original_title'],
          backdropPath: element['backdrop_path'],
          overview: element['overview'],
          voteAverage: element['vote_average'],
        );
        results.add(result);
      });
    }
  }
}
