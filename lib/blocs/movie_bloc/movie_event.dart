part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();
}

class FetchAllMovie extends MovieEvent {
  const FetchAllMovie();

  @override
  List<Object?> get props => [];
}

class FetchDetailMovie extends MovieEvent {
  final int? id;
  const FetchDetailMovie({this.id});

  @override
  List<Object?> get props => [];
}

class FilterMovies extends MovieEvent {
  final int? minYear;
  final int? maxYear;
  const FilterMovies({this.minYear, this.maxYear});
  @override
  List<Object?> get props => [];
}

class ResetVideoTrailer extends MovieEvent {
  @override
  List<Object?> get props => [];
}
