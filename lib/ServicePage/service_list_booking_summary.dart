import 'dart:async';

import 'package:famous_steam_user/Repository/repository.dart';
import 'package:famous_steam_user/bloc/get_summary_bloc.dart';
import 'package:famous_steam_user/const/colors.dart';
import 'package:famous_steam_user/const/config.dart';
import 'package:famous_steam_user/homePage.dart';
import 'package:famous_steam_user/localizations/app_localizations.dart';
import 'package:famous_steam_user/model/SummeryModel.dart';
import 'package:famous_steam_user/model/package_index_model.dart';
import 'package:famous_steam_user/model/vehicle_list_model.dart';
import 'package:famous_steam_user/select_Payment_Method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../const/all_direction_navigator.dart';
import '../const/global.dart';
import 'dart:ui' as UI;

class ServiceListbookingSummery extends StatefulWidget {

  final PackageData selectedPackageData;
  final  List<ServiceListData> selectedExtraServiceData;
  final VehicleDetails selectedvahicleDetails;
  final String slotDate;
  final String slotTime;
  final String addressId;
  final String  address;
  const ServiceListbookingSummery(
      {Key? key,
        required this.selectedPackageData,
        required this.selectedExtraServiceData,
        required this.selectedvahicleDetails,
        required this.slotDate,
        required this.slotTime,
        required this.addressId,
        required this.address
      })
      : super(key: key);

  @override
  State<ServiceListbookingSummery> createState() =>
      _ServiceListbookingSummeryState();
}

class _ServiceListbookingSummeryState extends State<ServiceListbookingSummery> {

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final repository = Repository();


