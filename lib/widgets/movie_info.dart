import 'package:eagleflix/models/trailer.dart';
import 'package:eagleflix/screens/view_trailers.dart';
import 'package:flutter/material.dart';

class MovieInfo extends StatelessWidget {
  MovieInfo(
      {Key? key,
      required this.posterPath,
      required this.id,
      required this.vote,
      required this.year,
      required this.backdrop,
      required this.title,
      required this.overview})
      : super(key: key);
  final int id;
  final String posterPath;
  final String year;
  final num vote;
  final String? backdrop;
  final String title;
  final String overview;
  final TextStyle _style1 =
      const TextStyle(fontFamily: 'LoraBold', fontSize: 24.0);
  final TextStyle _style2 = const TextStyle(
      fontFamily: 'LoraBold', fontSize: 20.0, color: Colors.grey);

  final TextStyle _btnStyle = TextStyle(
      fontFamily: 'LoraBold', fontSize: 20.0, color: Colors.grey.shade900);

  /*
    Returns a string representation of the average rating
   */
  String getVote(num value) {
    return value.toStringAsFixed(1);
  }

  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    final Orientation orientation = MediaQuery.of(context).orientation;
    print(orientation);
    return Container(
      decoration: BoxDecoration(
        image: backdrop != ''
            ? DecorationImage(
                fit: BoxFit.cover,
                image:
                    NetworkImage('https://image.tmdb.org/t/p/w1280$backdrop'),
              )
            : const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/No-image-available.jpg'),
              ),
      ),
      height: orientation == Orientation.landscape
          ? deviceHeight
          : 0.5 * deviceHeight,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(12.0),
            color: Colors.black,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: _style1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        // Text(
                        //   'Family, Kids',
                        //   style: _style2,
                        // ),
                        Row(
                          children: [
                            Text(
                              year,
                              style: _style2,
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            Row(
                              children: [
                                const Icon(Icons.star),
                                Text(
                                  getVote(vote),
                                  style: _style2,
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.grey.shade300),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ViewTrailers(
                                id: id,
                                posterPath: posterPath,
                              );
                            },
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_right,
                            size: 48.0,
                            color: Colors.grey.shade800,
                          ),
                          Text(
                            'Watch now',
                            style: _btnStyle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
