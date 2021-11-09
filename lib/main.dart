import 'dart:async';

import 'package:custom_listview_with_json_data/ui/movie_app.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'di/get_it.dart' as getIt;

late SharedPreferences globalSharedPrefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]));
  unawaited(getIt.init());
  globalSharedPrefs = await SharedPreferences.getInstance();
  runApp(const TheMovieDBApp());
}
