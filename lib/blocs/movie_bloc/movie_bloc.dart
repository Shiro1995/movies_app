import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/models/movie_model.dart';
import 'package:movies_app/models/video_trailer.dart';
import 'package:movies_app/services/movie_repository.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final _repository = MoviesRepository();

  MovieBloc() : super(MovieState()) {
    on<FetchAllMovie>(fetchAllMovies);
    on<FetchDetailMovie>(fetchDetailMovie);
    on<ResetVideoTrailer>(resetVideoTrailer);
    on<FilterMovies>(filterMovies);
  }
  Future<void> fetchAllMovies(
      FetchAllMovie event, Emitter<MovieState> emit) async {
    emit(const MovieState());
    List<Movie> moviesModel = await _repository.fetchAllMovies();
    return emit(
        state.copyWith(moviesModel: moviesModel, moviesFilter: moviesModel));
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

  filterMovies(FilterMovies event, Emitter<MovieState> emit) {
    var filterFilm = state.moviesFilter!
        .where((element) => (int.parse(element.release_date!.substring(0, 4)) <=
                event.maxYear! &&
            int.parse(element.release_date!.substring(0, 4)) >= event.minYear!))
        .toList();
    return emit(state.copyWith(moviesModel: filterFilm));
  }
}
