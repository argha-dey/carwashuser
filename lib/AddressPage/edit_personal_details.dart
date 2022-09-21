import 'dart:convert';
import 'dart:io';

import 'package:famous_steam_user/IntroPage/Otp_verify_page.dart';
import 'package:famous_steam_user/Repository/repository.dart';
import 'package:famous_steam_user/const/colors.dart';
import 'package:famous_steam_user/const/config.dart';
import 'package:famous_steam_user/const/global.dart';
import 'package:famous_steam_user/const/prefKeys.dart';
import 'package:famous_steam_user/const/textfieldData.dart';
import 'package:famous_steam_user/model/register_model.dart';
import 'package:famous_steam_user/setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import '../const/all_direction_navigator.dart';
import '../const/maps_utils/autocomplete_search.dart';
import '../model/get_user_model.dart';
import 'package:http/io_client.dart';
class EditPersonalDetails extends StatefulWidget {
  EditPersonalDetails({Key? key, required this.getuserModel})
      : super(key: key);
  final GetuserModel getuserModel;
  @override
  State<EditPersonalDetails> createState() => _EditPersonalDetailsState();
}

class _EditPersonalDetailsState extends State<EditPersonalDetails> {
  DateTime initialdate = DateTime.now();
  DateTime selectedDate = DateTime.now();
  List gender=["Male","Female"];
  String selectGenderType ="Male";

  List maratialstatus=["Unmarried","Married"];
  String selectmaratialStatus ="Unmarried";

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController fullnameController = TextEditingController();
  FocusNode fullnameNodes = FocusNode();

  TextEditingController lastnameController = TextEditingController();
  FocusNode lastnameNodes = FocusNode();

  TextEditingController mobileNoController = TextEditingController();
  FocusNode mobileNodes = FocusNode();

  TextEditingController emailController = TextEditingController();
  FocusNode emailNodes = FocusNode();


  TextEditingController nameArabicController = TextEditingController();
  FocusNode nameArabicNodes = FocusNode();

  TextEditingController dateOfBirthController = TextEditingController();
  FocusNode dateOfBirthNodes = FocusNode();

  TextEditingController nationilityController = TextEditingController();
  FocusNode nationilityNodes = FocusNode();

  final repository = Repository();

