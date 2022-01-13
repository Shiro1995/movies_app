part of 'movie_bloc.dart';

enum LoadingStatus { initial, success, failure }

class MovieState extends Equatable {
  const MovieState({
    this.status = LoadingStatus.initial,
    this.moviesModel,
    this.videoTrailers,
    this.moviesFilter,
  });

  final LoadingStatus? status;
  final List<Movie>? moviesModel;
  final List<Movie>? moviesFilter;
  final VideoTrailers? videoTrailers;
  MovieState copyWith(
          {List<Movie>? moviesModel,
          VideoTrailers? videoTrailers,
          List<Movie>? moviesFilter}) =>
      MovieState(
          moviesModel: moviesModel ?? this.moviesModel,
          videoTrailers: videoTrailers ?? this.videoTrailers,
          moviesFilter: moviesFilter ?? this.moviesFilter);
  @override
  // TODO: implement props
  List<Object?> get props => [moviesModel, videoTrailers, moviesFilter];
}
