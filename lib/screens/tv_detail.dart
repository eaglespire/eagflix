import 'package:eagleflix/models/actor.dart';
import 'package:eagleflix/models/movie.dart';
import 'package:eagleflix/models/tv.dart';
import 'package:eagleflix/services/actors_service.dart';
import 'package:eagleflix/services/movie_service.dart';
import 'package:eagleflix/services/tv_services.dart';
import 'package:eagleflix/widgets/movie_info.dart';
import 'package:eagleflix/widgets/movie_overview.dart';
import 'package:eagleflix/widgets/movie_thumbnail.dart';
import 'package:eagleflix/widgets/spinner.dart';
import 'package:flutter/material.dart';

class TvDetail extends StatefulWidget {
  const TvDetail(
      {Key? key,
      required this.id,
      required this.backdropPath,
      required this.overview,
      required this.title,
      required this.vote,
      required this.year})
      : super(key: key);
  final int id;
  final String? backdropPath;
  final String? overview;
  final String? title;
  final String? year;
  final num? vote;

  @override
  State<TvDetail> createState() => _TvDetailState();
}

class _TvDetailState extends State<TvDetail> {
  List<Actor> actors = [];
  List<Tv> movies = [];
  bool isLoading = true;
  final TvServices _tvServices = TvServices();

  void getData() async {
    /*
    Fetch movie cast
     */
    ActorService _actorService = ActorService();
    await _actorService.fetchMovieCast(id: widget.id);
    actors = _actorService.fetchCast();

    /*
      Fetch similar movies
     */

    await _tvServices.fetchSimilarTVShowsData(id: widget.id);
    movies = _tvServices.getSimilarTVShows();

    setState(() {
      isLoading = false;
    });
  }

  final TextStyle _style3 = const TextStyle(
      fontFamily: 'NunitoMedium',
      fontSize: 17.0,
      color: Colors.grey,
      letterSpacing: 1.2);

  final TextStyle _style2 = const TextStyle(
      fontFamily: 'NunitoBold',
      fontSize: 20.0,
      color: Colors.grey,
      letterSpacing: 1.2);

  final TextStyle _style1 = const TextStyle(
      fontFamily: 'NunitoBold',
      fontSize: 23.0,
      color: Colors.white,
      letterSpacing: 1.2);

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.title);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('eagleflix'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/search');
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: isLoading
          ? const Spinner()
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MovieInfo(
                      vote: widget.vote ?? 0.0,
                      year: widget.year ?? '1900',
                      title: widget.title ?? 'Not Available',
                      backdrop: widget.backdropPath ?? '',
                      overview: widget.overview ?? 'Not available'),
                  const Divider(
                    thickness: 1.3,
                    color: Colors.grey,
                  ),
                  MovieOverview(description: widget.overview),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Casts:',
                      style: _style2,
                    ),
                  ),
                  actors.length < 8
                      ? Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Not yet available ',
                            style: _style3,
                          ),
                        )
                      : Wrap(
                          spacing: 5.0,
                          runSpacing: 5.0,
                          runAlignment: WrapAlignment.spaceBetween,
                          alignment: WrapAlignment.spaceBetween,
                          children: List.generate(
                            8,
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
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Similar Tv Shows',
                      style: _style1,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    height: 300.0,
                    child: GridView.builder(
                      itemCount: movies.length,
                      scrollDirection: Axis.horizontal,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return TvDetail(
                                    id: movies[index].id,
                                    backdropPath: movies[index].backdropPath,
                                    overview: movies[index].overview,
                                    year: _tvServices.getYear(
                                        date: movies[index].firstAirDate),
                                    title: movies[index].originalName,
                                    vote: movies[index].voteAverage,
                                  );
                                },
                              ),
                            );
                          },
                          child: MovieThumbnail(
                            image: movies[index].posterPath,
                            title: movies[index].originalName,
                            year: _tvServices.getYear(
                                date: movies[index].firstAirDate),
                          ),
                        );
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
