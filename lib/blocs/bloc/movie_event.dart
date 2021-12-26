part of 'movie_bloc.dart';

abstract class MovieEvent {}

class FetchAllMovie extends MovieEvent {}

class FetchDetailMovie extends MovieEvent {
  final int? id;
  FetchDetailMovie({this.id});
}

class ResetVideoTrailer extends MovieEvent {}
