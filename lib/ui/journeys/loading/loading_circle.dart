import 'package:custom_listview_with_json_data/ui/themes/theme_color.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class LoadingCircle extends StatelessWidget {
  const LoadingCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const FlareActor(
      'assets/animations/loading_circle.flr',
      animation: 'load',
      snapToEnd: true,
    );
  }
}
