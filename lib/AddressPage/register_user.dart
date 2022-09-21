


import 'dart:ffi';

import 'package:famous_steam_user/IntroPage/Otp_verify_page.dart';
import 'package:famous_steam_user/Repository/repository.dart';
import 'package:famous_steam_user/const/all_direction_navigator.dart';
import 'package:famous_steam_user/const/colors.dart';
import 'package:famous_steam_user/const/global.dart';
import 'package:famous_steam_user/const/maps_utils/address_autocomplete_search.dart';
import 'package:famous_steam_user/const/maps_utils/place_picker.dart';

import 'package:famous_steam_user/const/prefKeys.dart';
import 'package:famous_steam_user/const/textfieldData.dart';
import 'package:famous_steam_user/model/check_mob_otp_model.dart';
import 'package:famous_steam_user/model/register_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../IntroPage/enter_mobile_no_page.dart';



class RegisterUser extends StatefulWidget {
  const RegisterUser(this.mbltext, {Key? key}) : super(key: key);
  final String? mbltext;
  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController fullnameController = TextEditingController();
  FocusNode fullnameNodes = FocusNode();

  TextEditingController nameArabicController = TextEditingController();
  FocusNode nameArabicNodes = FocusNode();

  TextEditingController mobileNoController = TextEditingController();
  FocusNode mobileNonode = FocusNode();
  TextEditingController addline1Controller = TextEditingController();
  FocusNode addlineNodes = FocusNode();
  TextEditingController cityController = TextEditingController();
  FocusNode cityNodes = FocusNode();
  TextEditingController emailController = TextEditingController();
  FocusNode emailNodes = FocusNode();
  final repository = Repository();
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  LatLng? currentPosition;

  final userstr =
  PrefObj.preferences!.containsKey(PrefKeys.TOKEN) ? true : false;

