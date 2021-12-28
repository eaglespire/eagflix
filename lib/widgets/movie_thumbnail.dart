import 'package:eagleflix/screens/detail_screen.dart';
import 'package:eagleflix/widgets/title_text.dart';
import 'package:flutter/material.dart';

class MovieThumbnail extends StatelessWidget {
  const MovieThumbnail(
      {Key? key, required this.image, required this.title, required this.year})
      : super(key: key);

  final String? title;
  final String? image;
  final String year;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(10.0),
        ),
        image: image != null
            ? DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage('https://image.tmdb.org/t/p/w185$image'),
              )
            : const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/No-image-available.jpg'),
              ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TitleText(
            text: title ?? 'Not Available',
            year: year,
          ),
        ],
      ),
    );
  }
}
