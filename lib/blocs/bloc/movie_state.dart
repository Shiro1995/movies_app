part of 'movie_bloc.dart';

class MovieState extends Equatable {
  final MoviesModel? moviesModel;
  final VideoTrailers? videoTrailers;
  const MovieState({this.moviesModel, this.videoTrailers});
  MovieState copyWith(
          {MoviesModel? moviesModel, VideoTrailers? videoTrailers}) =>
      MovieState(
          moviesModel: moviesModel ?? this.moviesModel,
          videoTrailers: videoTrailers ?? this.videoTrailers);
  @override
  // TODO: implement props
  List<Object?> get props => [moviesModel, videoTrailers];
}
