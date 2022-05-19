import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'movie.dart';

class HttpHelper {
  final String urlKey = 'api_key=4d52d8a081f873efe0cce2f7dbfad5fd';
  final String urlBase = 'https://api.themoviedb.org/3/movie';
  final String urlSearch =
      'https://api.themoviedb.org/3/search/movie?api_key=4d52d8a081f873efe0cce2f7dbfad5fd&query=';
  final String urlPopular = '/popular?';
  final String urlLanguage = '&language=en-US';
  final String urlSimilar = '/similar?';

  Future<List> getPopular() async {
    final String popular = urlBase + urlPopular + urlKey + urlLanguage;

    http.Response result = await http.get(Uri.parse(popular));

    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      final moviesMap = jsonResponse['results'];
      List movies = moviesMap.map((i) => Movie.fromJson(i)).toList();
      return movies;
    } else {
      return [];
    }
  }

  Future<List> findMovies(String title) async {
    final String query = urlSearch + title;

    http.Response result = await http.get(Uri.parse(query));

    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      final moviesMap = jsonResponse['results'];
      List movies = moviesMap.map((i) => Movie.fromJson(i)).toList();
      return movies;
    } else {
      return [];
    }
  }

  Future<List> getSugestions(String movieId) async {
    final String similar =
        urlBase + movieId + urlSimilar + urlKey + urlLanguage;

    http.Response result = await http.get(Uri.parse(similar));

    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      final moviesMap = jsonResponse['results'];
      List movies = moviesMap.map((i) => Movie.fromJson(i)).toList();
      return movies;
    } else {
      return [];
    }
  }
}
