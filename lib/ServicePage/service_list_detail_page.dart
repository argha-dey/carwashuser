import 'dart:async';

import 'package:famous_steam_user/ServicePage/service_list_booking_detail_page.dart';
import 'package:famous_steam_user/bloc/service_details_bloc.dart';
import 'package:famous_steam_user/cart.dart';
import 'package:famous_steam_user/const/colors.dart';
import 'package:famous_steam_user/const/config.dart';
import 'package:famous_steam_user/const/global.dart';
import 'package:famous_steam_user/const/prefKeys.dart';
import 'package:famous_steam_user/homePage.dart';
import 'package:famous_steam_user/localizations/app_localizations.dart';
import 'package:famous_steam_user/model/package_index_model.dart';
import 'package:famous_steam_user/model/service_details_model.dart';
import 'package:famous_steam_user/model/vehicle_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../const/all_direction_navigator.dart';

class ServiceListDetailPage extends StatefulWidget {
  const ServiceListDetailPage({Key? key, required this.selectedPackageData,required this.selectedExtraServiceData,required this.selectedvahicleDetails})
      : super(key: key);
  final PackageData selectedPackageData;
  final  List<ServiceListData> selectedExtraServiceData;
  final VehicleDetails selectedvahicleDetails;
  @override
  State<ServiceListDetailPage> createState() => _ServiceListDetailPageState();
}

class _ServiceListDetailPageState extends State<ServiceListDetailPage> {
  Data? data;

