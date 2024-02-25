import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:shoppingapp/presentation/components/buttons/animation_button_effect.dart';

import '../../../theme/app_style.dart';

class MapsList extends StatefulWidget {
  final Coords location;
  final String title;

  const MapsList({super.key, required this.location, required this.title});

  @override
  State<MapsList> createState() => _MapsListState();
}

class _MapsListState extends State<MapsList> {
  List<AvailableMap> availableMaps = [];

  @override
  void initState() {
    installedMaps();
    super.initState();
  }

  installedMaps() async {
    availableMaps = await MapLauncher.installedMaps;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: availableMaps.length,
        itemBuilder: (context, index) {
          return AnimationButtonEffect(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8.w,vertical: 8.h),
              decoration: BoxDecoration(
                color: Style.white,
                borderRadius: BorderRadius.circular(16)
              ),
              child: ListTile(
                onTap: () => availableMaps[index].showMarker(
                  coords: widget.location,
                  title: widget.title,
                ),
                title: Text(availableMaps[index].mapName),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: SvgPicture.asset(
                    availableMaps[index].icon,
                    height: 30.0,
                    width: 30.0,
                  ),
                ),
              ),
            ),
          );
        });
  }
}
