import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_listview_with_json_data/common/constants/size_constants.dart';
import 'package:custom_listview_with_json_data/common/constants/translation_constants.dart';
import 'package:custom_listview_with_json_data/common/extensions/size_extensions.dart';
import 'package:custom_listview_with_json_data/common/extensions/string_extensions.dart';
import 'package:custom_listview_with_json_data/domain/entities/cast_entity.dart';
import 'package:custom_listview_with_json_data/presentation/themes/theme_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MovieCastWidget extends StatelessWidget {
  final List<CastEntity> castList;

  const MovieCastWidget({Key? key, required this.castList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_16.w),
          child: Text(
            TranslationConstants.cast.translate(context),
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
              vertical: Sizes.dimen_4.h, horizontal: Sizes.dimen_8.w),
          height: Sizes.dimen_100.h,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: castList.length,
            itemBuilder: (BuildContext context, int index) {
              final castEntity = castList[index];
              return SizedBox(
                height: Sizes.dimen_100.h,
                width: Sizes.dimen_160.w,
                child: Card(
                  margin: EdgeInsets.symmetric(
                    horizontal: Sizes.dimen_8.w,
                  ),
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Sizes.dimen_8.w),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: ClipRRect(
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(Sizes.dimen_8.w)),
                        child: CachedNetworkImage(
                          width: Sizes.dimen_160.w,
                          imageUrl: castEntity.loadCastImageProfile(),
                          fit: BoxFit.fitWidth,
                        ),
                      )),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Sizes.dimen_8.w),
                        child: Text(
                          castEntity.name,
                          style: Theme.of(context).textTheme.vulcanBodyText2,
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: Sizes.dimen_8.w,
                            right: Sizes.dimen_8.w,
                            bottom: Sizes.dimen_2.h),
                        child: Text(
                          castEntity.character,
                          style: Theme.of(context).textTheme.caption,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
