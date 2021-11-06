import 'dart:async';

import 'package:custom_listview_with_json_data/ui/movie_app.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'di/get_it.dart' as getIt;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]));
  unawaited(getIt.init());
  runApp(const TheMovieDBApp());
}
