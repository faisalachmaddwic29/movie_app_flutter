import 'dart:io';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/widgets/genres.dart';
import 'package:movie_app/widgets/now_playing.dart';
import 'package:movie_app/widgets/persons.dart';
import 'package:movie_app/widgets/top_movies.dart';
import 'package:path_provider/path_provider.dart';
import '../style/theme.dart' as Style;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.Colors.mainColor,
      appBar: AppBar(
        backgroundColor: Style.Colors.mainColor,
        centerTitle: true,
        leading: Icon(EvaIcons.menu2Outline, color: Colors.white),
        title: Text("Movie App"),
        actions: <Widget>[
          IconButton(
            icon: Icon(EvaIcons.searchOutline),
            onPressed: () async {
              final Directory tempDir = await getTemporaryDirectory();
              final Directory libCacheDir =
                  new Directory("${tempDir.path}/libCachedImageData");
              await libCacheDir.delete(recursive: true);
            },
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          NowPlaying(),
          GenresScreen(),
          Persons(),
          TopMovies(),
        ],
      ),
    );
  }
}