  LatLng? currentPosition;
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    currentPosition = const LatLng(0.0, 0.0);
    emailController = TextEditingController(text: widget.getuserModel.data!.email!);
    fullnameController = TextEditingController(text: widget.getuserModel.data!.nameEng);
    mobileNoController = TextEditingController(text: widget.getuserModel.data!.mobile!);
    nameArabicController = TextEditingController(text: widget.getuserModel.data!.nameAr!);
    nationilityController = TextEditingController(text: widget.getuserModel.data!.nationality);
    dateOfBirthController = TextEditingController(text: widget.getuserModel.data!.dob);
    selectmaratialStatus = widget.getuserModel.data!.martialStatus == null ? "Unmarried" :widget.getuserModel.data!.martialStatus;
    selectGenderType = widget.getuserModel.data!.gender == null ? "Male" :widget.getuserModel.data!.gender;
    super.initState();
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

/*  getUserLocation() async {
    currentLocation = await locateUser();
    setState(() {
      currentPosition = LatLng(
          currentLocation!.latitude.isNegative
              ? 28.556160
              : currentLocation!.latitude,
          currentLocation!.longitude.isNegative
              ? 77.100281
              : currentLocation!.longitude);
    });
  }*/





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


/*        SizedBox(height: 25.w),
        CustomTextField(
          controller: lastnameController,
          labelText: 'Last Name',
          hintText: 'Last Name',
          obscureText: false,
          focusNode: lastnameNodes,
          validateName: validateLastName,
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(FocusNode());
          },
        ),*/
        SizedBox(height: 25.w),
        CustomTextField(
          ontap: (){},
          enableDisable: false,
          controller: mobileNoController,
          labelText: 'Mobile',
          hintText: 'Mobile',
          obscureText: false,
          focusNode: mobileNodes,
          validateName: validateMobile,
          textInputAction: TextInputAction.done,

          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(FocusNode());
          },
        ),
        SizedBox(height: 25.w),
        CustomTextField(
          ontap: (){},
          enableDisable: false,
          controller: emailController,
          labelText: 'Email',
          hintText: 'Email',
          obscureText: false,
          focusNode: emailNodes,
          validateName: validateEmail,
          textInputAction: TextInputAction.done,

          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(FocusNode());
          },
        ),
        SizedBox(height: 25.w),


        CustomTextField(
          ontap: ()async{
            FocusScope.of(context).unfocus();
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
              firstDate: DateTime(1950),
              lastDate: DateTime(2030),
            );
            setState(() {
              initialdate = picked!;
              dateOfBirthController = TextEditingController(text: DateFormat('yyyy/MM/dd').format(initialdate).toString());
            });
          },
          controller: dateOfBirthController,
          labelText: 'Date Of Birth',
          hintText: 'yyyy-mm-dd',
          obscureText: false,
          focusNode: dateOfBirthNodes,
          validateName: validateFullName,

          textInputAction: TextInputAction.next,
          onFieldSubmitted: (value) {
            FocusScope.of(context).unfocus();
          },

        ),

        SizedBox(height: 20.w),

        Container(
          margin: const EdgeInsets.fromLTRB(0, 15, 50, 00),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Gender',
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
        SizedBox(height: 20.w),
        CustomTextField(
          ontap: (){},
          controller: nationilityController,
          labelText: 'Nationality',
          hintText: 'Nationality',
          obscureText: false,
          focusNode: nationilityNodes,
          validateName: validateFullName,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
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
                'Martial Status',
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: addRadioButtonMatarial(0, 'Unmarried'),
                  ),
                  Expanded(

                    child: addRadioButtonMatarial(1, 'Married'),
                  ),


                ],
              ),


            ],
          ),
        ),
      ],
    );

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
  Row addRadioButtonMatarial(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio<String>(
          activeColor: Theme.of(context).primaryColor,
          value: maratialstatus[btnValue],
          groupValue: selectmaratialStatus,
          onChanged: (value){
            setState(() {
              // print(value);
              selectmaratialStatus = value.toString();
            });
          },
        ),
        Text(title)
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
          onEditPersonalDetailsAPI();
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
            'Save',
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

  String? validateLastName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Enter Your Last Name';
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


  String? validateMobile(String? value) {

    if (!value!.isNotEmpty) {
      return 'Enter Valid Mobile';
    } else {
      return null;
    }
  }



  // Product Delete from cart
  Future<void> onEditPersonalDetailsAPI() async {


    Loader().showLoader(context);
    final ioc = new HttpClient();
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    final httpTemp = new IOClient(ioc);

    var  url = Uri.parse(Config.apiurl + 'user/${PrefObj.preferences!.get(PrefKeys.USERID)}').toString();

    Map<String, String>  requestHeaders = {
      'Accept-Language': '${PrefObj.preferences!.get(PrefKeys.LANG)}',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${PrefObj.preferences!.get(PrefKeys.TOKEN)}'
    };

    Map<String, dynamic>  requestPostData = {
      'name_eng': fullnameController.text,
      'name_ar': nameArabicController.text,
      "dob": dateOfBirthController.text,
      "gender": selectGenderType,
      "martial_status": selectmaratialStatus,
      "nationality": nationilityController.text,
    };

    Uri myUri = Uri.parse(url);

    var response = await  httpTemp.put(myUri, headers: requestHeaders,body: requestPostData);

    if (Config.isDebug) {
      print('url---- $myUri');
      print('post---- $requestPostData');
      print('requestHeaders---- $requestHeaders');
      print('res---- '+json.decode(response.body).toString());
    }

    dynamic responseJson;
    try {
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        //GetuserModel getuserModel = GetuserModel.fromJson(responseJson);
        Loader().hideLoader(context);
        NavigatorAnimation(
          context,
          SettingPage(),
        ).navigateFromRight();
      }
      else {
        Loader().hideLoader(context);
        showSnackBar(context, "Personal details edit not successfull.");
      }
    }catch (e){
      Loader().hideLoader(context);
      showSnackBar(context, "Personal details edit not successfull.");

    }
  }


  @override
  void dispose() {
    fullnameController.dispose();
    lastnameController.dispose();
    emailController.dispose();
    mobileNoController.dispose();
    print(" ===>  Dispose All ");
    super.dispose();
  }
  void clearControllerText(){
    fullnameController.clear();
    lastnameController.clear();
    mobileNoController.clear();
    emailController.clear();
  }



}
