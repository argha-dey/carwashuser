import 'dart:async';

import 'package:dotted_border/dotted_border.dart';
import 'package:famous_steam_user/Repository/repository.dart';
import 'package:famous_steam_user/ServicePage/service_list_booking_summary.dart';
import 'package:famous_steam_user/bloc/getadderss_bloc.dart';
import 'package:famous_steam_user/bloc/vehicle_list_bloc.dart';
import 'package:famous_steam_user/const/all_direction_navigator.dart';
import 'package:famous_steam_user/const/colors.dart';
import 'package:famous_steam_user/const/config.dart';
import 'package:famous_steam_user/homePage.dart';
import 'package:famous_steam_user/localizations/app_localizations.dart';
import 'package:famous_steam_user/model/SummeryModel.dart';
import 'package:famous_steam_user/model/get_address_model.dart';
import 'package:famous_steam_user/model/package_index_model.dart';
import 'package:famous_steam_user/model/vehicle_list_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../AddressPage/add_address_page.dart';
import '../const/global.dart';

class SelectyouraddressPage extends StatefulWidget {
  const SelectyouraddressPage({
    Key? key,
    required this.selectedPackageData,
    required this.selectedExtraServiceData,
    required this.selectedvahicleDetails,
    required this.slotDate,
    required this.slotTime,
  }) : super(key: key);
  final PackageData selectedPackageData;
  final  List<ServiceListData> selectedExtraServiceData;
  final VehicleDetails selectedvahicleDetails;
  final String slotDate;
  final String slotTime;


  @override
  State<SelectyouraddressPage> createState() => _SelectyouraddressPageState();
}

class _SelectyouraddressPageState extends State<SelectyouraddressPage> {
  bool isCheck = false;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  String address = '';
  String addressId = '';
  final repository = Repository();
  bool  addAddressVisible = true;

  @override
  void initState() {
    super.initState();
    if (Config.isDebug) {print('page--> SelectyouraddressPage');}

    /* Timer.periodic(const Duration(seconds: 10), (Timer t) => getCurrentLocation());*/
    vehicleListbloc.categorylistsink('eng');
    getadderssbloc.getaddresssink();
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
      body: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.w),
              selectYourAddress(),
              SizedBox(height: 20.w),
              radioButton(),
              SizedBox(height: 20.w),
              anotherCarText(),
              SizedBox(height: 20.w),
              SizedBox(height: 20.w),
              continueBookingButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget selectYourAddress() {
    return Text(
      Translation.of(context)!.translate('selectyouraddress')!,
      style: GoogleFonts.montserrat(
          textStyle: TextStyle(
            fontSize: 16.sp,
          )),
    );
  }

  List<GetAddressdata>? users = [];
  GetAddressdata? selectedUser;
  int? selectedRadio;
  int? selectedRadioTile;

  setSelectedUser(GetAddressdata user) {
    setState(() {
      selectedUser = user;
    });
  }

  List<Widget> createRadioListUsers() {
    List<Widget> widgets = [];
    int numberOfAddressCount = 0;
    for (GetAddressdata user in users!) {



      if(numberOfAddressCount<3) {
        numberOfAddressCount = numberOfAddressCount + 1;
        widgets.add(Column(
          children: [
            const SizedBox(height: 20),
            Container(
              alignment: Alignment.topLeft,
              child: Text(

                getAddressType(numberOfAddressCount),
                style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      color: AppColor.appColor,
                      fontSize: 16.sp,
                    )),
              ),
            ),
            const SizedBox(height: 8),
            Container(
                decoration: BoxDecoration(


                  boxShadow: const [
                  ],
                ),
                child: Row(
                  children: [
                    Radio<GetAddressdata>(
                      value: user,
                      groupValue: selectedUser,
                      onChanged: (GetAddressdata? currentUser) {
                        print("Current User ${currentUser!.address!}");
                        setSelectedUser(currentUser);
                        address = currentUser.address.toString();
                        addressId = currentUser.id.toString();
                      },
                      activeColor: AppColor.appColor,
                    ),
                    Expanded(
                      child: Text(
                        user.address!,
                        style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              fontSize: 14.sp,
                            )),
                      ),
                    )
                  ],
                )


            ),
            const SizedBox(height: 5),
          ],
        ));
      }

    }
    return widgets;
  }

  Widget radioButton() {
    return StreamBuilder<GetaddressModel>(
      stream: getadderssbloc.getaddresstream,
      builder: (context, AsyncSnapshot<GetaddressModel> getaddresssnapshot) {
        if (!getaddresssnapshot.hasData) {
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
        users = getaddresssnapshot.data!.data;
        users!.length<3 ? addAddressVisible = true : addAddressVisible = false;


        return Column(
          children: createRadioListUsers(),
        );
      },
    );
  }

  Widget anotherCarText() {
    return  Visibility(
      visible: addAddressVisible,
       child: GestureDetector(
      onTap: () {

        if(addAddressVisible) {
          NavigatorAnimation(
            context,
            const AddAddressPage(),
          ).navigateFromRight().then((value) =>
              getadderssbloc.getaddresssink());
        }else{
          showSnackBar(context,"You can add only 3 preferable address!");
        }
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
              Translation.of(context)!.translate('addnewaddress')!,
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
    ),
    );
  }

  Widget continueBookingButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            if (selectedUser == null) {
              final snackBar = SnackBar(
                  content: Text(
                    "Please Select Your Address...!",
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else {
              NavigatorAnimation(
                context,
                ServiceListbookingSummery(
                  selectedPackageData: widget.selectedPackageData,
                  selectedExtraServiceData: widget.selectedExtraServiceData,
                  selectedvahicleDetails: widget.selectedvahicleDetails,
                  slotDate: widget.slotDate,
                  slotTime: widget.slotTime,
                  addressId: addressId,
                  address: address,
                ),
              ).navigateFromRight();

              //  getOrderValue();

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
                Translation.of(context)!.translate('confirmaddress')!,
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

  String getAddressType(int index) {
    var type ='';
    if(index ==1){
      type = Translation.of(context)!.translate('Home Address')!;
    }else if(index ==2){
      type =  Translation.of(context)!.translate('Office Address')!;
    }else{
      type =  Translation.of(context)!.translate('Others')!;
    }
    return type;
  }

/*
  dynamic getOrderValue() async {

    // show loader
    Loader().showLoader(context);
    final SummeryModel summeryModel = await repository.onSummaryDetailsApi(
      widget.selectedPackageData,
      widget.selectedExtraServiceData,
      widget.selectedvahicleDetails,
      widget.slotTime,
      widget.slotDate,
      addressId,
    );


    if(summeryModel.package!.packagePrice!.isNotEmpty) {
      FocusScope.of(context).requestFocus(FocusNode());
      Loader().hideLoader(context);



    }
  }*/
}
