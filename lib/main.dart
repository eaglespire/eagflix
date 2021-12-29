import 'package:eagleflix/screens/detail_screen.dart';
import 'package:eagleflix/screens/home.dart';
import 'package:eagleflix/screens/search_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  final appBarTitle = 'eagleflix';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Home(title: appBarTitle),
        '/search': (context) => SearchScreen(title: appBarTitle),
      },
      theme: ThemeData.dark(),
    );
  }
}
