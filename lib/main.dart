import 'dart:async';

import 'package:custom_listview_with_json_data/presentation/movie_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:shared_preferences/shared_preferences.dart';

import 'di/get_it.dart' as getIt;
import 'domain/entities/movie_entity.dart';

late SharedPreferences globalSharedPrefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]));
  unawaited(getIt.init());
  globalSharedPrefs = await SharedPreferences.getInstance();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(MovieEntityAdapter());
  runApp(const TheMovieDBApp());
}
