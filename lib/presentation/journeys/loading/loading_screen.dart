import 'package:custom_listview_with_json_data/presentation/blocs/loading/loading_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'loading_circle.dart';

class LoadingScreen extends StatelessWidget {
  final Widget screen;

  const LoadingScreen({Key? key, required this.screen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoadingBloc, LoadingState>(
      builder: (context, state) {
        return Stack(
          fit: StackFit.expand,
          children: [
            screen,
            if (state is LoadingStared)
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.7)),
                child: const Center(
                  child: LoadingCircle(),
                ),
              ),
          ],
        );
      },
    );
  }
}
