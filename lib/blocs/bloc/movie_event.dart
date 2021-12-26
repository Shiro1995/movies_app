part of 'movie_bloc.dart';

abstract class MovieEvent {}

class FetchAllMovie extends MovieEvent {}

class FetchDetailMovie extends MovieEvent {
  final int? id;
  FetchDetailMovie({this.id});
}

class FilterMovies extends MovieEvent {
  final int? minYear;
  final int? maxYear;
  FilterMovies({this.minYear, this.maxYear});
}

class ResetVideoTrailer extends MovieEvent {}
