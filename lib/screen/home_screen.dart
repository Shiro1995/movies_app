import 'package:flutter/material.dart';
import 'package:movies_app/blocs/movie_bloc.dart';
import 'package:movies_app/models/movie_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    bloc.fetchAllMovies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies App'),
      ),
      resizeToAvoidBottomInset: false,
      body: StreamBuilder(
        stream: bloc.allMovies,
        builder: (context, AsyncSnapshot<MoviesModel> snapshot) {
          if (snapshot.hasData) {
            return buildList(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildList(AsyncSnapshot<MoviesModel> snapshot) {
    return GridView.builder(
        itemCount: snapshot.data?.results.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 4,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
        ),
        padding: EdgeInsets.all(8.0),
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: GridTile(
              child: GestureDetector(
                onTap: () {},
                child: Image.network(
                  'https://image.tmdb.org/t/p/w185${snapshot.data?.results[index].poster_path}',
                  fit: BoxFit.cover,
                ),
              ),
              footer: GridTileBar(
                backgroundColor: Colors.black87,
                title: Text('${snapshot.data?.results[index].title}'),
              ),
            ),
          );
        });
  }
}
