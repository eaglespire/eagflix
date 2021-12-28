import 'dart:convert';

import 'package:eagleflix/models/actor.dart';
import 'package:http/http.dart' as http;

const kApiKey = 'cc978f199d72d32d06ddd2faa54d1052';

class ActorService {
  final List<Actor> _actors = [];

  List<Actor> fetchCast() {
    return _actors;
  }

  Future<void> fetchMovieCast({required int id}) async {
    String apiUrl = 'https://api.themoviedb'
        '.org/3/movie/$id/credits?api_key=$kApiKey&language=en-US';

    var parsedUri = Uri.parse(apiUrl);
    var response = await http.get(parsedUri);

    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      data["cast"].forEach((element) {
        //print(data['cast']);
        if (element['original_name'] != null &&
            element['known_for_department'] != null &&
            element['profile_path'] != null) {
          Actor _actor = Actor(
              id: element['id'],
              profilePath: element['profile_path'],
              originalName: element['original_name'],
              knownForDepartment: element['known_for_department']);
          _actors.add(_actor);
        }
      });
    }
  }
}
