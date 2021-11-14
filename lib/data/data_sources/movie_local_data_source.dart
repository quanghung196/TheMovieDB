import 'package:custom_listview_with_json_data/domain/entities/movie_entity.dart';
import 'package:hive/hive.dart';

abstract class MovieLocalDataSource {
  Future<List<MovieEntity>> getFavouriteMovieFromDB();

  Future<void> saveMovieToFavouriteList(MovieEntity movieEntity);

  Future<void> deleteMovieFromFavouriteList(int movieID);

  Future<bool> checkIfMovieInFavouriteList(int movieID);
}

class MovieLocalDataSourceImpl extends MovieLocalDataSource {
  static const String MOVIE_BOX = 'movieBox';

  @override
  Future<bool> checkIfMovieInFavouriteList(int movieID) async {
    final movieBox = await Hive.openBox(MOVIE_BOX);
    return movieBox.containsKey(movieID);
  }

  @override
  Future<void> deleteMovieFromFavouriteList(int movieID) async {
    final movieBox = await Hive.openBox(MOVIE_BOX);
    await movieBox.delete(movieID);
  }

  @override
  Future<List<MovieEntity>> getFavouriteMovieFromDB() async {
    final movieBox = await Hive.openBox(MOVIE_BOX);
    final movieID = movieBox.keys;
    List<MovieEntity> movieList = [];
    for (var id in movieID) {
      movieList.add(movieBox.get(id));
    }
    return movieList;
  }

  @override
  Future<void> saveMovieToFavouriteList(MovieEntity movieEntity) async {
    final movieBox = await Hive.openBox(MOVIE_BOX);
    await movieBox.put(movieEntity.id, movieEntity);
  }
}
