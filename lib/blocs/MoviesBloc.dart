import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:json_http_test/models/item_model.dart';
import 'package:json_http_test/resources/repository.dart';

class MovieEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FetchMovie extends MovieEvent {
  FetchMovie();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ResetMovie extends MovieEvent {}

class MovieState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class MovieIsNotSearched extends MovieState {}

class MovieIsLoading extends MovieState {}

class MovieIsLoaded extends MovieState {
  final _movies;

  MovieIsLoaded(this._movies);

  MoviesModel get getMovies => _movies;

  @override
  // TODO: implement props
  List<Object> get props => [_movies];
}

class MovieIsNotLoaded extends MovieState {}

class MoviesBloc1 extends Bloc<MovieEvent, MovieState> {
  Repository _repository = Repository();

  MoviesBloc1(this._repository);

  @override
  // TODO: implement initialState
  MovieState get initialState => MovieIsNotSearched();

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    // TODO: implement mapEventToState
    if (event is FetchMovie) {
      yield MovieIsLoading();

      try {
        MoviesModel moviesModel = await _repository.fetchAllMovies();
        yield MovieIsLoaded(moviesModel);
      } catch (_) {
        print(_);
        yield MovieIsNotLoaded();
      }
    } else if (event is ResetMovie) {
      yield MovieIsNotSearched();
    }
  }
}
