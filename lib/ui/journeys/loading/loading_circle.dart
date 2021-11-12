import 'package:custom_listview_with_json_data/ui/themes/theme_color.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class LoadingCircle extends StatelessWidget {
  final double size;

  const LoadingCircle({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: const FlareActor(
        'assets/animations/loading_circle.flr',
        animation: 'load',
        snapToEnd: true,
      ),
    );
  }
}
