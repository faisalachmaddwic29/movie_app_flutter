import 'package:dio/dio.dart';
import 'package:movie_app/model/cast/cast_response.dart';
import 'package:movie_app/model/genre/genre.dart';
import 'package:movie_app/model/movie/movie.dart';
import 'package:movie_app/model/movie/movie_detail_response.dart';
import 'package:movie_app/model/person/person.dart';
import 'package:movie_app/model/video/video_response.dart';

class MovieRepository {
  final String apiKey4 =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhMDg0Yzk5MmE4MWJlOWYxNzFiYmE4NDE2M2I0NWJlMyIsInN1YiI6IjVlNDNiNmNmMGMyNzEwMDAxYTgzZGM3MyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.ssKnSnGxKa0O-Ciyo8Xp2ClPlUV1qAoQ871Mkpt4BwQ";
  final String apiKey3 = "a084c992a81be9f171bba84163b45be3";
  final String apiKey = "8a1227b5735a7322c4a43a461953d4ff";
  static String mainUrl = "https://api.themoviedb.org/3";

  final _dio = new Dio();

  var getPopularUrl = '$mainUrl/movie/top_rated';
  var getMoviesUrl = '$mainUrl/discover/movie';
  var getPlayingUrl = '$mainUrl/movie/now_playing';
  var getGenresUrl = "$mainUrl/genre/movie/list";
  var getPersonsUrl = "$mainUrl/trending/person/week";
  var movieUrl = "$mainUrl/movie";

  Future<MovieResponse> getMovies() async {
    var params = {
      "api_key": apiKey3,
      "language": "en-US",
      "page": 1,
    };

    try {
      Response response =
          await _dio.get(getPopularUrl, queryParameters: params);
      print(response.data);

      return MovieResponse.fromJson(response.data);
    } catch (e, stackTrace) {
      print("Exception occured : $e stackTrace : $stackTrace");
      return MovieResponse.withError("$e");
    }
  }

  //playing movie
  Future<MovieResponse> getPlayingMovies() async {
    var params = {
      "api_key": apiKey3,
      "language": "en-US",
      "page": 1,
    };

    try {
      Response response =
          await _dio.get(getPlayingUrl, queryParameters: params);
      // print(response.data);
      // var data = response.data['results'];
      // print(data.runtimeType);
      // data.map((i) => {print(i.toString())});

      return MovieResponse.fromJson(response.data);
    } catch (e, stackTrace) {
      print(stackTrace);

      print("Exception occured : $e stackTrace : $stackTrace");
      return MovieResponse.withError("$e");
    }
  }

  //genre
  Future<GenreResponse> getGenres() async {
    var params = {"api_key": apiKey3, "language": "en-US"};

    try {
      Response response = await _dio.get(getGenresUrl, queryParameters: params);
      // print(response.data);
      return GenreResponse.fromJson(response.data);
    } catch (e, stackTrace) {
      print("Exception occured : $e stackTrace : $stackTrace");
      return GenreResponse.withError("$e");
    }
  }

  //persons
  Future<PersonResponse> getPersons() async {
    var params = {"api_key": apiKey3};
    try {
      Response response =
          await _dio.get(getPersonsUrl, queryParameters: params);
      // print(response.data);
      return PersonResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return PersonResponse.withError("$error");
    }
  }

  Future<MovieResponse> getMovieByGenre(int id) async {
    var params = {
      "api_key": apiKey3,
      "language": "en-US",
      "page": 1,
      "with_genres": id,
    };

    try {
      Response response = await _dio.get(getMoviesUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (e, stackTrace) {
      print("Exception occured : $e stackTrace : $stackTrace");
      return MovieResponse.withError("$e");
    }
  }

  Future<MovieDetailResponse> getMovieDetail(int id) async {
    var params = {
      "api_key": apiKey3,
      "language": "en-US",
    };

    try {
      Response response =
          await _dio.get(movieUrl + "/$id", queryParameters: params);
      print(response.data);
      return MovieDetailResponse.fromJson(response.data);
    } catch (e, stackTrace) {
      print("Exception occured : $e stackTrace : $stackTrace");
      return MovieDetailResponse.withError("$e");
    }
  }

  Future<VideoResponse> getMovieVideos(int id) async {
    var params = {"api_key": apiKey3, "language": "en-US"};
    try {
      Response response = await _dio.get(movieUrl + "/$id" + "/videos",
          queryParameters: params);
      return VideoResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return VideoResponse.withError("$error");
    }
  }

  Future<MovieResponse> getSimilarMovies(int id) async {
    var params = {"api_key": apiKey3, "language": "en-US"};
    try {
      Response response = await _dio.get(movieUrl + "/$id" + "/similar",
          queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MovieResponse.withError("$error");
    }
  }

  Future<CastResponse> getCasts(int id) async {
    var params = {"api_key": apiKey3, "language": "en-US"};
    try {
      Response response = await _dio.get(movieUrl + "/$id" + "/credits",
          queryParameters: params);
      return CastResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return CastResponse.withError("$error");
    }
  }
}
