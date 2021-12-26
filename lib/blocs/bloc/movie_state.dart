part of 'movie_bloc.dart';

class MovieState extends Equatable {
  final List<Movie>? moviesModel;
  final List<Movie>? moviesFilter;
  final VideoTrailers? videoTrailers;
  const MovieState({this.moviesModel, this.videoTrailers, this.moviesFilter});
  MovieState copyWith(
          {List<Movie>? moviesModel, VideoTrailers? videoTrailers, List<Movie>? moviesFilter }) =>
      MovieState(
          moviesModel: moviesModel ?? this.moviesModel,
          videoTrailers: videoTrailers ?? this.videoTrailers,
          moviesFilter: moviesFilter ?? this.moviesFilter);
  @override
  // TODO: implement props
  List<Object?> get props => [moviesModel, videoTrailers, moviesFilter];
}
