# About Movies App

This is a simple repository, that helps fetch top-rated movies. Using MultiBlocProvider to manage state and equatable package to simplify coding style.

## How To Use?

After cloning this project, fill your **API Key** into code like bellow at `/MovieApiProvider`. 
The IMDB **API Key** could be obtained from this [link](https://www.themoviedb.org/account/signup)

```
  final _apiKey = "YOUR_API_KEY";
```

## What's in this app.

- [x] List of top rated movies.
- [x] Show movie detail information.
- [x] Play video youtube trailer. 
- [x] Filter movies based on min year and max year.

## Current dependencies added at *pubspec.yaml*:
```
dependencies:
  flutter:
    sdk: flutter

  cupertino_icons: ^1.0.2
  http: ^0.13.4
  flutter_bloc: ^8.0.0
  equatable: ^2.0.3
  youtube_player_flutter: ^8.0.0

```

## ScreenShot
![alt](https://i.ibb.co/pdKNhrz/1.jpg)
![alt](https://i.ibb.co/VDb2rSk/2.jpg)
![alt](https://i.ibb.co/dM4dnR4/3.jpg)
      
## Thank you!







