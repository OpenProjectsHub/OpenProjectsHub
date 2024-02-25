import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiffy/jiffy.dart';
import 'package:readmore/readmore.dart';
import 'package:shoppingapp/infrastructure/models/response/review_response.dart';
import 'package:shoppingapp/presentation/components/custom_network_image.dart';

import '../../../theme/app_style.dart';

class ReviewItem extends StatelessWidget {
  final ReviewModel review;

  const ReviewItem({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        Row(
          children: [
            CustomNetworkImage(
              url: review.user?.img ?? "",
              height: 36,
              width: 36,
              radius: 18,
            ),
            8.horizontalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${review.user?.firstname ?? ""} ${review.user?.lastname ?? ""}",
                  style: Style.interNormal(size: 14),
                ),
                SizedBox(
                  width: 200.w,
                  child: Text(
                    review.order?.address?.address ?? "",
                    style: Style.interNormal(color: Style.textGrey, size: 12),
                    maxLines: 1,
                  ),
                ),
              ],
            )
          ],
        ),
        8.verticalSpace,
        Row(
          children: [
            RatingBar.builder(
                initialRating: (review.rating ?? 0).toDouble(),
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 16.r,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Container(
                      decoration: BoxDecoration(
                          color: Style.brandGreen,
                          borderRadius: BorderRadius.circular(4.r)),
                      child: Padding(
                        padding: EdgeInsets.all(4.r),
                        child: const Icon(
                          FlutterRemix.star_fill,
                          color: Style.white,
                        ),
                      ),
                    ),
                onRatingUpdate: (rating) {},
                ignoreGestures: true),
            6.horizontalSpace,
            Text(
              Jiffy.parseFromDateTime(review.createdAt ?? DateTime.now()).fromNow(),
              style: Style.interNormal(size: 10.sp, color: Style.textGrey),
            )
          ],
        ),
        8.verticalSpace,
        ReadMoreText(
         "${review.comment ?? ""} ",
          trimLines: 2,
          colorClickableText: Style.textGrey,
          trimMode: TrimMode.Line,
          trimCollapsedText: 'Show more',
          trimExpandedText: 'Show less',
          style: Style.interNormal(size: 14),
          moreStyle: Style.interNormal(color: Style.textGrey,size: 12),
          lessStyle: Style.interNormal(color: Style.textGrey,size: 12),
        ),
        8.verticalSpace,
      ],
    );
  }
}
