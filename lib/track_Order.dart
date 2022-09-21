import 'dart:async';


import 'package:famous_steam_user/const/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Bottombar/bottombar.dart';
import 'const/all_direction_navigator.dart';
import 'const/colors.dart';
import 'const/global.dart';
import 'localizations/app_localizations.dart';


class TrackOderPage extends StatefulWidget {
  const TrackOderPage({Key? key}) : super(key: key);

  @override
  State<TrackOderPage> createState() => _TrackOderPageState();
}

class _TrackOderPageState extends State<TrackOderPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    if (Config.isDebug) {print('page--> TrackOderPage');}
    Timer.periodic(
        const Duration(seconds: 10), (Timer t) => getCurrentLocation());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (() async {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) =>  BottomBarpage(pageIndex: 2)),
            (Route<dynamic> route) => false);
        return true;
      }),
      child: Scaffold(
        backgroundColor: AppColor.lightrgrey,
        key: _key,
        endDrawer: drawer(context),
        appBar: PreferredSize(
            child: Padding(

              padding: const EdgeInsets.only(right: 18, left: 18, top: 40),
              child: /*appbarWidget(context, _key),*/ Container()
            ),
            preferredSize: const Size(double.infinity, 60)),
        body: Padding(
          padding: const EdgeInsets.only(left: 18, right: 18),
          child: SingleChildScrollView(
            child: Column(
              children: [
                topImage(),
                SizedBox(height: 20.w),
                onlyText(),
                SizedBox(height: 30.w),
                trackOrderButton(),
                SizedBox(height: 20.w),
                gotoHomePageButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget topImage() {
    return Center(
      child: Image.asset(
        'images/srvice_list_booking_summary.png',
        height: 300,
      ),
    );
  }

  Widget onlyText() {
    return Column(
      children: [
        Center(
          child: Text(
            Translation.of(context)!.translate('Your Service Booking Placed').toString(),
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                color: const Color(0xff004471),
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
              ),
            ),
          ),
        ),
        Center(
          child: Text(
            Translation.of(context)!.translate('Successfully').toString(),
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                color: const Color(0xff004471),
                fontWeight: FontWeight.w500,
                fontSize: 20.sp,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget trackOrderButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            NavigatorAnimation(
              context,
              BottomBarpage(pageIndex:2),   /*OderHistoryPage(),*/
            ).navigateFromRight();
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColor.appColor,
              borderRadius: BorderRadius.circular(3),
            ),
            child: Center(
              child: Text(
               Translation.of(context)!.translate('Track Order').toString(),
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

  Widget gotoHomePageButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            NavigatorAnimation(
              context,
              BottomBarpage(pageIndex: 1,),
            ).navigateFromRight();
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xff004471)),
              color: const Color(0xffFFFFFF),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 2.0,
                ),
              ],
              borderRadius: BorderRadius.circular(3),
            ),
            child: Center(
              child: Text(
                  Translation.of(context)!.translate('Go to home page').toString(),
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    color: const Color(0xff004471),
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
