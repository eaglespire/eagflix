import 'package:flutter/material.dart';

class MovieOverview extends StatelessWidget {
  const MovieOverview({Key? key, required this.description}) : super(key: key);
  final String? description;
  final TextStyle _style3 = const TextStyle(
      fontFamily: 'NunitoMedium',
      fontSize: 19.0,
      color: Colors.grey,
      letterSpacing: 1.2);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Text(
            description ?? "No Overview Available",
            style: _style3,
          ),
          const Divider(
            thickness: 1.3,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
