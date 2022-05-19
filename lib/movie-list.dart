import 'package:flutter/material.dart';
import 'http_helper.dart';
import 'movie-detail.dart';

class MovieList extends StatefulWidget {
  const MovieList({Key? key}) : super(key: key);

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  final String icnBase = 'https://image.tmdb.org/t/p/w500/';
  final String defaultImage =
      'https://cdn.pixabay.com/photo/2017/11/24/10/43/ticket-2974645_960_720.jpg';
  late HttpHelper helper;
  late int moviesCount = -1;
  late List movies;
  Icon visibleIcon = const Icon(Icons.search);
  Widget searchBar = const Text('Movies');
  bool autoFocus = false;
  bool _isLoading = false;

  Future search(text) async {
    movies = await helper.findMovies(text);
    setState(() {
      moviesCount = movies.length;
    });
  }

  Future initialize() async {
    movies = [];
    setState(() {
      _isLoading = true;
    });
    await helper.getPopular().then((value) {
      setState(() {
        movies = value;
        moviesCount = movies.length;
        _isLoading = false;
        print(movies);
      });
    });
  }

  @override
  void initState() {
    helper = HttpHelper();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NetworkImage image;
    return Scaffold(
      appBar: AppBar(
        title: searchBar,
        actions: [
          IconButton(
            icon: visibleIcon,
            onPressed: () {
              setState(() {
                if (visibleIcon.icon == Icons.search) {
                  visibleIcon = const Icon(Icons.cancel);
                  setState(() {
                    autoFocus = true;
                  });
                  searchBar = TextField(
                    textInputAction: TextInputAction.search,
                    autofocus: autoFocus,
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                    onSubmitted: (String text) {
                      search(text);
                    },
                  );
                } else {
                  visibleIcon = const Icon(Icons.search);
                  searchBar = const Text('Movies');
                  movies = [];
                  initialize();
                }
              });
            },
          )
        ],
      ),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: moviesCount,
                itemBuilder: (BuildContext context, int position) {
                  if (movies[position].posterPath != null) {
                    image = NetworkImage(icnBase + movies[position].posterPath);
                  } else {
                    image = NetworkImage(defaultImage);
                  }
                  return Card(
                    color: Colors.white,
                    elevation: 2,
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => MovieDetail(movies[position])));
                      },
                      title: Text(movies[position].title),
                      subtitle: Text(
                          'Released: ${movies[position].releaseDate} -Vote: ${movies[position].voteAverage}'),
                      leading: Hero(
                        tag: movies[position].id,
                        child: CircleAvatar(
                          backgroundImage: image,
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
