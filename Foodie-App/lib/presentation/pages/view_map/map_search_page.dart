import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_place/google_place.dart';
import 'package:shoppingapp/domain/di/dependency_manager.dart';

import '../../components/text_fields/search_text_field.dart';
import '../../theme/app_style.dart';

@RoutePage()
class MapSearchPage extends StatefulWidget {
  const MapSearchPage({super.key});

  @override
  State<MapSearchPage> createState() => _MapSearchPageState();
}

class _MapSearchPageState extends State<MapSearchPage> {
  List<AutocompletePrediction> searchResult = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              16.verticalSpace,
              SearchTextField(
                autofocus: true,
                isBorder: true,
                onChanged: (title) async {
                  final res = await googlePlace.autocomplete.get(title);
                  searchResult = res?.predictions ?? [];
                  setState(() {});
                },
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: searchResult.length,
                    padding: EdgeInsets.only(bottom: 22.h),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: ()  {
                          context.popRoute(searchResult[index].placeId);

                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            22.verticalSpace,
                            Text(
                              searchResult[index]
                                  .structuredFormatting
                                  ?.mainText ??
                                  "",
                              style: Style.interNormal(size: 14),
                            ),
                            Text(
                              searchResult[index]
                                  .structuredFormatting
                                  ?.secondaryText ??
                                  "",
                              style: Style.interNormal(size: 14),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Divider(
                              color: Style.borderColor,
                            ),
                          ],
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}