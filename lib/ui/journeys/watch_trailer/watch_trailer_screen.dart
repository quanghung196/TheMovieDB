import 'package:custom_listview_with_json_data/domain/entities/screen_agruments/movie_watch_trailer_screen_agrument.dart';
import 'package:custom_listview_with_json_data/domain/entities/video_entity.dart';
import 'package:custom_listview_with_json_data/ui/journeys/watch_trailer/watch_trailer_app_bar.dart';
import 'package:custom_listview_with_json_data/ui/journeys/watch_trailer/watch_trailer_list_video.dart';
import 'package:custom_listview_with_json_data/ui/themes/theme_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieWatchTrailerScreen extends StatefulWidget {
  final MovieWatchTrailerScreenAgrument agrument;

  const MovieWatchTrailerScreen({Key? key, required this.agrument})
      : super(key: key);

  @override
  _MovieWatchTrailerScreenState createState() =>
      _MovieWatchTrailerScreenState();
}

class _MovieWatchTrailerScreenState extends State<MovieWatchTrailerScreen> {
  late List<VideoEntity> _videoList;
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _videoList = widget.agrument.videoList;
    _controller = YoutubePlayerController(
        initialVideoId: _videoList[0].key,
        flags: const YoutubePlayerFlags(autoPlay: true, mute: false));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          color: AppColor.vulcan,
        ),
        child: YoutubePlayerBuilder(
          player: YoutubePlayer(
            controller: _controller,
            aspectRatio: 16 / 9,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.amber,
            progressColors: const ProgressBarColors(
              playedColor: Colors.amber,
              handleColor: Colors.amberAccent,
            ),
          ),
          builder: (context, player) {
            return Column(
              children: [
                const WatchTrailerAppBar(),
                player,
                Expanded(
                  child: ListTrailer(
                    videoList: _videoList,
                    controller: _controller,
                  ),
                )
              ],
            );
          },
        ));
  }
}
