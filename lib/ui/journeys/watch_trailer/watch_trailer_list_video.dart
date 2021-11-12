import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_listview_with_json_data/common/constants/size_constants.dart';
import 'package:custom_listview_with_json_data/common/extensions/size_extensions.dart';
import 'package:custom_listview_with_json_data/domain/entities/video_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ListTrailer extends StatelessWidget {
  final List<VideoEntity> videoList;
  final YoutubePlayerController controller;

  const ListTrailer({Key? key, required this.videoList, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: Sizes.dimen_6.h, horizontal: Sizes.dimen_8.w),
      child: ListView.separated(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: videoList.length,
        separatorBuilder: (context, index) {
          return SizedBox(
            height: Sizes.dimen_4.h,
          );
        },
        itemBuilder: (context, index) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  controller.load(videoList[index].key);
                  controller.play();
                },
                child: CachedNetworkImage(
                  width: Sizes.dimen_160.w,
                  imageUrl: YoutubePlayer.getThumbnail(
                    videoId: videoList[index].key,
                    quality: ThumbnailQuality.high,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_8.w, vertical: Sizes.dimen_4.h),
                  child: Text(
                    videoList[index].title,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
