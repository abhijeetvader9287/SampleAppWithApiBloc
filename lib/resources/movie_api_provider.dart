import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' show Client;

import '../models/item_model.dart';
import '../models/trailer_model.dart';

class MovieApiProvider {
  Client client = Client();
  final _apiKey = 'fa82062c1eb93eacd0ae68e4fa3e1550';
  final _baseUrl = "http://api.themoviedb.org/3/movie";

  Future<MoviesModel> fetchMovieList() async {
    final response = await client.get("$_baseUrl/popular?api_key=$_apiKey");
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return MoviesModel.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<TrailerModel> fetchTrailer(int movieId) async {
    final response =
        await client.get("$_baseUrl/$movieId/videos?api_key=$_apiKey");

    if (response.statusCode == 200) {
      return TrailerModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load trailers');
    }
  }
}
