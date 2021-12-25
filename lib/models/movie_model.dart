class MoviesModel {
 late int page;
 late int total_results;
 late int total_pages;
 List<Movie> results = [];

  MoviesModel.fromJson(Map<String, dynamic> parsedJson) {
    page = parsedJson['page'];
    total_results = parsedJson['total_results'];
    total_pages = parsedJson['total_pages'];
    List<Movie> temp = [];
    for (int i = 0; i < parsedJson['results'].length; i++) {
      Movie movies = Movie(parsedJson['results'][i]);
      temp.add(movies);
    }
    
   results = temp;
  }
// get set 

}

class Movie {
 late int vote_count;
 late int id;
 late bool video;
  var vote_average;
 late String title;
 late double popularity;
 late String poster_path;
 late String original_language;
 late String original_title;
  List<int> genre_ids = [];
 late String backdrop_path;
 late bool adult;
 late String overview;
 late String release_date;

  Movie(movies) {
    vote_count = movies['vote_count'];
    id = movies['id'];
    video = movies['video'];
    vote_average = movies['vote_average'];
    title = movies['title'];
    popularity = movies['popularity'];
    poster_path = movies['poster_path'];
    original_language = movies['original_language'];
    original_title = movies['original_title'];
    for (int i = 0; i < movies['genre_ids'].length; i++) {
      genre_ids.add(movies['genre_ids'][i]);
    }
    backdrop_path = movies['backdrop_path'];
    adult = movies['adult'];
    overview = movies['overview'];
    release_date = movies['release_date'];
  }
  
// get set 

}