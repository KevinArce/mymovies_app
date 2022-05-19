import 'package:flutter/material.dart';
import 'movie.dart';

class MovieDetail extends StatelessWidget {
  MovieDetail(this.movie);

  final Movie movie;
  final String imagePath = 'https://image.tmdb.org/t/p/w500/';

  @override
  Widget build(BuildContext context) {
    String path = imagePath + movie.posterPath;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: height * 0.99,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(movie.title),
              background: Hero(
                tag: movie.id,
                child: Image.network(
                  path,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            const SizedBox(
              height: 10,
            ),
            Text(
              'Release Date: ${movie.releaseDate}',
              style: const TextStyle(color: Colors.grey, fontSize: 20),
            ),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Overview:',
              style: TextStyle(color: Colors.grey, fontSize: 20),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              child: Text(
                movie.overview,
                softWrap: true,
              ),
            ),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Average vote/rate',
              style: TextStyle(color: Colors.grey, fontSize: 20),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              child: Text(
                '${movie.voteAverage}',
                softWrap: true,
              ),
            ),
            const Text(
              'Similar Movies',
              style: TextStyle(color: Colors.grey, fontSize: 20),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              child: const Text(
                'movie.similar',
                softWrap: true,
              ),
            ),
          ]))
        ],
      ),
    );
  }
}
