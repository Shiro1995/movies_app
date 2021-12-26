import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/models/movie_model.dart';
import 'package:movies_app/models/video_trailer.dart';
import 'package:movies_app/servers/movie_repository.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final _repository = MoviesRepository();

  MovieBloc() : super(MovieState()) {
    on<MovieEvent>((event, emit) async {
      if (event is FetchAllMovie) {
        await fetchAllMovies(event, emit);
      } else if (event is FetchDetailMovie) {
        await fetchDetailMovie(event, emit);
      } else if (event is ResetVideoTrailer) {
        resetVideoTrailer(event, emit);
      }
    });
  }
  Future<void> fetchAllMovies(
      FetchAllMovie event, Emitter<MovieState> emit) async {
    MoviesModel moviesModel = await _repository.fetchAllMovies();
    return emit(state.copyWith(moviesModel: moviesModel));
  }

  Future<void> fetchDetailMovie(
      FetchDetailMovie event, Emitter<MovieState> emit) async {
    VideoTrailers videoTrailers =
        await _repository.fetchVideoTrailers(event.id!);
    return emit(state.copyWith(videoTrailers: videoTrailers));
  }

  resetVideoTrailer(ResetVideoTrailer event, Emitter<MovieState> emit) {
    var video = VideoTrailers();
    video.id = 0;
    video.results = [];
    return emit(state.copyWith(videoTrailers: video));
  }
}
