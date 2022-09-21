import 'dart:async';
import 'package:famous_steam_user/ServicePage/select_your_address_page.dart';
import 'package:famous_steam_user/bloc/get_timeslot_bloc.dart';
import 'package:famous_steam_user/const/AppText.dart';
import 'package:famous_steam_user/const/colors.dart';
import 'package:famous_steam_user/const/config.dart';
import 'package:famous_steam_user/const/prefKeys.dart';
import 'package:famous_steam_user/const/util.dart';
import 'package:famous_steam_user/homePage.dart';
import 'package:famous_steam_user/localizations/app_localizations.dart';
import 'package:famous_steam_user/model/get_timeslot_model.dart';
import 'package:famous_steam_user/model/package_index_model.dart';
import 'package:famous_steam_user/model/vehicle_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:table_calendar/table_calendar.dart';

import '../const/all_direction_navigator.dart';
import '../const/global.dart';
import 'service_list_booking_start_page.dart';
import 'dart:ui' as UI;

class ServiceListBookingDetailPage extends StatefulWidget {

  final PackageData selectedPackageData;
  final  List<ServiceListData> selectedExtraServiceData;
  final VehicleDetails selectedvahicleDetails;


  const ServiceListBookingDetailPage(
      {Key? key,required this.selectedPackageData,required this.selectedExtraServiceData,required this.selectedvahicleDetails})
      : super(key: key);

  @override
  State<ServiceListBookingDetailPage> createState() =>
      _ServiceListBookingDetailPageState();
}

class _ServiceListBookingDetailPageState
    extends State<ServiceListBookingDetailPage> {
  CalendarFormat calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  int? selectedIndex;

  bool checkExpansionTile = false;
  int? val;
  String dropValue1 = '';
  String slotId = '';
  String time = '';
  String slotDate = DateFormat("yyyy-MM-dd").format(DateTime.now());

  String cdate1 = DateFormat("EEEEE").format(DateTime.now());
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final userstr =
  PrefObj.preferences!.containsKey(PrefKeys.TOKEN) ? true : false;

  @override
  void initState() {
    super.initState();
    if (Config.isDebug) {print('page--> ServiceListBookingDetailPage');}
    gettimeslotbloc.gettimeslotsink(cdate1, slotDate);
/*    Timer.periodic(const Duration(seconds: 10), (Timer t) => getCurrentLocation());*/
    print(cdate1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightrgrey,
      key: _key,
      endDrawer: drawer(context),
      appBar: PreferredSize(
          child: Padding(
            padding: const EdgeInsets.only(right: 18, left: 18, top: 40),
            child: appbarWidget(context, _key),
          ),
          preferredSize: const Size(double.infinity, 60)),
      body: Container(

        padding: const EdgeInsets.only(left: 18, right: 18),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              selectDate(),
              SizedBox(height: 15.h),
              calenderData(),
              SizedBox(height: 30.h),
              selectTimeSlot(),
              SizedBox(height: 15.h),
              timeSet(),
              SizedBox(height: 15.h),
              bookYourServiceButton(),
              SizedBox(height: 50.h),
            ],
          ),
        ),

      ),
    );
  }

  Widget selectDate() {
    return Text(
      Translation.of(context)!.translate('selectdate')!,
      style: GoogleFonts.montserrat(
          textStyle: TextStyle(
            fontSize: 16.sp,
          )),
    );
  }

  Widget calenderData() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.w),
          color: AppColor.whiteColor,
          boxShadow: [
            BoxShadow(
              color: AppColor.appColor.withOpacity(0.8),
              blurRadius: 3.0,
            ),
          ]),
      child: TableCalendar(
        firstDay: kToday,
        lastDay: kLastDay,
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(_selectedDay, selectedDay)) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
            selectedIndex = null;
            slotDate = DateFormat("yyyy-MM-dd").format(_selectedDay!);
            gettimeslotbloc.gettimeslotsink(
                DateFormat('EEEE').format(_selectedDay!),
                DateFormat("dd-MM-yyyy").format(_selectedDay!));

            setState(() {});
          }
        },
      ),
    );
  }

  Widget selectTimeSlot() {
    return Text(
      Translation.of(context)!.translate('selecttimeslot')!,
      style: GoogleFonts.montserrat(
          textStyle: TextStyle(
            fontSize: 16.sp,
          )),
    );
  }

  Widget timeSet() {
    return StreamBuilder<GettimeslotModel>(
      stream: gettimeslotbloc.getuserstream,
      builder: (context, AsyncSnapshot<GettimeslotModel> gettimeslotsnapshot) {
        if (!gettimeslotsnapshot.hasData) {
          return Center(
            child: SizedBox(
              height: 100.h,
              width: 100.w,
              child: Lottie.asset(
                'images/102766-error.json',
              ),
            ),
          );
        }
        return gettimeslotsnapshot.data!.data!.isEmpty
            ? SizedBox(
          height: 100.h,
          child: Center(
            child: Text(
              'No Time Slot Found',
              style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    color: AppColor.blackColor,
                    fontSize: 10.h,
                  )),
            ),
          ),
        )
            : ListView.builder(
          padding: const EdgeInsets.all(0),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: gettimeslotsnapshot.data!.data!.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                selectedIndex = index;
                //  slotId = gettimeslotsnapshot.data!.data![index].timeslot_id.toString();
                time = gettimeslotsnapshot.data!.data![index].toString();
                setState(() {});
              },
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width - 10,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 15),
                margin: const EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  borderRadius:
                  const BorderRadius.all(Radius.circular(8.0)),
                  color: Colors.white,
                  border: Border.all(
                      color: selectedIndex == index
                          ? AppColor.redColor
                          : Colors.black),
                ),

                child:Directionality(
                  textDirection: UI.TextDirection.ltr,
                  child:  Text(
                    gettimeslotsnapshot.data!.data![index].toString(),locale: Locale('eng'),
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          color: AppColor.blackColor,
                          fontSize: 16.h,
                        )),
                  ),
                ),


              ),
            );
          },
        );
      },
    );
  }

  Widget bookYourServiceButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            if (selectedIndex == null) {
              final snackBar = SnackBar(
                  content: Text(
                    Translation.of(context)!.translate('Please Select Your Time Slot...!')!,
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else {

                NavigatorAnimation(
                    context,
                    SelectyouraddressPage(
                      selectedPackageData: widget.selectedPackageData,
                      selectedExtraServiceData: widget.selectedExtraServiceData,
                      selectedvahicleDetails: widget.selectedvahicleDetails,
                      slotDate: slotDate,
                      slotTime: time,
                    )).navigateFromRight();
            }
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColor.appColor,
              borderRadius: BorderRadius.circular(3),
            ),
            child: Center(
              child: Text(
                Translation.of(context)!.translate('bookyourservice')!,
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
