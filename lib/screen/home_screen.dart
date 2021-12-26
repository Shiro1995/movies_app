import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/blocs/bloc/movie_bloc.dart';
import 'package:movies_app/models/movie_model.dart';
import 'package:movies_app/screen/movie_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MovieBloc>().add(FetchAllMovie());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('Movies App'),
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: BlocBuilder<MovieBloc, MovieState>(
          builder: (context, state) {
            if (state.moviesModel != null) {
              return buildList(state.moviesModel!);
            } else if (state.moviesModel == null) {
              return Center(child: CircularProgressIndicator());
            }
            return Center(child: CircularProgressIndicator());
          },
        ));
  }

  Widget buildList(MoviesModel snapshot) {
    return GridView.builder(
        itemCount: snapshot.results.length,
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
                onTap: () {
                  context.read<MovieBloc>().add(ResetVideoTrailer());
                  openDetailPage(snapshot, index);
                },
                child: Image.network(
                  'https://image.tmdb.org/t/p/w185${snapshot.results[index].poster_path}',
                  fit: BoxFit.cover,
                ),
              ),
              footer: GridTileBar(
                backgroundColor: Colors.black87,
                title: Center(
                  child: Text(('${snapshot.results[index].title}')),
                ),
              ),
              header: Container(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  '${snapshot.results[index].release_date}'.substring(0, 4),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        });
  }

  openDetailPage(MoviesModel data, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return MovieDetail(
          title: data.results[index].title,
          posterUrl: data.results[index].backdrop_path,
          description: data.results[index].overview,
          releaseDate: data.results[index].release_date,
          voteAverage: data.results[index].vote_average.toString(),
          movieId: data.results[index].id,
        );
      }),
    );
  }
}
