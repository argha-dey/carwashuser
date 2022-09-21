import 'dart:async';

import 'package:famous_steam_user/IntroPage/intro_page_4.dart';
import 'package:famous_steam_user/ServicePage/notification_page.dart';
import 'package:famous_steam_user/ServicePage/service_list.dart';
import 'package:famous_steam_user/ServicePage/vehicle%20_Details_Page.dart';
import 'package:famous_steam_user/order_History.dart';
import 'package:famous_steam_user/setting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:famous_steam_user/const/colors.dart';
import 'package:famous_steam_user/homePage.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import '../IntroPage/enter_mobile_no_page.dart';
import '../const/all_direction_navigator.dart';
import '../const/prefKeys.dart';
import '../localizations/app_localizations.dart';

class BottomBarpage extends StatefulWidget {

   BottomBarpage({Key? key,required this.pageIndex}) : super(key: key);
   final int pageIndex;
  @override
  State<BottomBarpage> createState() => _BottomBarpageState();
}

class _BottomBarpageState extends State<BottomBarpage> {
  final userstr =
  PrefObj.preferences!.containsKey(PrefKeys.TOKEN) ? true : false;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  String location = '';
  int selectedIndex = 0;
  List widgetOptions = [
    const VehicalDetailsPage(),
    const HomePage(),
    const OderHistoryPage(),
  ];
  List<Placemark>? placemarks;
  String? latitudefatched;
  String? longitudefatched;
  Timer? timer;
  Future _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position);
    setState(() {
      latitudefatched = position.latitude.toString();
      longitudefatched = position.longitude.toString();
    });
    placemarks =
    await placemarkFromCoordinates(position.latitude, position.longitude);
    location = placemarks != null
        ? '${placemarks![0].street},${placemarks![0].subLocality},${placemarks![0].locality},${placemarks![0].administrativeArea},${placemarks![0].country}'
        : '';

    setState(() {});
  }

  @override
  void initState() {
    selectedIndex = widget.pageIndex;


 //   if (!PrefObj.preferences!.containsKey(PrefKeys.LANG)) {
//      PrefObj.preferences!.put(PrefKeys.LANG, 'eng');
 //   }



    /*

      timer = Timer.periodic(
        const Duration(seconds: 10), (Timer t) => _getCurrentLocation());*/
    _getCurrentLocation();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (() async => false),
      child: ScreenUtilInit(


          builder: (context , child) {
            return Scaffold(
                backgroundColor: AppColor.lightrgrey,
                key: _key,
                endDrawer: drawer(),
                bottomNavigationBar: Container(
                  clipBehavior: Clip.none,
                  alignment: Alignment.bottomCenter,
                  height: 120,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: ExactAssetImage('images/bottombar.png'),
                        fit: BoxFit.fill),
                  ),
                  child: BottomNavigationBar(
                    items: [
                      BottomNavigationBarItem(
                          icon: Image.asset('images/bottombarcar.png', height: 40),
                          label: ''),
                      BottomNavigationBarItem(
                        icon: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                color: AppColor.appColor,
                                boxShadow: [
                                  BoxShadow(
                                      color: AppColor.greyColor,
                                      blurRadius: 0.3,
                                      spreadRadius: 0.4)
                                ],
                                shape: BoxShape.circle),
                            child:
                            Image.asset('images/dashboard 1.png', height: 40)),
                        label: '',
                      ),
                      BottomNavigationBarItem(
                        icon: Image.asset('images/car-garage.png', height: 40),
                        label: '',
                      ),
                    ],
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    currentIndex: selectedIndex,
                    onTap: (value) {
                      setState(() {
                        selectedIndex = value;
                        print(selectedIndex);
                      });
                    },
                  ),
                ),

                body: Column(
                  children: [
                    const SizedBox(height: 40),
                    yourLocation(),
                    Expanded(child: widgetOptions[selectedIndex]),
                  ],
                ));
          }


      ),
    );
  }

  Widget yourLocation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [


        // Location searching off
        selectedIndex==1?Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              location.isNotEmpty
                  ?Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset('images/location_icon.png', height: 28),
                  Text(
                    Translation.of(context)!.translate('location')!,
                    style: GoogleFonts.montserrat(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff7E7C7C)),

                  ),
                  const SizedBox(width: 5),



                ],
              ):Container(),
              const SizedBox(height: 5),
              location.isNotEmpty
                  ? SizedBox(
                width: MediaQuery.of(context).size.width - 50,
                child: Text(
                  location,
                  maxLines: 2,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.montserrat(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff262626)),
                ),
              )
                  : const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(),
              ),
            ],
          ),
        ):SizedBox(
    width: MediaQuery.of(context).size.width - 50,),



        GestureDetector(
          onTap: () {
            setState(() {
              _key.currentState!.openEndDrawer();
            });
          },
          child: Icon(
            Icons.more_vert_rounded,
            color: AppColor.appColor.withOpacity(0.9),
            size: 32.h,
          ),
        ),
      ],
    );
  }

  Widget textfield2() {
    return selectedIndex == 1
        ? GestureDetector(
      onTap: () {
        NavigatorAnimation(
          context,
          const ServiceList(),
        ).navigateFromRight();
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3.w),
          color: AppColor.whiteColor,
          boxShadow: [
            BoxShadow(
              color: AppColor.greyColor1.withOpacity(0.5),
              blurRadius: 5.0,
            ),
          ],
        ),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 5.w),
            const Icon(
              Icons.search,
              color: AppColor.appColor,
            ),
            Expanded(
              child: Text(
                Translation.of(context)!.translate('search')!,
                style: GoogleFonts.montserrat(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColor.lightButtonColor,
                ),
              ),
            ),
            Image.asset(
              'images/up_down_arrow.png',
              height: 30.w,
            ),
            SizedBox(width: 10.w),
          ],
        ),
      ),
    )
        : Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3.w),
        color: AppColor.whiteColor,
        boxShadow: [
          BoxShadow(
            color: AppColor.greyColor1.withOpacity(0.5),
            blurRadius: 5.0,
          ),
        ],
      ),

      width: double.infinity,
      height: 50,
      child: Row(
        children: [
          Expanded(
            child:

            TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: AppColor.appColor,
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
              height: 30.w,
            ),
          ),
        ],
      ),
    );
  }

  Widget drawer() {
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
                /*    const OderHistoryPage(),*/  BottomBarpage(pageIndex: 2,)
                  ).navigateFromRight();
                },
                child: drawercontainer(
                  'images/shopping-list.png',
                  Translation.of(context)!.translate('Others')!,
                )),
            SizedBox(height: 10.h),
                       GestureDetector(
              onTap: () {
                NavigatorAnimation(
                  context,
                  const NotificationPage(),
                ).navigateFromRight();
              },
              child: drawercontainer(
                'images/notification 1.png',
                Translation.of(context)!.translate('notification')!,
              ),
            ),
            const Spacer(),
            userstr
                ? GestureDetector(
                onTap: () {
                  PrefObj.preferences!.clear();
                  // PrefObj.preferences!.put(PrefKeys.TOKEN, 'eng');
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const IntroPage4()),
                          (Route<dynamic> route) => false);
                },
                child: drawercontainer(
                  'images/shutdown.png',
                  Translation.of(context)!.translate('logout')!,
                ))
                : Container()
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
}
