import 'dart:async';

import 'package:dotted_border/dotted_border.dart';
import 'package:famous_steam_user/ServicePage/select_your_address_page.dart';
import 'package:famous_steam_user/add_Vehicle_Details.dart';
import 'package:famous_steam_user/bloc/vehicle_list_by_cetegory_bloc.dart';
import 'package:famous_steam_user/const/colors.dart';
import 'package:famous_steam_user/const/config.dart';
import 'package:famous_steam_user/const/prefKeys.dart';
import 'package:famous_steam_user/homePage.dart';
import 'package:famous_steam_user/localizations/app_localizations.dart';
import 'package:famous_steam_user/model/vehicle_list_by_cetegory_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../const/all_direction_navigator.dart';
import '../const/global.dart';
/*
class ServiceListBookingStartPage extends StatefulWidget {
  final String packageId;
  final String slotId;
  final String slotDate;
  final Map summary;
  const ServiceListBookingStartPage({
    Key? key,
    required this.packageId,
    required this.slotId,
    required this.slotDate,
    required this.summary,
  }) : super(key: key);

  @override
  State<ServiceListBookingStartPage> createState() =>
      _ServiceListBookingStartPageState();
}

class _ServiceListBookingStartPageState
    extends State<ServiceListBookingStartPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  bool isCheck = false;
  String size = '';
  String sizeId = '';
  String vahicleId = '';
  String vahicleName = '';
  bool isSelected = false;

  final userstr =
      PrefObj.preferences!.containsKey(PrefKeys.TOKEN) ? true : false;

  @override
  void initState() {
    super.initState();
    if (Config.isDebug) {print('page--> ServiceListBookingStartPage');}
    Timer.periodic(
        const Duration(seconds: 10), (Timer t) => getCurrentLocation());
    userstr
        ? vehiclelbrandlistbycategorybloc.vehiclelbrandlistbycategorysink(
            'eng', iscategoryid.toString())
        : loginButton(context);
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
      body: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              selectYourCar(),
              SizedBox(height: 20.w),
              Column(
                children: [
                  userstr
                      ? Container()
                      : Center(
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
                  userstr
                      ? Column(
                          children: [
                            radioButton(),
                            SizedBox(height: 20.w),
                            anotherCarText(),
                            SizedBox(height: 30.w),
                            continueBookingButton(),
                          ],
                        )
                      : loginButton(context)
                ],
              ),
              SizedBox(height: 20.w),
              carSize(),
              SizedBox(height: 20.w),
            ],
          ),
        ),
      ),
    );
  }

  Widget selectYourCar() {
    return Text(
      Translation.of(context)!.translate('selectyourvehicle')!,
      style: GoogleFonts.montserrat(
          textStyle: TextStyle(
        fontSize: 16.sp,
      )),
    );
  }

  List<Vehicleslist>? users;
  Vehicleslist? selectedUser;
  int? selectedRadio;
  int? selectedRadioTile;

  setSelectedUser(Vehicleslist user) {
    setState(() {
      selectedUser = user;
    });
  }

  List<Widget> createRadioListUsers() {
    List<Widget> widgets = [];
    for (Vehicleslist user in users!) {
      widgets.add(Column(
        children: [
          const SizedBox(height: 5),
          Container(
            decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.circular(3),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 1.0,
                ),
              ],
            ),
            child: Row(
              children: [
                Radio<Vehicleslist>(
                  value: user,
                  groupValue: selectedUser,
                  onChanged: (Vehicleslist? currentUser) {
                    print("Current User ${currentUser!.sizeId!}");
                    setSelectedUser(currentUser);
                    isSelected = true;
                    size = currentUser.size.toString();
                    sizeId = currentUser.sizeId.toString();
                    vahicleId = currentUser.id.toString();
                    vahicleName = currentUser.brand!;
                  },
                  activeColor: AppColor.appColor,
                ),
                Text(
                  user.brand!,
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                    fontSize: 14.sp,
                  )),
                )
              ],
            ),
          ),
          const SizedBox(height: 5),
        ],
      ));
    }
    return widgets;
  }

  Widget radioButton() {
    return StreamBuilder<VehiclelbrandlistbycategoryModel>(
      stream: vehiclelbrandlistbycategorybloc.vehiclelistbycategorystream,
      builder: (context,
          AsyncSnapshot<VehiclelbrandlistbycategoryModel>
              vehiclelistbycategorysnapshot) {
        if (!vehiclelistbycategorysnapshot.hasData) {
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
        users = vehiclelistbycategorysnapshot.data!.vehicles;
        return Column(
          children: createRadioListUsers(),
        );
      },
    );
  }

  Widget anotherCarText() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isCheck = !isCheck;
        });
        NavigatorAnimation(
          context,
          AddVehicleDetails(
            screenType: ScreenType.add,
            isBack: (value) {
              vehiclelbrandlistbycategorybloc.vehiclelbrandlistbycategorysink(
                  'eng', iscategoryid.toString());
            },
          ),
        ).navigateFromRight();
      },
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(12),
        child: Row(
          children: [
            MaterialButton(
              height: 25.w,
              color: AppColor.appColor,
              onPressed: () {},
              child: Icon(
                CupertinoIcons.add,
                size: 15.h,
                color: Colors.white,
              ),
              shape: const CircleBorder(),
            ),
            Text(
              Translation.of(context)!.translate('addanothervehicle')!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColor.appColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget carSize() {
    return isSelected
        ? Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.w),
                color: AppColor.whiteColor,
                // ignore: prefer_const_literals_to_create_immutables
                boxShadow: [
                  const BoxShadow(
                    color: Colors.grey,
                    blurRadius: 3.0,
                  ),
                ]),
            child: ExpansionTile(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      size,
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                        color: AppColor.appColor,
                        fontSize: 14.sp,
                      )),
                    ),
                  ),
                ),
                SizedBox(height: 10.w),
              ],
              title: Text(
                size,
                style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                  color: AppColor.appColor,
                  fontSize: 14.sp,
                )),
              ),
            ),
          )
        : Container();
  }

  Widget continueBookingButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            {
              Map summary = {
                'serviceName': widget.summary['serviceName'],
                'serviceType': widget.summary['serviceType'],
                'cost': widget.summary['cost'],
                'slot': widget.summary['slot'],
                'vehicle': vahicleName,
                'size': size,
              };
              NavigatorAnimation(
                  context,
                  SelectyouraddressPage(
                    packageId: "",
                    sizeId: "",
                    slotDate: "",
                    slotId: "",
                    vehicalId: "",
                    size: size,
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
                Translation.of(context)!.translate('continuebooking')!,
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
}*/
