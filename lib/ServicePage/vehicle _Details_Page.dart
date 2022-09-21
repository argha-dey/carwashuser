import 'dart:convert';
import 'dart:io';

import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:famous_steam_user/IntroPage/enter_mobile_no_page.dart';
import 'package:famous_steam_user/Repository/repository.dart';
import 'package:famous_steam_user/add_Vehicle_Details.dart';
import 'package:famous_steam_user/bloc/vehicle_list_bloc.dart';
import 'package:famous_steam_user/const/all_direction_navigator.dart';
import 'package:famous_steam_user/const/colors.dart';
import 'package:famous_steam_user/const/config.dart';
import 'package:famous_steam_user/const/prefKeys.dart';
import 'package:famous_steam_user/edit_vehicle_page.dart';
import 'package:famous_steam_user/localizations/app_localizations.dart';
import 'package:famous_steam_user/model/delete_vehicle_model.dart';
import 'package:famous_steam_user/model/vehicle_list_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:http/io_client.dart';
import '../const/global.dart';

class VehicalDetailsPage extends StatefulWidget {
  const VehicalDetailsPage({Key? key}) : super(key: key);

  @override
  State<VehicalDetailsPage> createState() => _VehicalDetailsPageState();
}

class _VehicalDetailsPageState extends State<VehicalDetailsPage> {
  final repository = Repository();
  List ImageList = [
    'images/homescreencar.png',
    'images/quad_bike.png',
    'images/shuttle_bus.png'
  ];

  var userstr = false;

  VehicleDetails? vehicleDetails;

