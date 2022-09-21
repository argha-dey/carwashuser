import 'dart:async';

import 'package:famous_steam_user/const/config.dart';
import 'package:famous_steam_user/review_and_rating_page.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'bloc/bookinghistory_bloc.dart';
import 'const/all_direction_navigator.dart';
import 'const/colors.dart';
import 'const/global.dart';
import 'const/prefKeys.dart';
import 'const/text.dart';
import 'localizations/app_localizations.dart';
import 'model/booking_history_model.dart';
import 'order_page.dart';

class OderHistoryPage extends StatefulWidget {
  const OderHistoryPage({Key? key}) : super(key: key);

  @override
  State<OderHistoryPage> createState() => _OderHistoryPageState();
}

class _OderHistoryPageState extends State<OderHistoryPage> {
  var userstr = false;
  DateTime initialdate = DateTime.now();
  Future<DateTime> selectDate(
      BuildContext context, DateTime _date, String type) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(2018),
        lastDate: DateTime(2030),
        currentDate: DateTime.now());
    if (picked != null) {
      setState(() {
        _date = picked;
      });
    }
    return _date;
  }
  @override
  void initState() {
    super.initState();
    if (Config.isDebug) {print('page--> OderHistoryPage');}
    userstr = PrefObj.preferences!.containsKey(PrefKeys.TOKEN) ? true : false;
    if (userstr) {
      /*  Timer.periodic(
          const Duration(seconds: 10), (Timer t) => getCurrentLocation());*/
      bookinghistorybloc.bookinghistorysink('today', DateFormat('yyyy-MM-dd').format(initialdate).toString(), DateFormat('yyyy-MM-dd').format(initialdate).toString());
    }
  }

  Future<bool> _willPopCallback() async {
    // await showDialog or Show add banners or whatever
    // then
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: _willPopCallback,
      child: new Scaffold(
        backgroundColor: AppColor.lightrgrey,
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.only(left: 14, right: 14),
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (notification) {
              notification.disallowGlow();
              return true;
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizedBox(height: 10.w),
                bookingHistory(),

                SizedBox(height: 10.w),
                //  tabView(),
                filterText(),
                SizedBox(height: 10.w),

                Expanded(child:  card())
              ],
            ),
          ),
        ),
      ),
    );

  }

  Widget filterText() {
    return InkWell(
        onTap: () async{
          final DateTime? picked = await showDatePicker(
            context: context,
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                    textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                        primary: AppColor.appColor,
                      ),
                    ),
                    textTheme: const TextTheme()),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 80.0, bottom: 80),
                  child: Container(child: child!),
                ),
              );
            },
            initialDate: initialdate,
            firstDate: DateTime(2000),
            lastDate: DateTime(2030),
          );
          if (picked != null && picked != initialdate) {
            bookinghistorybloc.bookinghistorysink('select_date', DateFormat('yyyy-MM-dd').format(picked).toString(), DateFormat('yyyy-MM-dd').format(picked).toString());
            setState(() {
              initialdate = picked;

            });
          }
        } ,

        child: Column(

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                  'images/filter.png',
                  height: 14.0,
                  width: 14.0,
                ),
                const SizedBox(width: 7.0),
                AppText(
                  Translation.of(context)!.translate('filter')!,
                  color: AppColor.appColor,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            const SizedBox(width: 12.0),
            Align(
              alignment: Alignment.bottomRight,
              child:   AppText(
                DateFormat('yyyy-MM-dd').format(initialdate),
                color: AppColor.appColor,
                fontWeight: FontWeight.w500,
              ),
            )


          ],
        )


    );

  }



  /*

  Widget tabView(){
    return Container(

        child:Container(
          alignment: FractionalOffset.center,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(child: Container(
                  height: 40.h,
                  margin: const EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    color: AppColor.yellowColor,
                    borderRadius:
                    BorderRadius.circular(0),
                  ),
                  child:TextButton(onPressed: (){

                    setState(() {
                      bookinghistorybloc.bookinghistorysink('','','');
                    });


                  },child:  Center(
                    child: Text(
                      'Pending',
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            color: AppColor.whiteColor,
                            fontSize: 12.sp,
                          )),
                    ),
                  ))),flex: 1,),
              Expanded(child:   Container(
                  height: 40.h,
                  margin: const EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    color: AppColor.greenColor,
                    borderRadius:
                    BorderRadius.circular(0),
                  ),
                  child:TextButton(onPressed: (){

                    setState(() {
                      bookinghistorybloc.bookinghistorysink('complete','','');
                    });

                  },child: Center(
                    child: Text(
                      'Complete',
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            color: AppColor.whiteColor,
                            fontSize: 12.sp,
                          )),
                    ),
                  ),)),flex: 1,)

            ],
          ),
        )
    );

  }

  */
  Widget bookingHistory() {
    return
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Text(
            Translation.of(context)!.translate('bookinghistory')!,
            style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColor.appColor,
                )),
          ),

          InkWell(
            onTap: (){
              bookinghistorybloc.bookinghistorysink('','','');
            },
            child:Text(
              Translation.of(context)!.translate('viewall')!,
              style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColor.appColor,
                  )),
            ),
          )

        ],
      );

  }

  Widget card() {
    return SizedBox(

      height: MediaQuery.of(context).size.height-350,
      child: StreamBuilder<BookinghistoryModel>(
        stream: bookinghistorybloc.bookinghistorystream,


        builder: (context,
            AsyncSnapshot<BookinghistoryModel> bookinghistorysnapshot) {

          if (!bookinghistorysnapshot.hasData) {
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

          return bookinghistorysnapshot.data!.data!.isEmpty
              ? SizedBox(
            height: MediaQuery.of(context).size.height - 300,
            child: Center(
              child: Text(
                Translation.of(context)!.translate(
                  'nodatafound',
                )!,
              ),
            ),
          )
              : ListView.builder(

              itemCount: bookinghistorysnapshot.data!.data!.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    GestureDetector(
                        onTap: () {
                          NavigatorAnimation(context, OrderPage(id: bookinghistorysnapshot!.data!.data![index].orderId.toString(),displayId: bookinghistorysnapshot!.data!.data![index].orderDisplayId.toString()),
                          ).navigateFromRight();
                        },
                        child:Container(
                          color: Colors.transparent,
                          child: Container(
                            decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 3.0,
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.all(Radius.circular(3.0))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 10),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Order id: ${bookinghistorysnapshot.data!
                                            .data![index].orderDisplayId!}',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xff004471)),
                                      ),
                                      const Spacer(),
                                      Text(
                                        'SAR ${bookinghistorysnapshot.data!
                                            .data![index].totalAmount!}',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xff004471)),
                                      ),
                                    ],
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.only(left: 10.sp, top: 8,right: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Date:  " + bookinghistorysnapshot
                                            .data!.data![index].appointmentDate!,
                                        style: GoogleFonts.montserrat(
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w400,
                                            color: const Color(0xff7E7C7C)),
                                      ),
                                      SizedBox(height: 5.w),


                                      Text(
                                        "Slot:  " + bookinghistorysnapshot
                                            .data!.data![index].timeslotId.toString(),
                                        style: GoogleFonts.montserrat(
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w400,
                                            color: const Color(0xff7E7C7C)),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5.w),
                                Visibility(
                                  visible: bookinghistorysnapshot
                                      .data!.data![index].orderStatus!
                                      .contains('complete')
                                      ? true
                                      : false,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                      right: 10,
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          "",
                                          style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                              color: const Color(0xff2F2F2F)),
                                        ),
                                        const Spacer(),
                                        Text(
                                        Translation.of(context)!.translate('rating')!,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 11,
                                              fontWeight: FontWeight.normal,
                                              color: const Color(0xffAFAFAF)),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),

                                        RatingBarIndicator(
                                          itemSize: 20.w,
                                          rating: bookinghistorysnapshot.data!
                                              .data![index].my_rating == null
                                              ? 0
                                              : parseAmount(
                                              bookinghistorysnapshot.data!
                                                  .data![index].my_rating),
                                          itemBuilder: (context, index) =>
                                              Icon(
                                                Icons.star,
                                                color: AppColor.yellowColor,
                                              ),
                                          itemCount: 5,
                                          direction: Axis.horizontal,
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Visibility(
                                  visible: bookinghistorysnapshot
                                      .data!.data![index].orderStatus!
                                      .contains('complete')
                                      ? true
                                      : false,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                      right: 10,
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          '',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                              color: const Color(0xff2F2F2F)),
                                        ),
                                        const Spacer(),

                                        bookinghistorysnapshot.data!
                                            .data![index].my_rating == null
                                            ?  GestureDetector(
                                          onTap: () {
                                            NavigatorAnimation(
                                              context,
                                              ReviewAndRatingPage(
                                                  orderId: bookinghistorysnapshot
                                                      .data!.data![index].orderId
                                                      .toString(),
                                                  packageId: bookinghistorysnapshot
                                                      .data!.data![index].package!
                                                      .packageId.toString()),

                                            ).navigateFromRight();
                                          },
                                          child: Text(
                                           Translation.of(context)!.translate('Give feedback')!,
                                            style: GoogleFonts.montserrat(
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal,
                                                color: const Color(0xffFF9529)),
                                          ),
                                        ):Text(
                                       Translation.of(context)!.translate('Feedback Done')!,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                              color: const Color(0xffFF9529)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 10,
                                    right: 8,

                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        bookinghistorysnapshot
                                            .data!.data![index].orderStatus.toString()
                                            .toUpperCase(),
                                        style: GoogleFonts.montserrat(
                                            fontSize: 13,
                                            fontWeight: bookinghistorysnapshot
                                                .data!.data![index].orderStatus!
                                                .contains('complete')
                                                ?  FontWeight.bold
                                                :  FontWeight.bold,
                                            color:  bookinghistorysnapshot
                                                .data!.data![index].orderStatus!
                                                .contains('complete')
                                                ?  Colors.green
                                                :  Colors.black),
                                      ),


                                      GestureDetector(
                                        onTap: () {
                                          NavigatorAnimation(
                                            context,
                                            OrderPage(
                                                id: bookinghistorysnapshot!.data!.data![index].orderId.toString(),displayId:bookinghistorysnapshot!.data!.data![index].orderDisplayId.toString()),
                                          ).navigateFromRight();
                                        },
                                        child: Container(
                                          height: 30.h,
                                          width: 100.w,
                                          margin: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: AppColor.yellowColor,
                                            borderRadius:
                                            BorderRadius.circular(3),
                                          ),
                                          child: Center(
                                            child: Text(
                                             Translation.of(context)!.translate('Track Booking')!,
                                              style: GoogleFonts.montserrat(
                                                  textStyle: TextStyle(
                                                    color: AppColor.whiteColor,
                                                    fontSize: 11.sp,
                                                  )),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                )
                              ],
                            ),
                          ),
                        )

                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                );
              });


        },
      ),
    );
  }
}
double parseAmount(dynamic dAmount){

  double returnAmount = 0.00;
  String strAmount;

  try {

    if (dAmount == null || dAmount == 0) return 0.0;

    strAmount = dAmount.toString();

    if (strAmount.contains('.')) {
      returnAmount = double.parse(strAmount);
    }else{
      returnAmount = double.parse(strAmount);
      // Didn't need else since the input was either 0, an integer or a double
    }
  } catch (e) {
    return 0.0;
  }

  return returnAmount;
}
