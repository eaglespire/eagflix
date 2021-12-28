import 'package:eagleflix/screens/tv_shows.dart';
import 'package:eagleflix/screens/upcoming.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> drawerList = <Widget>[
      const SizedBox(
        height: 20.0,
      ),
      Expanded(
        child: ListTile(
          onTap: () {
            Navigator.pushNamed(context, '/');
          },
          leading: const Icon(Icons.moving),
          title: const Text(
            'Discover',
            style: TextStyle(
                fontSize: 19.0, color: Colors.white, letterSpacing: 1.2),
          ),
        ),
      ),
      Expanded(
        child: ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return Upcoming(title: 'eagleflix');
                },
              ),
            );
          },
          leading: Icon(Icons.movie),
          title: Text(
            'Upcoming Movies',
            style: TextStyle(
                fontSize: 19.0, color: Colors.white, letterSpacing: 1.2),
          ),
        ),
      ),
      Expanded(
        child: ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const TVShows(title: 'eagleflix');
                },
              ),
            );
          },
          leading: Icon(Icons.tv_off),
          title: Text(
            'TV Shows',
            style: TextStyle(
                fontSize: 19.0, color: Colors.white, letterSpacing: 1.2),
          ),
        ),
      ),
      const Expanded(
        child: ListTile(
          leading: Icon(Icons.live_tv),
          title: Text(
            'Videos',
            style: TextStyle(
                fontSize: 19.0, color: Colors.white, letterSpacing: 1.2),
          ),
        ),
      ),
      const Expanded(
        child: ListTile(
          leading: Icon(Icons.tv),
          title: Text(
            'Category',
            style: TextStyle(
                fontSize: 19.0, color: Colors.white, letterSpacing: 1.2),
          ),
        ),
      ),
      Divider(
        color: Colors.grey.shade900,
        thickness: 2.0,
      ),
      const Text(
        'User',
        style:
            TextStyle(fontSize: 19.0, color: Colors.white, letterSpacing: 1.2),
      ),
      const Expanded(
        child: ListTile(
          leading: Icon(Icons.account_circle),
          title: Text(
            'Account',
            style: TextStyle(
                fontSize: 19.0, color: Colors.white, letterSpacing: 1.2),
          ),
        ),
      ),
      const Expanded(
        child: ListTile(
          leading: Icon(Icons.settings),
          title: Text(
            'Settings',
            style: TextStyle(
                fontSize: 19.0, color: Colors.white, letterSpacing: 1.2),
          ),
        ),
      ),
    ];

    return Drawer(
      child: Column(children: drawerList),
    );
  }
}
