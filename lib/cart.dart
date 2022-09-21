import 'dart:async';

import 'package:famous_steam_user/Bottombar/bottombar.dart';
import 'package:famous_steam_user/ServicePage/service_list_booking_detail_page.dart';
import 'package:famous_steam_user/const/colors.dart';
import 'package:famous_steam_user/const/config.dart';
import 'package:famous_steam_user/const/global.dart';
import 'package:famous_steam_user/const/prefKeys.dart';
import 'package:famous_steam_user/localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'const/all_direction_navigator.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key, required this.getCartDatas}) : super(key: key);
  final List getCartDatas;
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  final userstr =
      PrefObj.preferences!.containsKey(PrefKeys.TOKEN) ? true : false;
  @override
  void initState() {
    super.initState();
    if (Config.isDebug) {print('page--> CartPage');}
/*    Timer.periodic(const Duration(seconds: 10), (Timer t) => getCurrentLocation());*/
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      endDrawer: drawer(context),
      appBar: PreferredSize(
          child: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: yourLocation(context, _key),
          ),
          preferredSize: const Size(double.infinity, 60)),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (notification) {
          notification.disallowGlow();
          return true;
        },
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(right: 15.w, left: 15.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  card(),
                  SizedBox(height: 20.w),
                  continueButton(),
                  Padding(
                    padding: EdgeInsets.only(top: 20.w),
                    child: browsemoreservicesButton(),
                  ),
                  SizedBox(height: 30.w)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget textfield2() {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(3.w),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5.0,
          ),
        ],
      ),
      width: double.infinity,
      height: 50,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: Color(0xff004471),
                ),
                hintText: "Car washing",
                border: InputBorder.none,
                fillColor: Colors.grey,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'images/up_down_arrow.png',
              height: 30,
            ),
          ),
        ],
      ),
    );
  }

  Widget card() {
    return Container(
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2.0,
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(3.w))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Total ${widget.getCartDatas.length} items",
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColor.appColor,
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.getCartDatas.length,
            itemBuilder: (context, index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(
                      height: 20.w,
                      thickness: 0.5,
                      endIndent: 7,
                      color: AppColor.appColor,
                    ),
                    SizedBox(height: 5.w),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${widget.getCartDatas[index]['serviceName']}',
                          style: GoogleFonts.montserrat(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColor.appColor,
                          ),
                        ),
                        Text(
                          "SAR  ${widget.getCartDatas[index]['cost']}",
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColor.appColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.w),
                    Text(
                      'Service Name: ${widget.getCartDatas[index]['serviceName']}',
                      style: GoogleFonts.montserrat(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: AppColor.greyColor2,
                      ),
                    ),
                    SizedBox(height: 10.w),
                    Text(
                      'Service Type: ${widget.getCartDatas[index]['serviceType']}',
                      style: GoogleFonts.montserrat(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: AppColor.greyColor2,
                      ),
                    ),
                    SizedBox(height: 10.w),
                    Text(
                      'Car Size: ${widget.getCartDatas[index]['carsize']}',
                      style: GoogleFonts.montserrat(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: AppColor.greyColor2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget continueButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
    /*        Map summary = {
              'serviceName': widget.getCartDatas[0]['serviceName'],
              'serviceType': widget.getCartDatas[0]['serviceType'],
              'cost': widget.getCartDatas[0]['cost'],
            };
            NavigatorAnimation(
              context,
              ServiceListBookingDetailPage(
                  packageId: widget.getCartDatas[0]['id'].toString(),
                  summary: summary),
            ).navigateFromRight();*/
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColor.appColor,
              borderRadius: BorderRadius.circular(3),
            ),
            child: Center(
              child: Text(
                Translation.of(context)!.translate('continue')!,
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    color: AppColor.whiteColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget browsemoreservicesButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            NavigatorAnimation(context, BottomBarpage(pageIndex: 1,))
                .navigateFromRight();
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColor.appColor,
              borderRadius: BorderRadius.circular(3),
            ),
            child: Center(
              child: Text(
                Translation.of(context)!.translate('browsemoreservices')!,
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    color: AppColor.whiteColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
