import 'dart:async';


import 'package:famous_steam_user/bloc/order_details_bloc.dart';
import 'package:famous_steam_user/const/colors.dart';
import 'package:famous_steam_user/const/config.dart';
import 'package:famous_steam_user/const/global.dart';
import 'package:famous_steam_user/model/order_details_model.dart';
import 'package:famous_steam_user/model/order_status_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'bloc/order_status_bloc.dart';
import 'localizations/app_localizations.dart';
import 'dart:ui' as UI;

class OrderPage extends StatefulWidget {
  final String id;
  final String displayId;
  OrderPage({Key? key, required this.id,required this.displayId}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  List<OrderStatusModel>? users;
  OrderStatusModel? selectedUser;
  String flag = "0";


  @override
  void initState() {
    super.initState();
    if (Config.isDebug) {print('page--> OrderPage');}


    orderDetailsbloc.oderdetailssink('eng', widget.id);

    setState(() {

    });


  }




  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(

        builder: (context , child) {
          return Scaffold(
              backgroundColor: AppColor.lightrgrey,
              key: _key,
              endDrawer: drawer(context),
              appBar: PreferredSize(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),

                    /*  child: yourLocation(context, _key),*/

                  ), preferredSize:  Size(double.infinity, 60)),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left: 18.w, right: 18.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30.w),
                      appbarWidget(context, _key),
                      SizedBox(height: 15.w),
                      trackBook(),
                      SizedBox(height: 15.w),
                      stepBar(),
                      SizedBox(height: 15.w),
                    ],
                  ),
                ),
              ));
        }
    );
  }

  Widget trackBook() {
    return Text( Translation.of(context)!.translate('trackbooking')!,
      style: GoogleFonts.montserrat(
          textStyle: TextStyle(
            fontSize: 16.sp,
          )),
    );
  }

  Widget stepBar() {
    return Container(
      decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: AppColor.lightButtonColor.withOpacity(0.3),
              blurRadius: 8,
              spreadRadius: 0.2,
            )
          ]),

      child: StreamBuilder<OrderDetailsModel>(
          stream: orderDetailsbloc.oderstatustream,
          builder:
              (context, AsyncSnapshot<OrderDetailsModel> oderDetailssnapshot) {
            if (!oderDetailssnapshot.hasData) {
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

            oderDetailssnapshot.data!.data!.orderStatus!='complete' ? orderStatusbloc.oderstatussink('eng', widget.id):"";

            return Column(
              children: [
                orderId(),

                oderDetailssnapshot.data!.data!.orderStatus=='complete'? Container(): StreamBuilder<OrderStatusModel>(
                    stream: orderStatusbloc.oderstatustream,
                    builder:
                        (context, AsyncSnapshot<OrderStatusModel> oderstatussnapshot) {
                      if (!oderstatussnapshot.hasData) {
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
                      return stepperList(oderstatussnapshot,oderDetailssnapshot);
                    }
                ),

                otherDetail(oderDetailssnapshot),
                SizedBox(height: 15.w),
              ],
            );

          }),
    );
  }

  Widget stepperList(AsyncSnapshot<OrderStatusModel> oderstatussnapshot, AsyncSnapshot<OrderDetailsModel> oderDetailssnapshot) {


    return Theme(
      data: ThemeData(
          accentColor: int.parse(flag) == 1
              ? Colors.grey
              : int.parse(flag) == 0
              ? Colors.green
              : Colors.green,

          primarySwatch: int.parse(flag) == 0
              ? Colors.grey
              : int.parse(flag) == 1
              ? Colors.green
              : Colors.green,

          colorScheme: ColorScheme.light(
              primary: int.parse(flag) == 0
                  ? Colors.grey
                  : int.parse(flag) == 1
                  ? Colors.green
                  : Colors.green)),
      child: Stepper(
        controlsBuilder: (context, _) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              SizedBox(),
              SizedBox(),
            ],
          );
        },
        steps: createStepListUsers(oderstatussnapshot.data!.data!,oderDetailssnapshot),
        physics: const ScrollPhysics(),
        currentStep: 0,
      ),
    );
  }


  List<Step> createStepListUsers(List<StepData> stepData, AsyncSnapshot<OrderDetailsModel> _oderDetailssnapshot) {
    List<Step> widgets = [];

    for (StepData user in stepData) {

      /*   if(user.staffOrderStatusId.toString() == _oderDetailssnapshot.data!.data!.staffStatus.toString())*/

      if(_oderDetailssnapshot.data!.data!.staffStatus==null){
        flag = "0";
      }else {
        if (int.parse(
            _oderDetailssnapshot.data!.data!.staffStatus.toString()) >= int.parse(user.staffOrderStatusId.toString())) {
          flag = "1";
        } else {
          flag = "0";
        }
      }


      //  OrderStaffStatusFlag(_oderDetailssnapshot.data!.data!.staffStatus);

      widgets.add(Step(
          title: Row(
            children: [
              buttonService(
                user.image!,
                user,
                flag,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name!,
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          //        color: int.parse(flag) >= 1 ? Colors.grey : int.parse(flag) == 0 ? AppColor.greenColor : AppColor.appColor,
                          color: int.parse(flag) == 1 ? Colors.green : Colors.grey,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          state: int.parse(flag) > 0 ? StepState.complete : StepState.disabled,
          isActive: int.parse(flag) > 0,
          content: Container()));
    }

    return widgets;
  }


  Widget buttonService(String images, StepData user,String _flag) {
    return Container(
        padding: EdgeInsets.all(6.w),
        decoration: BoxDecoration(
            color: int.parse(_flag) == 0
                ? Colors.grey
                : int.parse(_flag) == 1
                ? Colors.green
                : Colors.green,
            shape: BoxShape.circle),
        child: Image.network(
          images,
          height: 20.h,
        )
      /*   Image.asset(
        'images/quad_bike.png',
        height: 30.h,
        width: 30.w,
      ),*/
    );
  }

  Widget orderId() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.w),
        Padding(
          padding: EdgeInsets.only(left: 10.w,right: 10.w),
          child: Text(
            'OrderId #${widget.displayId}',
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                color: AppColor.greyColor1,
                fontSize: 14.sp,
              ),
            ),
          ),
        ),
        Divider(color: AppColor.greyColor1.withOpacity(0.5)),
      ],
    );
  }

  Widget otherDetail(AsyncSnapshot<OrderDetailsModel> oderDetailssnapshot) {
    return Padding(
      padding: EdgeInsets.only(left: 12.w, right: 12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Translation.of(context)!.translate('Order Value')!,
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    color: AppColor.appColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                "SAR ${oderDetailssnapshot.data!.data!.totalAmount}",
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    color: AppColor.appColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Translation.of(context)!.translate('Payment Mode')!,
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    color: AppColor.appColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),


              oderDetailssnapshot.data!.data!.paymentMode=='cash'?

              Text(
                'Pay On Delivery',
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    color: AppColor.greyColor1,
                    fontSize: 14.sp,
                  ),
                ),
              ):Text(
                'Pay via online',
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    color: AppColor.greyColor1,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Translation.of(context)!.translate('PickUp Location')!,
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    color: AppColor.appColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Text(
                oderDetailssnapshot.data!.data!.pickupAddress.toString(),
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    color: AppColor.greyColor1,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Translation.of(context)!.translate('Vehicle Name')!,
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    color: AppColor.appColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Text(
                oderDetailssnapshot.data!.data!.brand!.name.toString(),
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    color: AppColor.greyColor1,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Translation.of(context)!.translate('Vehicle Size')!,
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    color: AppColor.appColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Text(
                oderDetailssnapshot.data!.data!.carSize!.sizeName.toString()+" - "+oderDetailssnapshot.data!.data!.year!.yearName.toString(),
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    color: AppColor.greyColor1,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Translation.of(context)!.translate('selecttimeslot')!,
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    color: AppColor.appColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),

              Directionality(
                textDirection: UI.TextDirection.ltr,
                child:   Text(
                  oderDetailssnapshot.data!.data!.timeslotId!.toString(),locale: Locale('eng'),
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      color: AppColor.greyColor1,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),

            ],
          ),
          SizedBox(height: 15.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(Translation.of(context)!.translate('packagename')!,
                style: GoogleFonts.montserrat(

                  textStyle: TextStyle(
                    color: AppColor.appColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Text(
                oderDetailssnapshot.data!.data!.package!.packageName.toString(),
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    color: AppColor.greyColor1,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Translation.of(context)!.translate('packageservicedetails')!,
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    color: AppColor.appColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(

                height: 2.h,
              ),
              oderDetailssnapshot.data!.data!.package!.packageServices!.isNotEmpty?Column(

                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: packageServiceList(oderDetailssnapshot.data!.data!.package!.packageServices!),
              ):Text("No Package Service Added", style: GoogleFonts.montserrat(
                  textStyle: TextStyle( color: AppColor.redColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,)),),
            ],
          ),
          SizedBox(height: 15.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Translation.of(context)!.translate('extraservicedetails')!,
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    color: AppColor.appColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),

              SizedBox(

                height: 2.h,
              ),
              oderDetailssnapshot.data!.data!.extraService!.isNotEmpty?Column(

                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: extraPackageServiceList(oderDetailssnapshot.data!.data!.extraService!),
              ):Text(Translation.of(context)!.translate('No Extra Service Added')!, style: GoogleFonts.montserrat(
                  textStyle: TextStyle( color: AppColor.redColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,)),),





            ],
          ),
        ],
      ),
    );
  }

  OrderStaffStatusFlag(String stuffStatus) {
    if (stuffStatus == "1") {
      flag = "1";
    }else if(stuffStatus == "2"){
      flag = "1";
    }else if(stuffStatus == "3"){
      flag = "1";
    }
    else if(stuffStatus == "4"){
      flag = "1";
    }
    else if(stuffStatus == "5"){
      flag = "1";
    }
    else if(stuffStatus == "6"){
      flag = "1";
    }
    else if(stuffStatus == "7"){
      flag = "1";
    }else if(stuffStatus == "8"){
      flag = "1";
    }else{
      flag = "0";
    }
  }
}



List<Widget> extraPackageServiceList(List<PackageServices> list) {
  List<Widget> widgets = [];
  for (PackageServices serviceData in list) {
    widgets.add(

      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Flexible(child: Text(
            serviceData.serviceName.toString(),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: GoogleFonts.montserrat(
                textStyle: TextStyle(

                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                )),
          )),

        ],
      ),

    );
  }
  return widgets;
}

List<Widget> packageServiceList(List<PackageServices> packageServices) {
  List<Widget> widgets = [];
  for (PackageServices serviceData in packageServices) {
    widgets.add(

      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            serviceData.serviceName.toString(),
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





