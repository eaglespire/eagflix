import 'dart:convert';
import 'package:eagleflix/models/trailer.dart';
import 'package:http/http.dart' as http;

const kApiKey = 'cc978f199d72d32d06ddd2faa54d1052';

class TrailerService {
  List<Trailer> trailers = [];

  List<Trailer> fetchTrailers() {
    return trailers;
  }

  Future searchForTrailers({required int movieId}) async {
    String apiUrl = 'https://api.themoviedb'
        '.org/3/movie/$movieId/videos?api_key=$kApiKey&language=en-US';

    var parsedUri = Uri.parse(apiUrl);
    var response = await http.get(parsedUri);
    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      data["results"].forEach((element) {
        Trailer result = Trailer(
          name: element['name'],
          siteKey: element['key'],
          site: element['site'],
        );
        trailers.add(result);
      });
    }
    print(trailers);
    return trailers;
  }
}
