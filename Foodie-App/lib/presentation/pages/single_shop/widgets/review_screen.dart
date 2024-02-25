import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rating_summary/rating_summary.dart';
import 'package:shoppingapp/infrastructure/models/data/shop_data.dart';
import 'package:shoppingapp/infrastructure/models/response/review_count.dart';
import 'package:shoppingapp/infrastructure/models/response/review_response.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import 'package:shoppingapp/infrastructure/services/tr_keys.dart';
import 'package:shoppingapp/presentation/components/title_icon.dart';

import '../../../theme/app_style.dart';
import 'review_item.dart';

class ReviewScreen extends StatelessWidget {
  final ShopData? shop;
  final ReviewCountModel? reviewCount;
  final List<ReviewModel> review;

  const ReviewScreen(
      {super.key,
      required this.shop,
      required this.review,
      required this.reviewCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.r, horizontal: 15.r),
      decoration: BoxDecoration(
          color: Style.white, borderRadius: BorderRadius.circular(10.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          4.verticalSpace,
          TitleAndIcon(
            title: AppHelpers.getTranslation(TrKeys.reviews),
            paddingHorizontalSize: 0,
          ),
          24.verticalSpace,
          review.isNotEmpty
              ? Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 6.r),
                          child: Text(
                            AppHelpers.getTranslation(TrKeys.overallRating),
                            style: Style.interNoSemi(
                              size: 14,
                              color: Style.black,
                            ),
                          ),
                        ),
                        8.verticalSpace,
                        RatingBar.builder(
                            initialRating:
                                double.tryParse(shop?.avgRate ?? "0") ?? 0,
                            minRating: 0,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 20.r,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
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
                        8.verticalSpace,
                        Padding(
                          padding: EdgeInsets.only(left: 6.r),
                          child: Text(
                            "${shop?.rateCount ?? "0"} ${AppHelpers.getTranslation(TrKeys.reviews).toLowerCase()}",
                            style: Style.interNormal(
                              size: 14,
                              color: Style.textGrey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    16.horizontalSpace,
                    Expanded(
                      child: RatingSummary(
                        counter: int.tryParse(shop?.rateCount ?? "0") ?? 0,
                        average: double.tryParse(shop?.avgRate ?? "0") ?? 0,
                        showAverage: false,
                        counterFiveStars: reviewCount?.group?["5"] ?? 0,
                        counterFourStars: reviewCount?.group?["4"] ?? 0,
                        counterThreeStars: reviewCount?.group?["3"] ?? 0,
                        counterTwoStars: reviewCount?.group?["2"] ?? 0,
                        counterOneStars: reviewCount?.group?["1"] ?? 0,
                        color: Style.brandGreen,
                        backgroundColor: Style.shimmerBase,
                      ),
                    )
                  ],
                )
              : Center(child: Text(AppHelpers.getTranslation(TrKeys.noReview),style: Style.interNoSemi(size: 16.r),)),
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: review.length,
              itemBuilder: (context, index) {
                return ReviewItem(review: review[index]);
              }),
        ],
      ),
    );
  }
}
