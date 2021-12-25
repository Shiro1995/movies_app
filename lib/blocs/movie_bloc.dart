import 'package:flutter/foundation.dart';
import 'package:movies_app/models/movie_model.dart';
import 'package:movies_app/servers/movie_repository.dart';
import 'package:rxdart/rxdart.dart';

class MoviesBloc {
  final _repository = MoviesRepository();
  final _moviesFetcher = PublishSubject<MoviesModel>();

  Stream<MoviesModel> get allMovies => _moviesFetcher.stream;

  fetchAllMovies() async {
    MoviesModel moviesModel = await _repository.fetchAllMovies();
    _moviesFetcher.sink.add(moviesModel);
  }

  dispose() {
    _moviesFetcher.close();
  }
  
}

final bloc = MoviesBloc();