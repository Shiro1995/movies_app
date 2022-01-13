import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/blocs/movie_bloc/movie_bloc.dart';


import 'package:movies_app/models/movie_model.dart';
import 'package:movies_app/screen/movie_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controlerMinYear = TextEditingController();
  final TextEditingController _controlerMaxYear = TextEditingController();
  String minYear = '';
  String maxYear = '';

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
        key: scaffoldKey,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Center(
            child: Text('Movies App'),
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.filter_alt_outlined,
                  color: Colors.white,
                ),
                onPressed: () {
                  scaffoldKey.currentState?.openEndDrawer();
                }),
          ],
        ),
        endDrawer: buildDrawer(),
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

  Widget buildDrawer() {
    return Drawer(
        elevation: 4.0,
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 80, 20, 0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _controlerMinYear,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter min year',
                    labelStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  validator: (value) {
                    if (value == '') {
                      return 'Please enter min year';
                    }
                    if (int.parse(value!) > 2021) {
                      return 'Please enter min year < 2021';
                    }
                  },
                  onSaved: (value) {
                    if (value != null) {
                      minYear = value;
                    }
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _controlerMaxYear,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter Max Year',
                    labelStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  validator: (value) {
                    if (value == '') {
                      return 'Please enter max year';
                    }
                    if (int.parse(value!) < 1000) {
                      return 'Please enter max year > 1000';
                    }
                    if (int.parse(value) > 2021) {
                      return 'please enter max year less than current year';
                    }
                  },
                  onSaved: (value) {
                    if (value != null) {
                      maxYear = value;
                    }
                  },
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        child: Text('Filter'),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            context.read<MovieBloc>().add(FilterMovies(
                                minYear: int.parse(minYear.substring(0, 4)),
                                maxYear: int.parse(maxYear.substring(0, 4))));
                            Navigator.pop(context);
                          }
                        },
                      ),
                      SizedBox(width: 20),
                      ElevatedButton(
                        child: Text('Clear'),
                        onPressed: () {
                          _formKey.currentState!.reset();
                          _controlerMinYear.text = '';
                          _controlerMaxYear.text = '';
                          context
                              .read<MovieBloc>()
                              .add(FilterMovies(minYear: 0, maxYear: 2022));
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget buildList(List<Movie> snapshot) {
    return GridView.builder(
        itemCount: snapshot.length,
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
                  openDetailPage(snapshot[index], index);
                },
                child: Image.network(
                  'https://image.tmdb.org/t/p/w185${snapshot[index].poster_path}',
                  fit: BoxFit.cover,
                ),
              ),
              footer: GridTileBar(
                backgroundColor: Colors.black87,
                title: Center(
                  child: Text(('${snapshot[index].title}')),
                ),
              ),
              header: Container(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  '${snapshot[index].release_date}'.substring(0, 4),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        });
  }

  openDetailPage(Movie data, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return MovieDetail(
          title: data.title,
          posterUrl: data.backdrop_path,
          description: data.overview,
          releaseDate: data.release_date,
          voteAverage: data.vote_average.toString(),
          movieId: data.id,
        );
      }),
    );
  }
}