  @override
  void initState() {
    super.initState();
    if (Config.isDebug) {print('page--> VehicalDetailsPage');}
    userstr = PrefObj.preferences!.containsKey(PrefKeys.TOKEN) ? true : false;
    if (userstr) {
      vehicleListbloc.categorylistsink('');
    }

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: AppColor.lightrgrey,
        body: Padding(
            padding: EdgeInsets.only(right: 15.w, top: 20.w, left: 18.w),
            child: userstr
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                vehicleText(),
                SizedBox(height: 15.w),
                Expanded(
                  child: Center(
                    child: dataList(),
                  ),
                ),
              ],
            )
                : loginButton(context)),
      ),
    );
  }

  Widget vehicleText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Translation.of(context)!.translate('vehicledetails')!,
          style: GoogleFonts.montserrat(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: AppColor.appColor,
          ),
        ),
        SizedBox(height: 10.w),
        GestureDetector(
          onTap: () {
            setState(() {});
            print("HELLOAOOA");
            NavigatorAnimation(
                context,
                AddVehicleDetails(
                  screenType: ScreenType.add,
                  isBack: (value) {
                    setState(() {
                      vehicleListbloc.categorylistsink('');
                    });
                  },
                )).navigateFromRight();
            setState(() {});
          },
          child: Container(
            padding: EdgeInsets.all(11.w),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: AppColor.appColor.withOpacity(0.5),
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.appColor,
                  ),
                  padding: const EdgeInsets.all(5),
                  child: Icon(
                    CupertinoIcons.add,
                    size: 15.h,
                    color: AppColor.whiteColor,
                  ),
                ),
                SizedBox(width: 10.w),
                Text(
                  Translation.of(context)!.translate('addanothervehicle')!,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: AppColor.appColor),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget dottedLine() {
    return Container(
      height: 10.h,
      decoration: DottedDecoration(
          shape: Shape.line, linePosition: LinePosition.bottom),
    );
  }

  Widget dataList() {
    return StreamBuilder<VehicleListModel>(
        stream: vehicleListbloc.vehicleliststream,
        builder:
            (context, AsyncSnapshot<VehicleListModel> vehiclelistsnapshot) {
          if (!vehiclelistsnapshot.hasData) {
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


          return vehiclelistsnapshot.data!.data!.isEmpty
              ? Center(
            child: Text(
              'No Data Found',
              style: GoogleFonts.montserrat(
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: AppColor.blackColor,
              ),
            ),
          )
              : ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: vehiclelistsnapshot.data!.data!.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  dottedLine(),
                  SizedBox(height: 16.w),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /*          Image.asset(
                              carType(
                                vehiclelistsnapshot.data!.data![index].category!.name.toString(),
                              ),
                              height: 30.h,
                              width: 30.w,
                            ),*/


                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            vehiclelistsnapshot.data!.data![index].brand!.name.toString()+" ( "+ vehiclelistsnapshot.data!.data![index].carModel!.carModelName.toString()+" )",
                            style: GoogleFonts.montserrat(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColor.greyColor1,
                            ),
                          ),
                          SizedBox(height: 5.w),
                          Text(
                            vehiclelistsnapshot.data!.data![index].carSize!.sizeName.toString()+" - "+vehiclelistsnapshot.data!.data![index].year!.yearName.toString(),
                            style: GoogleFonts.montserrat(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColor.greyColor1,
                            ),
                          ),
                          Text(
                            vehiclelistsnapshot.data!.data![index].fuel!.name.toString()+" - "+ vehiclelistsnapshot.data!.data![index].category!.name.toString(),
                            style: GoogleFonts.montserrat(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColor.greyColor1,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 20.w),

                      Row(
                        children: [
                          MaterialButton(
                            minWidth: 30.w,
                            height: 30.h,
                            onPressed: () {
                              NavigatorAnimation(
                                context,
                                  Editvehiclepage(
                                      isBack: (value) {
                                        setState(() {
                                          vehicleListbloc.categorylistsink('');
                                        });
                                      },
                                    screenType: ScreenType.edit,
                                    brandId:vehiclelistsnapshot.data!.data![index].brand!.brandId.toString(),
                                    modelid:vehiclelistsnapshot.data!.data![index].carModel!.carModelId.toString(),
                                    fuelId:vehiclelistsnapshot.data!.data![index].fuel!.fuelId.toString(),
                                    sizeId: vehiclelistsnapshot.data!.data![index].carSize!.carSizeId.toString(),
                                    vehiclesid: vehiclelistsnapshot.data!.data![index].userVehicleId.toString(),
                                    categoryId:vehiclelistsnapshot.data!.data![index].category!.categoryId.toString(),
                                    categoryName:vehiclelistsnapshot.data!.data![index].category!.name.toString(),
                                    sizeName:vehiclelistsnapshot.data!.data![index].carSize!.sizeName.toString(),
                                    modelName:vehiclelistsnapshot.data!.data![index].carModel!.carModelName.toString(),
                                    brandName:vehiclelistsnapshot.data!.data![index].brand!.name.toString(),
                                    fuelName:vehiclelistsnapshot.data!.data![index].fuel!.name.toString(),
                                    yearId: vehiclelistsnapshot.data!.data![index].year!.yearId.toString(),
                                    yearName: vehiclelistsnapshot.data!.data![index].year!.yearName.toString(),
                                  ),


                      /*          AddVehicleDetails(
                                  isBack: (value) {
                                    setState(() {

                                    });
                                  },
                                  screenType: ScreenType.edit,
                                  brandId:vehiclelistsnapshot.data!.data![index].brand!.brandId.toString(),
                                  modelid:vehiclelistsnapshot.data!.data![index].carModel!.carModelId.toString(),
                                  fuelId:vehiclelistsnapshot.data!.data![index].fuel!.fuelId.toString(),
                                  sizeId: vehiclelistsnapshot.data!.data![index].carSize!.carSizeId.toString(),
                                  vehiclesid: vehiclelistsnapshot.data!.data![index].userVehicleId.toString(),
                                  categoryId:vehiclelistsnapshot.data!.data![index].category!.categoryId.toString(),
                                  categoryName:vehiclelistsnapshot.data!.data![index].category!.name.toString(),
                                  sizeName:vehiclelistsnapshot.data!.data![index].carSize!.sizeName.toString(),
                                  modelName:vehiclelistsnapshot.data!.data![index].carModel!.carModelName.toString(),
                                  brandName:vehiclelistsnapshot.data!.data![index].brand!.name.toString(),
                                  fuelName:vehiclelistsnapshot.data!.data![index].fuel!.name.toString(),
                                ),*/
                              ).navigateFromRight();
                            },
                            color: AppColor.whiteColor,
                            textColor: AppColor.blackColor,
                            child: Icon(
                              Icons.edit,
                              color: AppColor.appColor,
                              size: 16.w,
                            ),
                            shape: const CircleBorder(),
                          ),

                          MaterialButton(
                            minWidth: 30.w,
                            height: 30.h,
                            onPressed: () {
                              showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Center(

                                      child: Text(
                                        "Do you want to delete your car?",
                                        style: GoogleFonts.montserrat(
                                            textStyle: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xff128807))),
                                      ),
                                    ),
                                    actions: <Widget>[
                                      Center(
                                        child:Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary: AppColor.appColor,
                                                onPrimary: AppColor.appColor,
                                              ),
                                              child: Text(
                                                'YES',
                                                style: GoogleFonts.montserrat(
                                                    textStyle: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.bold,
                                                        color: AppColor.whiteColor)),
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context, true);
                                                // Call  service list Api
                                                setState(() {
                                                  onDeleteAPI(vehiclelistsnapshot.data!.data![index].userVehicleId.toString());
                                                });
                                              },
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary: AppColor.appColor,
                                                onPrimary: AppColor.appColor,
                                              ),
                                              child: Text(
                                                'NO',
                                                style: GoogleFonts.montserrat(
                                                    textStyle: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.bold,
                                                        color: AppColor.whiteColor)),
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context, true);

                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 100,
                                      ),
                                    ],
                                  );
                                },
                              );

                            },
                            color: Colors.white,
                            textColor: Colors.black,
                            child: Icon(
                              Icons.delete,
                              color: const Color(0xff004471),
                              size: 16.w,
                            ),
                            shape: const CircleBorder(),
                          ),
                        ],
                      ),

                    ],
                  ),
                ],
              );
            },
          );
        });
  }




  // Product Delete from cart
  Future<void> onDeleteAPI(String userVehicleId)async {


    Loader().showLoader(context);
    final ioc = new HttpClient();
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    final httpTemp = new IOClient(ioc);


    var  url = Uri.parse(Config.apiurl + "user-vehicle/"+userVehicleId).toString();

    print('url---- $url');

    Map<String, String>  requestHeaders = {
      'Accept-Language': '${PrefObj.preferences!.get(PrefKeys.LANG)}',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${PrefObj.preferences!.get(PrefKeys.TOKEN)}'
    };


    Uri myUri = Uri.parse(url);
    var response = await  httpTemp.delete(myUri, headers: requestHeaders);
    dynamic responseJson;
    try {


      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        final DeletevehicleModel isdelete =  DeletevehicleModel.fromJson(responseJson);
        Loader().hideLoader(context);
        showSnackBar(context, isdelete.message.toString());
        setState(() {
          vehicleListbloc.categorylistsink('');
        });



      } else {
        Loader().hideLoader(context);
        showSnackBar(context, 'Api response error: ${response.statusCode}.');
      }
    }catch (e){
      Loader().hideLoader(context);
      showSnackBar(context, 'Api data parse issue. status: ${response.statusCode}.');
    }
  }