  @override
  void initState() {
    super.initState();
    if (Config.isDebug) {print('page--> ServiceListDetailPage');}

    /*  Timer.periodic(const Duration(seconds: 10), (Timer t) => getCurrentLocation());*/

    // servicedetailsbloc.servicedetailssink('eng', widget.alldata.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _key = GlobalKey();

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
          // ignore: deprecated_member_use
          notification.disallowGlow();
          return true;
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 18, right: 18),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30),
              //  topImage(),
                SizedBox(height: 5.w),
                otherText(widget.selectedPackageData),
                SizedBox(height: 5.w),
                otherDetail(widget.selectedPackageData),
                SizedBox(height: 10.w),
                continueButton(widget.selectedPackageData),
                SizedBox(height: 10.w),
                /*        addToCartButton(widget.selectedPackageData),
                SizedBox(height: 10.w)
                rateContainer(widget.selectedPackageData),
                SizedBox(height: 15.w),
                customerReview(widget.selectedPackageData),
                SizedBox(height: 10.w),,*/
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
        'images/srvice list-details.png',
      ),
    );
  }

  Widget otherText(PackageData packageDetailsData) {
    return Column(
      children: [
        Text(
          packageDetailsData.packageName!,
          style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                color: AppColor.appColor,
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
              )),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }

  Widget otherDetail(
      PackageData packageDetailsData) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              Translation.of(context)!.translate('price')!,
              style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    color: AppColor.appColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp,
                  )),
            ),
            Text(
              'SAR ${packageDetailsData.packagePrice!}',
              style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    color: AppColor.appColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                  )),
            ),
          ],
        ),
        SizedBox(height: 10.w),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              Translation.of(context)!.translate('packagename')!,
              style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    color: AppColor.appColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp,
                  )),
            ),
          ],
        ),
        SizedBox(height: 5.w),
        Text(
          packageDetailsData.packageName!,
          style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                color: AppColor.appColor,
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
              )),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.left,),


        SizedBox(height: 10.w),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Text(
              Translation.of(context)!.translate('vehicletype')!,
              style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    color: AppColor.appColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp,
                  )),
            ),

            Text(
              widget.selectedvahicleDetails.brand!.name.toString()+" ("+widget.selectedvahicleDetails.category!.name.toString()+")",
              style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    color: AppColor.appColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                  )),
            ),


          ],
        ),
        SizedBox(height: 10.w),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              Translation.of(context)!.translate('vehiclesize')!,
              style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    color: AppColor.appColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp,
                  )),
            ),
            Column(
              children: [
                Text(
                  widget.selectedvahicleDetails.carSize!.sizeName.toString()+" ("+  widget.selectedvahicleDetails.year!.yearName.toString()+")",
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        color: AppColor.appColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                      )),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 10.w),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            Translation.of(context)!.translate('packageservicedetails')!,
            style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  color: AppColor.appColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                )),
          ),
        ),
        SizedBox(height: 10.w),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: packageServiceList(packageDetailsData.packageServices),
        ),

        SizedBox(height: 10.w),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            Translation.of(context)!.translate('extraservicedetails')!,
            style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  color: AppColor.appColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                )),
          ),
        ),
        SizedBox(height: 10.w),
        widget.selectedExtraServiceData.isNotEmpty?Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: extraPackageServiceList(widget.selectedExtraServiceData),
        ):Text(Translation.of(context)!.translate('No Extra Service Added')!,style: GoogleFonts.montserrat(
            textStyle: TextStyle( color: AppColor.redColor,
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,)),),




        SizedBox(height: 10.w),
      ],
    );
  }

  List<Widget> packageServiceList(List<PackageServices>? packageServices) {
    List<Widget> widgets = [];

    for (PackageServices serviceData in packageServices!) {
      widgets.add(

        Text(

          serviceData!.serviceName.toString(),
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
            Text(
              'SAR ${serviceData.service_price}',
              style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                  )),
            ),

          ],
        ),




      );
    }
    return widgets;
  }



  Widget continueButton(PackageData packageDetailsData) {
    return GestureDetector(
      onTap: () {

        NavigatorAnimation(
          context,
          ServiceListBookingDetailPage(
              selectedPackageData:packageDetailsData,
              selectedExtraServiceData:widget.selectedExtraServiceData,
              selectedvahicleDetails:widget.selectedvahicleDetails),
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
    );
  }

/*  Widget addToCartButton(
      PackageData packageDetailsData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            List getCartDatas = [];
   *//*         Map cartData = {
              'id': servicedetailssnapshot.data!.data![0].id,
              'serviceName': servicedetailssnapshot.data!.data![0].packagePlan,
              'serviceType': servicedetailssnapshot.data!.data![0].categoryName,
              'carsize': servicedetailssnapshot.data!.data![0].size,
              'cost': servicedetailssnapshot.data!.data![0].price,
              'packageId': widget.selectedPackageData.packageId!
            };*//*
            if (PrefObj.preferences!.containsKey(PrefKeys.CARTLIST)) {
              getCartDatas = PrefObj.preferences!.get(PrefKeys.CARTLIST);
            }

          //  getCartDatas.add(cartData);

            NavigatorAnimation(
              context,
              CartPage(getCartDatas: getCartDatas),
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
                Translation.of(context)!.translate('addtocart')!,
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
        SizedBox(height: 15.w),
        reviewAndRate(),
        SizedBox(height: 10.w),
      //  rateContainer(servicedetailssnapshot),
        SizedBox(height: 15.w),
      //  customerReview(servicedetailssnapshot),
        SizedBox(height: 10.w),
      ],
    );
  }*/

  Widget reviewAndRate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Translation.of(context)!.translate('reviewandrating')!,
          style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                color: AppColor.yellowColor,
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
              )),
        ),
        SizedBox(height: 10.w),
        Text(
          Translation.of(context)!.translate('customerrating')!,
          style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                color: AppColor.greyColor1,
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
              )),
        ),
      ],
    );
  }

  Widget rateContainer(
      PackageData packageDetailsData) {
    return Container(
      padding: const EdgeInsets.all(12.5),
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(3),
        boxShadow: [
          BoxShadow(
            color: AppColor.greyColor1.withOpacity(0.1),
            blurRadius: 3.0,
            offset: const Offset(1, 1),
          ),
        ],
      ),
      child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    /* '${servicedetailssnapshot.data!.data![0].serviceratingaverage.toString()}/5'*/  "3/5",
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          color: AppColor.greyColor1,
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp,
                        )),
                  ),
                  RatingBar.builder(
                    itemSize: 20.w,
                    initialRating: double.parse(/*servicedetailssnapshot
                    .data!.data![0].serviceratingaverage
                    .toString()*/   "3"),
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    updateOnDrag: false,
                    tapOnlyMode: false,
                    ignoreGestures: true,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: AppColor.yellowColor,
                    ),
                    onRatingUpdate: (rating) {},
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                /*  ${servicedetailssnapshot.data!.data![0].servicerating!.length}*/
                'based on  40 reviews',
                style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      color: AppColor.lightButtonColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 11.sp,
                    )),
              ),
            ],
          )),
    );
  }

  Widget customerReview(
      PackageData packageDetailsData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Translation.of(context)!.translate('customerreview')!,
          style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                color: AppColor.greyColor1,
                fontSize: 14.sp,
              )),
        ),
        SizedBox(height: 15.w),
        ListView.builder(
          padding: const EdgeInsets.all(0),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount:
          /*  servicedetailssnapshot.data!.data![0].servicerating!.length*/ 2,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              child: Container(
                padding: const EdgeInsets.all(12.5),
                decoration: BoxDecoration(
                  color: AppColor.whiteColor,
                  borderRadius: BorderRadius.circular(3),
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.greyColor1.withOpacity(0.1),
                      blurRadius: 3.0,
                      offset: const Offset(1, 1),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Good Service',
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              color: AppColor.greyColor1,
                              fontWeight: FontWeight.w700,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                        /*  RatingBar.builder(
                          itemSize: 20.w,
                          initialRating: double.parse(servicedetailssnapshot
                              .data!.data![0].servicerating![index].rating!),
                          minRating: double.parse(servicedetailssnapshot
                              .data!.data![0].servicerating![index].rating!),
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          ignoreGestures: true,
                          itemCount: 5,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: AppColor.yellowColor,
                          ),
                          onRatingUpdate: (rating) {},
                        ),*/
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      /*   servicedetailssnapshot
                          .data!.data![0].servicerating![index].review!*/  " ",
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            color: AppColor.lightButtonColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 11.sp,
                          )),
                    ),
                    const SizedBox(height: 5),
                    Text(" ",
                      /* 'by ${servicedetailssnapshot.data!.data![0].servicerating![index].name!} 12.03.2021'*/
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            color: AppColor.lightButtonColor,
                            fontSize: 11.sp,
                          )),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget loadMoreButton() {
    return Center(
      child: Container(
        padding:
        EdgeInsets.only(left: 27.w, right: 27.w, top: 10.w, bottom: 10.w),
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: AppColor.yellowColor,
          borderRadius: BorderRadius.circular(3),
        ),
        child: Text(
          'Load More',
          style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                color: AppColor.whiteColor,
                fontSize: 14.sp,
              )),
        ),
      ),
    );
  }
}
