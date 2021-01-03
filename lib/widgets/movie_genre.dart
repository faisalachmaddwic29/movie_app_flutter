import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_app/bloc/get_movies_byGenre_bloc.dart';
import 'package:movie_app/model/movie/movie.dart';
import 'package:movie_app/screens/detail_screen.dart';
import 'add_margin.dart';
import '../style/theme.dart' as Style;

class MovieGenre extends StatefulWidget {
  final int genreId;
  MovieGenre({Key key, this.genreId}) : super(key: key);
  @override
  _MovieGenreState createState() => _MovieGenreState(genreId);
}

class _MovieGenreState extends State<MovieGenre> {
  final int genreId;
  _MovieGenreState(this.genreId);

  @override
  void initState() {
    moviesByGenreBloc..getMoviesByGenre(genreId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieResponse>(
        stream: moviesByGenreBloc.subject.stream,
        builder: (context, AsyncSnapshot<MovieResponse> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.error != null && snapshot.data.error.length > 0) {
              return _buildErrorWidget(snapshot.data.error);
            }
            return _buildMoviesByGenreWidget(snapshot.data);
          } else if (snapshot.hasError) {
            return _buildErrorWidget(snapshot.error);
          } else {
            return _buildLoadingWidget();
          }
        });
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 25.0,
            width: 25.0,
            child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 4.0,
            ),
          ),
        ],
      ).addMarginBottom(10),
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occured: $error"),
      ],
    ));
  }

  Widget _buildMoviesByGenreWidget(MovieResponse data) {
    List<Movie> movies = data.movies;
    if (movies.length == 0) {
      return Container(
        child: Text("No Movies"),
      );
    } else
      return Container(
        height: 270,
        padding: EdgeInsets.only(left: 10.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        MovieDetailScreen(movie: movies[index]),
                  ),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Container(
                  //   width: 120,
                  //   height: 180,
                  //   child: FadeInImage.assetNetwork(
                  //     placeholder: ,
                  //     image: (movies[index].poster != null)
                  //         ? "https://image.tmdb.org/t/p/w200" +
                  //             movies[index].poster
                  //         : "https://www.askkatya.com/wp-content/themes/gonzo/images/no-image-featured-image.png",
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                  Container(
                    width: 120,
                    height: 180,
                    child: CachedNetworkImage(
                      imageUrl: (movies[index].poster != null)
                          ? "https://image.tmdb.org/t/p/w200" +
                              movies[index].poster
                          : "https://www.askkatya.com/wp-content/themes/gonzo/images/no-image-featured-image.png",
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                      placeholder: (context, url) => Lottie.network(
                          "https://assets4.lottiefiles.com/packages/lf20_x62chJ.json"),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  // Container(
                  //   width: 120,
                  //   height: 180,
                  //   decoration: BoxDecoration(
                  //     color: Style.Colors.secondColor,
                  //     borderRadius: BorderRadius.all(Radius.circular(2.0)),
                  //     shape: BoxShape.rectangle,
                  //     image: DecorationImage(
                  //       image: NetworkImage((movies[index].poster != null)
                  //           ? "https://image.tmdb.org/t/p/w200" +
                  //               movies[index].poster
                  //           : "https://www.askkatya.com/wp-content/themes/gonzo/images/no-image-featured-image.png"),
                  //       fit: BoxFit.cover,
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: 100,
                    child: Text(
                      movies[index].title,
                      maxLines: 2,
                      style: TextStyle(
                        height: 1.4,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 11.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        (movies[index].rating / 2).toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      RatingBar(
                        itemSize: 8.0,
                        initialRating: movies[index].rating / 2,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                        itemBuilder: (context, _) => Icon(
                          EvaIcons.star,
                          color: Style.Colors.secondColor,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      )
                    ],
                  ),
                ],
              ).addMarginOnly(left: 5),
            );
          },
        ),
      );
  }
}
