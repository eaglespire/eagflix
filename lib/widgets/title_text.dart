import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  TitleText({Key? key, required this.text, required this.year})
      : super(key: key);
  final String? text;
  final String year;
  final TextStyle textStyle = TextStyle(fontWeight: FontWeight.bold);
  String truncateWithEllipsis(String myText, context) {
    int cutoff;
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      cutoff = 20;
    } else {
      cutoff = 10;
    }

    return (myText.length <= cutoff)
        ? myText
        : '${myText.substring(0, cutoff)}...';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0)),
        color: Colors.black,
      ),
      padding: const EdgeInsets.all(6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            truncateWithEllipsis(text!, context),
            style: textStyle,
          ),
          Text(
            year,
            style: textStyle,
          ),
        ],
      ),
    );
  }
}