  String myInputLocation ="";
  String latitude ="";
  String longitude = "";
  List gender=["Male","Female"];
  String selectGenderType ="Male";
  Placemark? lookup;
  @override
  void initState() {
    currentPosition = const LatLng(0.0, 0.0);
    super.initState();
    mobileNoController.text = "+966-"+widget.mbltext.toString();

  }
  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio<String>(
          activeColor: Theme.of(context).primaryColor,
          value: gender[btnValue],
          groupValue: selectGenderType,
          onChanged: (value){
            setState(() {
              // print(value);
              selectGenderType = value.toString();
            });
          },
        ),
        Text(title)
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.lightrgrey,
        body: Padding(
          padding: EdgeInsets.only(left: 18.w, right: 18.w),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30.w),
                  appbarWidget(context, _key),
                  SizedBox(height: 30.w),
                  personalDetailText(),
                  SizedBox(height: 30.w),
                  textField(),
                  SizedBox(height: 50.w),
                  savebutton(),
                  SizedBox(height: 50.w),
                ],
              ),
            ),
          ),
        ));
  }

  double distance = 0.0;

  Position? currentLocation;
  Future<Position> locateUser() async {
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  getUserLocation() async {
    currentLocation = await locateUser();
    setState(() async {
      currentPosition = LatLng(currentLocation!.latitude.isNegative ? 28.556160 : currentLocation!.latitude,
          currentLocation!.longitude.isNegative ? 77.100281 : currentLocation!.longitude);

    });
  }

  Widget textField() {
    return Column(
      children: [
        CustomTextField(
          ontap: (){},
          controller: fullnameController,
          labelText: 'Name English',
          hintText: 'Name English',
          obscureText: false,
          focusNode: fullnameNodes,
          validateName: validateFullName,
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(FocusNode());
          },
        ),
        SizedBox(height: 25.w),
        CustomTextField(
          ontap: (){},
          controller: nameArabicController,
          labelText: 'Name Arabic',
          hintText: 'Name Arabic',
          obscureText: false,
          focusNode: nameArabicNodes,
          validateName: validateFullName,
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(FocusNode());
          },
        ),
        SizedBox(height: 25.w),
        CustomTextField(
          ontap: (){},
          enableDisable: false,
          controller: mobileNoController,
          labelText: 'Mobile',
          hintText: 'Mobile',
          obscureText: false,
          focusNode: mobileNonode,
          validateName: validateFullName,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(FocusNode());
          },
        ),
        SizedBox(height: 20.w),
        CustomTextField(
          ontap: (){},
          controller: emailController,
          labelText: 'Email',
          hintText: 'Email',
          obscureText: false,
          focusNode: addlineNodes,
          validateName: validateEmail,
          textInputAction: TextInputAction.done,

          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(FocusNode());
          },
        ),
        SizedBox(height: 20.w),

        Container(
          margin: const EdgeInsets.fromLTRB(0, 15, 50, 00),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Gender*',
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: addRadioButton(0, 'Male'),
                  ),
                  Expanded(

                    child: addRadioButton(1, 'Female'),
                  ),


                ],
              ),


            ],
          ),
        ),

        SizedBox(height: 25.w),
        PlacePicker(
          apiKey: "AIzaSyC2x2tslPSu9ewNvPZP1rp_i2MP0a-dfD8",
          initialPosition: currentPosition!,
          onAutoCompleteFailed: (value) {
            setState(() {});},
          onPlacePicked: (value) {
            //  print("PlacePicked"+value.adrAddress.toString());
          },
          automaticallyImplyAppBarLeading: true,
          onPicked: (result) async {

            List placemarks = await placemarkFromCoordinates(result.location.lat, result.location.lng);

            longitude = result.location.lng.toString();
            latitude = result.location.lat.toString();
            Placemark place = placemarks[0];
            lookup = place;
            print(place);

            myInputLocation = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
            setState(()  {
            });

          },
        ),


      ],
    );
  }


  Widget personalDetailText() {
    return Text(
      "Personal Details",
      style: GoogleFonts.montserrat(
          textStyle: TextStyle(
            color: AppColor.greyColor1,
            fontWeight: FontWeight.w500,
            fontSize: 15.sp,
          )),
    );
  }

  Widget savebutton() {
    return GestureDetector(
      onTap: () {
        if (formKey.currentState!.validate()) {
          onRegisterAPI();
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
            'Continue',
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

  String? validatevalidAddress1(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Filled Address Line1';
    }
    return null;
  }

  String? validateCity(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Filled City';
    }
    return null;
  }

  String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Enter Your Full Name';
    } else if (value.length < 3) {
      return 'Name must be more than 2 charater';
    } else {
      return null;
    }
  }



  String? validateEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return 'Enter Valid Email';
    } else {
      return null;
    }
  }

  dynamic onRegisterAPI() async {


    print("address=>" +myInputLocation);

    /*
         'first_name' => 'required',
            'last_name' => 'required',
            'email' => 'required|email|unique:users',
            'country_code' => 'required',
            'mobile' => 'required|unique:users|numeric',
            'add_line1' => 'required',
            'add_line2' => 'required',
            'city' => 'required',
            'landmark' => 'required',
            'zipcode' => 'required',*/

    if(myInputLocation!="") {
      if (latitude != "") {

        Loader().showLoader(context);
        final RegisterModel isRegister = await repository.onRegister(
          fullnameController.text,
          nameArabicController.text,
          emailController.text,
          '+966',
          widget.mbltext!,
          myInputLocation,
          selectGenderType,
          "",
          "",
          "",
          latitude,
          longitude,
          lookup!,
        );


        if (isRegister.accessToken == null) {
          Loader().hideLoader(context);
          showRedSnackBar(context, isRegister!.errors!.email![0].toString());
        }
        else if (isRegister.accessToken!.isNotEmpty) {
          FocusScope.of(context).requestFocus(FocusNode());
          PrefObj.preferences!.put(PrefKeys.TOKEN, isRegister.accessToken);
          onSendOtpApi();
          //   NavigatorAnimation(context, IntroPage3('', widget.mbltext),).navigateFromRight();       /* IntroPage1(), */
        }
        else {
          Loader().hideLoader(context);
          showRedSnackBar(context, isRegister.message.toString());
        }
      }else{
        showRedSnackBar(context, 'Kindly Add your valid address!');
      }
    }
    else{
      showRedSnackBar(context, 'Kindly Add your current address!');
    }

  }

  dynamic onSendOtpApi() async {
    final CheckMobileModel isOtp = await repository.onSendOTP(widget.mbltext.toString());
    Loader().hideLoader(context);

    if(isOtp.status!){
      NavigatorAnimation(context, IntroPage3(isOtp.token,widget.mbltext.toString())).navigateFromRight();
    }


  }


}
