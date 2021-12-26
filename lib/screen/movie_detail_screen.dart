import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:movies_app/blocs/bloc/movie_bloc.dart';
import 'package:movies_app/models/video_trailer.dart';

class MovieDetail extends StatefulWidget {
  final posterUrl;
  final description;
  final releaseDate;
  final String? title;
  final String? voteAverage;
  final int? movieId;

  const MovieDetail({
    this.title,
    this.posterUrl,
    this.description,
    this.releaseDate,
    this.voteAverage,
    this.movieId,
  });

  @override
  State<StatefulWidget> createState() {
    return MovieDetailState();
  }
}

class MovieDetailState extends State<MovieDetail> {
  final posterUrl;
  final description;
  final releaseDate;
  final String? title;
  final String? voteAverage;
  final int? movieId;

  MovieDetailState({
    this.title,
    this.posterUrl,
    this.description,
    this.releaseDate,
    this.voteAverage,
    this.movieId,
  });

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    context.read<MovieBloc>().add(FetchDetailMovie(id: widget.movieId));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        top: false,
        bottom: false,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                elevation: 0.0,
                flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                  "https://image.tmdb.org/t/p/w500${widget.posterUrl}",
                  fit: BoxFit.cover,
                )),
              ),
            ];
          },
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(
              children: <Widget>[
                Container(margin: EdgeInsets.only(top: 5.0)),
                Text(
                  widget.title ?? "",
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(margin: EdgeInsets.only(top: 8.0, bottom: 8.0)),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 1.0, right: 1.0),
                    ),
                    Text(
                      widget.voteAverage ?? "",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10.0, right: 10.0),
                    ),
                    Text(
                      widget.releaseDate ?? "",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
                Container(margin: EdgeInsets.only(top: 8.0, bottom: 8.0)),
                Text(widget.description ?? ""),
                Container(margin: EdgeInsets.only(top: 8.0, bottom: 8.0)),
                Text(
                  "Trailer",
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(margin: EdgeInsets.only(top: 8.0, bottom: 8.0)),
                BlocBuilder<MovieBloc, MovieState>(
                  builder: (context, state) {
                    if (state.videoTrailers != null) {
                      if (state.videoTrailers!.results.isNotEmpty) {
                        return trailerLayout(state.videoTrailers!);
                      } else {
                        return noTrailer(state.videoTrailers!);
                      }
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget noTrailer(VideoTrailers data) {
    return Center(
      child: Text("No trailer available"),
    );
  }

  Widget trailerLayout(VideoTrailers data) {
    if (data.results.length > 1) {
      return Column(
        children: <Widget>[
          YoutubePlayer(
              controller: YoutubePlayerController(
                  initialVideoId: data.results[0].key!,
                  flags: YoutubePlayerFlags(
                    autoPlay: false,
                    mute: true,
                  ))),
          Container(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                data.results[1].name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          YoutubePlayer(
              controller: YoutubePlayerController(
                  initialVideoId: data.results[1].key!,
                  flags: YoutubePlayerFlags(
                    autoPlay: false,
                    mute: true,
                  ))),
          Container(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                data.results[1].name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          YoutubePlayer(
              controller: YoutubePlayerController(
                  initialVideoId: data.results[0].key!,
                  flags: YoutubePlayerFlags(
                    autoPlay: false,
                    mute: true,
                  ))),
          Center(
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Text(
                data.results[0].name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      );
    }
  }
}
