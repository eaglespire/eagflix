import 'package:eagleflix/services/trailer_service.dart';
import 'package:eagleflix/widgets/app_drawer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class ViewTrailers extends StatefulWidget {
  const ViewTrailers({Key? key, required this.id, required this.posterPath})
      : super(key: key);
  final int id;
  final String posterPath;
  @override
  _ViewTrailersState createState() => _ViewTrailersState();
}

class _ViewTrailersState extends State<ViewTrailers> {
  TrailerService trailerService = TrailerService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        drawer: const AppDrawer(),
        body: FutureBuilder(
          future: trailerService.searchForTrailers(movieId: 297762),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                  itemCount: snapshot.data.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1 / 2,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return Container(
                      child: Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.grey.shade800,
                            padding: const EdgeInsets.all(17.0),
                          ),
                          onPressed: () async {
                            String myWeb = ' https://preww.com';
                            String url = ' https://www.youtube'
                                '.com/watch?v=${snapshot.data[index].siteKey}';
                            if (await canLaunch(myWeb)) {
                              await launch(myWeb,
                                  forceSafariVC: true, enableJavaScript: true);
                            }
                          },
                          child: Text('Play Trailer ${index + 1}'),
                        ),
                      ),
                      decoration: BoxDecoration(
                        image: widget.posterPath != ''
                            ? DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage('https://image.tmdb'
                                    '.org/t/p/w1280${widget.posterPath}'),
                              )
                            : const DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                    AssetImage('assets/No-image-available.jpg'),
                              ),
                      ),
                    );
                  });
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
