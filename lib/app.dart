import 'package:flutter/material.dart';
import 'package:json_http_test/ui/movie_list1.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        body: MovieList1(),
      ),
    );
  }
}
