import 'dart:async';

import 'package:movies_app/models/movie_model.dart';
import 'package:movies_app/servers/movie_api.dart';


class MoviesRepository {
  final moviesApiProvider = MovieApiProvider();

  Future<MoviesModel> fetchAllMovies() => moviesApiProvider.fetchMovieList();
}