import 'package:rxdart/rxdart.dart';

import '../models/item_model.dart';
import '../resources/repository.dart';

class MoviesBloc {
  final _repository = Repository();
  final _moviesFetcher = PublishSubject<MoviesModel>();

  Observable<MoviesModel> get allMovies => _moviesFetcher.stream;

  fetchAllMovies() async {
    MoviesModel itemModel = await _repository.fetchAllMovies();
    _moviesFetcher.sink.add(itemModel);
  }

  dispose() {
    _moviesFetcher.close();
  }
}

final bloc = MoviesBloc();