  @override
  void initState() {
    if (Config.isDebug) {print('page--> ServiceListbookingSummery');}
    super.initState();
 /*   Timer.periodic(const Duration(seconds: 10), (Timer t) => getCurrentLocation());*/

    setState(() {
      getsummarybloc.getSummarySink(widget.selectedPackageData, widget.selectedExtraServiceData, widget.selectedvahicleDetails, widget.slotTime, widget.slotDate, widget.addressId);
    });



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
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (notification) {
          notification.disallowGlow();
          return true;
        },
        child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.only(left: 18.w, right: 18.w),
              child: StreamBuilder<SummeryModel>(
                stream: getsummarybloc.getsummarytream,
                builder: (context, AsyncSnapshot<SummeryModel> summarySnapshot) {
                  if (!summarySnapshot.hasData) {
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
                    return SingleChildScrollView(


                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(Translation.of(context)!.translate('servicesummary')!,
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      color: const Color(0xff2F2F2F), fontSize: 18.h))),
                          card(summarySnapshot.data),
                          SizedBox(height: 40.h),
                          proceedtoPaymentButton(summarySnapshot.data),
                          SizedBox(height: 40.h),
                        ],
                      ),
                    );

                },
              )
          ),
        ),
      ),
    );
  }

  Widget card(SummeryModel? data) {
    return Container(
      padding: const EdgeInsets.only(top: 25),
      child: Container(
        color: Colors.transparent,
        child: Container(
          decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 2.0,
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(3.0))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20,right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Translation.of(context)!.translate('pickuplocation')!,
                      style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff004471)),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      widget.address,
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        color: const Color(0xff2F2F2F),
                      ),
                    ),
                    SizedBox(height: 18.h),
                    Text(
                      Translation.of(context)!.translate('vehicletype')!,
                      style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff004471)),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      widget.selectedvahicleDetails.brand!.name.toString() +"(" +widget.selectedvahicleDetails.category!.name.toString()+")",
                      style: GoogleFonts.montserrat(
                          fontSize: 14, color: const Color(0xff2F2F2F)),
                    ),
                    SizedBox(height: 18.h),
                    Text(
                      Translation.of(context)!.translate('vehiclesize')!,
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff004471),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      widget.selectedvahicleDetails.carSize!.sizeName.toString()+" - "+ widget.selectedvahicleDetails.year!.yearName.toString(),
                      style: GoogleFonts.montserrat(
                          fontSize: 14, color: const Color(0xff2F2F2F)),
                    ),
                    SizedBox(height: 18.h),
                    Text(
                      Translation.of(context)!.translate('pickupslot')!,
                      style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff004471)),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),

                    Directionality(
                      textDirection: UI.TextDirection.ltr,
                      child:   Text(
                        widget.slotTime.toString(),locale: Locale('eng'),
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              fontSize: 14, color: const Color(0xff2F2F2F)),
                          ),
                        ),
                      ),




                    const SizedBox(
                      height: 10,
                    ),

                    Row(
                      children: [
                        Text(
                          Translation.of(context)!
                              .translate('totaltimeduration')!,
                          style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff004471)),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Text(
                            "${data!.timeDuration} Min",
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 18.h),



                    Row(
                      children: [
                        Text(
                          Translation.of(context)!
                              .translate('packageprice')!,
                          style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff004471)),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Text(
                            "SAR ${ widget.selectedPackageData.packagePrice.toString()}",
                            style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xff004471)),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 18.h),
                    Text(
                      Translation.of(context)!.translate('packagename')!,
                      style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff004471)),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      widget.selectedPackageData.packageName.toString(),
                      style: GoogleFonts.montserrat(
                          fontSize: 14, color: const Color(0xff2F2F2F)),
                    ),
                    SizedBox(height: 18.h),
                    Text(
                      Translation.of(context)!.translate('packageservicedetails')!,
                      style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff004471)),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: packageServiceList(widget.selectedPackageData.packageServices),
                    ),


                    SizedBox(height: 18.h),
                    Text(
                      Translation.of(context)!.translate('extraservicedetails')!,
                      style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff004471)),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    widget.selectedExtraServiceData.isNotEmpty?Column(

                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: extraPackageServiceList(widget.selectedExtraServiceData),
                    ):Text(Translation.of(context)!.translate('No Extra Service Added')!, style: GoogleFonts.montserrat(
                        textStyle: TextStyle( color: AppColor.redColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,)),),

                    const Padding(
                      padding: EdgeInsets.only(right: 10, top: 12),
                      child: Divider(
                        height: 20,
                        thickness: 0.5,
                        endIndent: 7,
                        color: Color(0xff7E7C7C),
                      ),
                    ),




                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          Translation.of(context)!
                              .translate('totalordervalue')!,
                          style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff004471)),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Text(
                            "SAR ${data.total}",
                            style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xff004471)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  List<Widget> packageServiceList(List<PackageServices>? packageServices) {
    List<Widget> widgets = [];

    for (PackageServices serviceData in packageServices!) {
      widgets.add(

        Text(
          serviceData.serviceName.toString(),
          style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                fontSize: 14.sp,
              )),
        ),

      );
    }
    return widgets;
  }



  List<Widget> extraPackageServiceList( List<ServiceListData> selectedExtraServiceData) {
    List<Widget> widgets = [];
    for (ServiceListData serviceData in selectedExtraServiceData!) {
      widgets.add(

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Flexible(child: Text(
              serviceData!.name.toString(),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: GoogleFonts.montserrat(
                  textStyle: TextStyle(

                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                  )),
            )),

            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text(
                'SAR ${serviceData.service_price}',
                style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff004471)),
              ),
            ),

          ],
        ),

      );
    }
    return widgets;
  }

  Widget proceedtoPaymentButton(SummeryModel? data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {

            NavigatorAnimation(
              context,
              SelectpaymentMethod(
                selectedPackageData: widget.selectedPackageData,
                selectedExtraServiceData: widget.selectedExtraServiceData,
                selectedvahicleDetails: widget.selectedvahicleDetails,
                slotDate: widget.slotDate,
                slotTime: widget.slotTime,
                addressId: widget.addressId,
                address: widget.address,
                summeryData:data!,

              ),
            ).navigateFromRight();
            setState(() {});
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColor.appColor,
              borderRadius: BorderRadius.circular(3),
            ),
            child: Center(
              child: Text(
                Translation.of(context)!.translate('proceedtopayment')!,
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
