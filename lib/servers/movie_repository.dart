import 'dart:async';

import 'package:movies_app/models/movie_model.dart';
import 'package:movies_app/models/video_trailer.dart';
import 'package:movies_app/servers/movie_api.dart';

class MoviesRepository {
  final moviesApiProvider = MovieApiProvider();

  Future<List<Movie>> fetchAllMovies() => moviesApiProvider.fetchMovieList();

  Future<VideoTrailers> fetchVideoTrailers(int movieId) =>
      moviesApiProvider.fetchVideoTrailers(movieId);
}