/*
  dynamic onDeleteAPI(String userVehicleId) async {
    // show loader
    print('vechile Id ---- $userVehicleId');
    Loader().showLoader(context);
    final DeletevehicleModel isdelete = await repository.ondeletvehicle(userVehicleId);

      if (isdelete.message == 'vehicle delete Successfully') {
        FocusScope.of(context).requestFocus(FocusNode());
        Loader().hideLoader(context);
     //   vehicleListbloc.categorylistsink('eng');
        showSnackBar(context, isdelete.message.toString());

    } else {
      Loader().hideLoader(context);
      showSnackBar(context, isdelete.message.toString());
    }
  }*/

  String carType(String type) {
    switch (type) {
      case 'Car':
        return 'images/homescreencar.png';
      case 'Bike':
        return 'images/quad_bike.png';
      case 'Bus':
        return 'images/shuttle_bus.png';
      case 'Truck':
        return 'images/homescreencar.png';
    }
    return 'images/homescreencar.png';
  }

  loginButton(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Translation.of(context)!.translate('vehicledetails')!,
          style: GoogleFonts.montserrat(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: AppColor.appColor,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Center(
          child: Text(
            'Please Login Your Account',
            style: GoogleFonts.montserrat(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColor.blackColor,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const IntroPage1(),
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
            ))
      ],
    );
  }
}
