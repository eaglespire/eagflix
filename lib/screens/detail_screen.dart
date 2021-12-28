import 'package:eagleflix/models/actor.dart';
import 'package:eagleflix/models/movie.dart';
import 'package:eagleflix/services/actors_service.dart';
import 'package:eagleflix/widgets/movie_info.dart';
import 'package:eagleflix/widgets/movie_overview.dart';
import 'package:eagleflix/widgets/movie_thumbnail.dart';
import 'package:eagleflix/widgets/navigate_to_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    TextStyle _style3 = const TextStyle(
        fontFamily: 'NunitoMedium',
        fontSize: 17.0,
        color: Colors.grey,
        letterSpacing: 1.2);
    TextStyle _style2 = const TextStyle(
        fontFamily: 'NunitoBold',
        fontSize: 20.0,
        color: Colors.grey,
        letterSpacing: 1.2);
    TextStyle _style1 = const TextStyle(
        fontFamily: 'NunitoBold',
        fontSize: 23.0,
        color: Colors.white,
        letterSpacing: 1.2);

    var movieInfo =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    List actors = movieInfo['actors'] as List;
    List<Movie> similarMovies = movieInfo['similarMovies'];
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/search');
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MovieInfo(
                vote: movieInfo['vote'] ?? 0.0,
                year: movieInfo['year'] ?? '1900',
                title: movieInfo['title'] ?? 'Not Available',
                backdrop: movieInfo['backdrop'] ?? 'k.jpg',
                overview: movieInfo['overview'] ?? 'Not available'),
            const Divider(
              thickness: 1.3,
              color: Colors.grey,
            ),
            MovieOverview(
                description: movieInfo['overview'] ??
                    'Not '
                        'Available'),
            Text(
              'Casts:',
              style: _style2,
            ),
            Wrap(
              spacing: 5.0,
              runSpacing: 5.0,
              runAlignment: WrapAlignment.spaceBetween,
              alignment: WrapAlignment.spaceBetween,
              children: List.generate(
                10,
                (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${actors[index].originalName},',
                    style: _style3,
                  ),
                ),
              ),
            ),
            const Divider(
              thickness: 1.3,
              color: Colors.grey,
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              'Similar movies',
              style: _style1,
            ),
            const SizedBox(
              height: 10.0,
            ),
            SizedBox(
              height: 300.0,
              child: GridView.builder(
                itemCount: similarMovies.length,
                scrollDirection: Axis.horizontal,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return NavigateToDetail(movies: similarMovies, index: index);
                },
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}
