import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:movies_app/models/movie_model.dart';
import 'package:movies_app/models/video_trailer.dart';

class MovieApiProvider {
  final _baseUrl = "http://api.themoviedb.org/3/movie";
  final _apiKey = "";

  Future<List<Movie>> fetchMovieList() async {
    final response =
        await http.get(Uri.parse("$_baseUrl/top_rated?api_key=$_apiKey"));
    if (response.statusCode == 200) {
      return MoviesModel.fromJson(json.decode(response.body)).results;
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<VideoTrailers> fetchVideoTrailers(int movieId) async {
    final response =
        await http.get(Uri.parse("$_baseUrl/$movieId/videos?api_key=$_apiKey"));
    if (response.statusCode == 200) {
      return VideoTrailers.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load trailers');
    }
  }
}
