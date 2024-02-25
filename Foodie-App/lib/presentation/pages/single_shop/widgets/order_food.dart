import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppingapp/infrastructure/models/data/shop_data.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import 'package:shoppingapp/infrastructure/services/local_storage.dart';
import 'package:shoppingapp/infrastructure/services/tr_keys.dart';
import 'package:shoppingapp/presentation/components/buttons/custom_button.dart';
import 'package:shoppingapp/presentation/components/custom_tab_bar.dart';
import 'package:shoppingapp/presentation/components/title_icon.dart';
import 'package:intl/intl.dart' as intl;
import '../../../theme/app_style.dart';

class OrderFoodScreen extends StatefulWidget {
  final ShopData? shop;
  final VoidCallback startOrder;

  const OrderFoodScreen({
    super.key,
    this.shop,
    required this.startOrder,
  });

  @override
  State<OrderFoodScreen> createState() => _OrderFoodScreenState();
}

class _OrderFoodScreenState extends State<OrderFoodScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _tabs = [
    Tab(text: AppHelpers.getTranslation(TrKeys.delivery)),
    Tab(text: AppHelpers.getTranslation(TrKeys.pickup)),
  ];

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
            title: AppHelpers.getTranslation(TrKeys.orderFood),
            titleSize: 16,
          ),
          16.verticalSpace,
          CustomTabBar(tabController: _tabController, tabs: _tabs),
          18.verticalSpace,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${intl.NumberFormat.currency(
                  symbol: LocalStorage.instance.getSelectedCurrency().symbol,
                ).format(widget.shop?.deliveryRange ?? 0)}+ ",
                style: Style.interNoSemi(size: 14),
              ),
              Text(
                AppHelpers.getTranslation(TrKeys.deliveryFee),
                style: Style.interNormal(color: Style.textGrey,size: 14),
              ),
              14.horizontalSpace,
              Container(
                height: 10.r,
                width: 10.r,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Style.textGrey),
              ),
              14.horizontalSpace,
              Text(
                "${widget.shop?.deliveryTime?.to} - ${widget.shop?.deliveryTime?.from} ",
                style: Style.interNoSemi(size: 14),
              ),
              Text(
                "${widget.shop?.deliveryTime?.type}",
                style: Style.interNormal(color: Style.textGrey,size: 14),
              ),
            ],
          ),
          18.verticalSpace,
          CustomButton(
              title: AppHelpers.getTranslation(TrKeys.startOrder),
              onPressed:()=> widget.startOrder())
        ],
      ),
    );
  }
}
