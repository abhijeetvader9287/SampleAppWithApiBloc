import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_http_test/blocs/MoviesBloc.dart';
import 'package:json_http_test/resources/repository.dart';

import '../blocs/movie_detail_bloc_provider.dart';
import '../models/item_model.dart';
import 'movie_detail.dart';

class MovieList1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MovieListState1();
  }
}

class MovieListState1 extends State<MovieList1> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: BlocProvider(
        builder: (context) => MoviesBloc1(Repository()),
        child: Column(
          children: <Widget>[SearchPage(), Expanded(child: MovieListPage())],
        ),
      ),
    );
  }
}

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final movies1Bloc = BlocProvider.of<MoviesBloc1>(context);
    return Container(
      height: 50,
      child: FlatButton(
        shape: new RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        onPressed: () {
          movies1Bloc.add(FetchMovie());
        },
        color: Colors.lightBlue,
        child: Text(
          "Search1",
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
      ),
    );
  }
}

class MovieListPage extends StatelessWidget {
  BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    final movies1Bloc = BlocProvider.of<MoviesBloc1>(context);

    return BlocBuilder<MoviesBloc1, MovieState>(
      builder: (context, state) {
        if (state is MovieIsNotSearched)
          return Center(
            child: Container(),
          );
        else if (state is MovieIsLoading)
          return Center(child: CircularProgressIndicator());
        else if (state is MovieIsLoaded)
          return buildList(state.getMovies);
        else
          return Text(
            "Error",
            style: TextStyle(color: Colors.white),
          );
      },
    );
  }

  openDetailPage(MoviesModel data, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return MovieDetailBlocProvider(
          child: MovieDetail(
            title: data.results[index].title,
            posterUrl: data.results[index].backdrop_path,
            description: data.results[index].overview,
            releaseDate: data.results[index].release_date,
            voteAverage: data.results[index].vote_average.toString(),
            movieId: data.results[index].id,
          ),
        );
      }),
    );
  }

  Widget buildList(MoviesModel moviesModel) {
    return GridView.builder(
        scrollDirection: Axis.vertical,
        itemCount: moviesModel.results.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return GridTile(
            child: InkResponse(
              enableFeedback: true,
              child: Image.network(
                'https://image.tmdb.org/t/p/w185${moviesModel.results[index].poster_path}',
                fit: BoxFit.cover,
              ),
              onTap: () => openDetailPage(moviesModel, index),
            ),
          );
        });
  }
}
