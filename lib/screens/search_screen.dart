import 'package:eagleflix/models/actor.dart';
import 'package:eagleflix/models/movie.dart';
import 'package:eagleflix/models/search_result.dart';
import 'package:eagleflix/services/actors_service.dart';
import 'package:eagleflix/services/movie_service.dart';
import 'package:eagleflix/services/search_service.dart';
import 'package:eagleflix/services/similar_movies_service.dart';
import 'package:eagleflix/widgets/movie_thumbnail.dart';
import 'package:eagleflix/widgets/navigate_to_detail.dart';
import 'package:eagleflix/widgets/spinner.dart';
import 'package:eagleflix/widgets/title_text.dart';
import 'package:flutter/material.dart';

import 'detail_page.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Movie> results = [];
  String que = '';
  bool isLoading = true;

  final TextEditingController _searchController = TextEditingController();
  final MovieService _movieService = MovieService();

  void getData(String query) async {
    debugPrint(query);
    await _movieService.searchTMDBMovies(query);

    setState(() {
      results = _movieService.searchResults();
      isLoading = !isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(results);
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (String value) {
            setState(() {
              if (value.isEmpty) {
                results.clear();
                isLoading = true;
              }
            });
          },
          onSubmitted: (String value) {
            //print(value);
            getData(value);
          },
          controller: _searchController,
          decoration: const InputDecoration(
              hintStyle: TextStyle(color: Colors.white),
              hintText: 'Search Movies',
              focusedBorder: OutlineInputBorder(borderSide: BorderSide.none)),
          autofocus: true,
        ),
      ),
      body: isLoading
          ? const Spinner()
          : GridView.builder(
              itemCount: results.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 1 / 2),
              itemBuilder: (BuildContext context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return DetailPage(
                            id: results[index].id,
                            backdropPath: results[index].backdropPath,
                            overview: results[index].overview,
                            year: _movieService.getYear(
                                date: results[index].releaseDate),
                            title: results[index].originalTitle,
                            vote: results[index].voteAverage,
                          );
                        },
                      ),
                    );
                  },
                  child: MovieThumbnail(
                    image: results[index].posterPath,
                    title: results[index].originalTitle,
                    year:
                        _movieService.getYear(date: results[index].releaseDate),
                  ),
                );
              }),
    );
  }
}
