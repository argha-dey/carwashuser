import 'package:famous_steam_user/const/colors.dart';
import 'package:famous_steam_user/const/prefKeys.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../IntroPage/enter_mobile_no_page.dart';
import '../localizations/app_localizations.dart';
import '../order_History.dart';
import '../setting.dart';
import 'all_direction_navigator.dart';

class Loader {
  void showLoader(BuildContext context) {
    showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Center(
            child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
            ),
            SizedBox(
              height: 100.h,
              width: 100.w,
              child: Lottie.asset(
                'images/102766-error.json',
              ),
            ),
          ],
        ));
      },
    );
  }

  void hideLoader(BuildContext context) {
    Navigator.pop(context);
  }
}

enum SingingCharacter { lafayette, jefferson }

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
    BuildContext context, String title) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: AppColor.lightButtonColor,
      content: Text(
        title,
        textAlign: TextAlign.center,
      ),
      duration: const Duration(seconds: 3),
    ),
  );
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showRedSnackBar(
    BuildContext context, String title) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: AppColor.redColor,
      content: Text(
        title,
        textAlign: TextAlign.center,
      ),
      duration: const Duration(seconds: 3),
    ),
  );
}

Widget yourLocation(BuildContext context, GlobalKey<ScaffoldState> key) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("",
             /*   Translation.of(context)!.translate('location')!,*/
                style: GoogleFonts.montserrat(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff7E7C7C)),
              ),
              const SizedBox(width: 5),
            /*  Icon(
                Icons.location_on,
                size: 15.sp,
                color: AppColor.appColor,
              ),*/
            ],
          ),
          const SizedBox(height: 5),
          location.isNotEmpty
              ? SizedBox(
                  width: MediaQuery.of(context).size.width - 50,
                  child: Text(
                    location,
                    maxLines: 2,
                    textAlign: TextAlign.end,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.montserrat(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff262626)),
                  ),
                )
              :  Container(),/*SizedBox(
                  height: 20,
                  width: 20,
                  child: *//*CircularProgressIndicator()*//*
                ),*/
        ],
      ),
      GestureDetector(
        onTap: () {
          key.currentState!.openEndDrawer();
        },
        child: Icon(
          Icons.more_vert_rounded,
          color: AppColor.appColor.withOpacity(0.9),
          size: 35.h,
        ),
      ),
    ],
  );
}

Widget drawer(BuildContext context) {
  return SizedBox(
    width: 130,
    child: Drawer(
      child: Column(
        children: [
          SizedBox(height: 40.h),
          GestureDetector(
            onTap: () {
              NavigatorAnimation(
                context,
                const SettingPage(),
              ).navigateFromRight();
            },
            child: drawercontainer(
              'images/profile-user 1.png',
              Translation.of(context)!.translate('account')!,
            ),
          ),
          SizedBox(height: 10.h),
          GestureDetector(
              onTap: () {
                NavigatorAnimation(
                  context,
                  const OderHistoryPage(),
                ).navigateFromRight();
              },
              child: drawercontainer(
                'images/shopping-list.png',
                Translation.of(context)!.translate('oders')!,
              )),
          SizedBox(height: 10.h),
 /*         drawercontainer(
            'images/notification 1.png',
            Translation.of(context)!.translate('notification')!,
          ),*/
          const Spacer(),
          GestureDetector(
              onTap: () {
                PrefObj.preferences!.clear();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const IntroPage1()),
                    (Route<dynamic> route) => false);
              },
              child: drawercontainer(
                'images/shutdown.png',
                Translation.of(context)!.translate('logout')!,
              )),
        ],
      ),
    ),
  );
}

Widget drawercontainer(String images, String title) {
  return Container(
    color: Colors.transparent,
    child: Column(
      children: [
        Image.asset(
          images,
          height: 30.w,
          width: 30.w,
        ),
        SizedBox(height: 10.w),
        Text(
          title,
          style: GoogleFonts.montserrat(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: AppColor.appColor,
          ),
        ),
        SizedBox(height: 20.w),
      ],
    ),
  );
}

List<Placemark>? placemarks;
String? latitudefatched;
String? longitudefatched;
String location = '';

Future getCurrentLocation() async {
  final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);


  latitudefatched = position.latitude.toString();
  longitudefatched = position.longitude.toString();

  placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);
  location = placemarks != null
      ? '${placemarks![0].street},${placemarks![0].subLocality},${placemarks![0].locality},${placemarks![0].administrativeArea},${placemarks![0].country}'
      : '';
}

Widget appbarWidget(BuildContext context, GlobalKey<ScaffoldState> key) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Padding(
          padding: const EdgeInsets.only(left: 2),
          child: Container(
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.whiteColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 3.0,
                  ),
                ]),
            child: const Icon(
              Icons.keyboard_arrow_left_sharp,
              color: AppColor.appColor,
              size: 35,
            ),
          ),
        ),
      ),
      const Spacer(),
      GestureDetector(
        onTap: () {
          key.currentState!.openEndDrawer();
        },
  /*      child: Icon(
          Icons.more_vert,
          color: AppColor.appColor,
          size: 35.h,
        ),*/
        child: Container(),
      ),
    ],
  );
}

enum ScreenType { edit, add }

loginButton(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IntroPage1(),
          ));
    },
    child: Container(
      height: 30.h,
      width: 100.w,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: AppColor.appColor,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Center(
        child: Text(
          'LOGIN',
          style: GoogleFonts.montserrat(
              textStyle: TextStyle(
            color: AppColor.whiteColor,
            fontSize: 11.sp,
          )),
        ),
      ),
    ),
  );

  

}
