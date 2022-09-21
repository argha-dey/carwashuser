// ignore_for_file: deprecated_member_use

import 'package:famous_steam_user/AddressPage/register_user.dart';
import 'package:famous_steam_user/IntroPage/Otp_verify_page.dart';
import 'package:famous_steam_user/IntroPage/intro_page_5.dart';
import 'package:famous_steam_user/Repository/repository.dart';
import 'package:famous_steam_user/const/all_direction_navigator.dart';
import 'package:famous_steam_user/const/colors.dart';
import 'package:famous_steam_user/const/global.dart';
import 'package:famous_steam_user/const/prefKeys.dart';
import 'package:famous_steam_user/model/check_mob_otp_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scoped_model/scoped_model.dart';

import '../localizations/language_model.dart';
import 'enter_mobile_no_page.dart';

class IntroPage4 extends StatefulWidget {
  const IntroPage4({Key? key}) : super(key: key);

  @override
  State<IntroPage4> createState() => _IntroPage4State();
}

class _IntroPage4State extends State<IntroPage4> {
  String? selectedValue;
  LangModel? languageModel;
  TextEditingController otpController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var userstr = PrefObj.preferences!.containsKey(PrefKeys.TOKEN) ? true : false;

  final repository = Repository();
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<LangModel>(builder: (context, child, model) {
      languageModel = model;
      return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            backgroundColor: AppColor.lightrgrey,
            body:     SingleChildScrollView(
              child:Form(
                key: formKey,
                  child: Column(children: [


                    SizedBox(
                      child: Image(
                        image: AssetImage('images/package_image.png'),

                      ),
                    ),


                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Welcome to FAMOUS STEAM",
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              color: AppColor.appColor,
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.w),
                        Text(
                          "Your car wash partner in your area",
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              color: AppColor.appColor,
                              fontSize: 13.sp,
                            ),
                          ),
                        ),
                        Text(
                          "please select your preferred language  ",
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              color: AppColor.appColor,
                              fontSize: 13.sp,
                            ),
                          ),
                        ),

                      ],
                    ),

                    SizedBox(height: 30.h),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [


                        Padding(
                          padding: EdgeInsets.only(left: 20.w, right: 20.w),
                          child: droPDownButton(),
                        ),
                        SizedBox(height: 30.h),

                        Row(
                          children: [

                            Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 10),

                                  child: Image.asset(
                                    'images/saflag.png',
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.fill,
                                  ),

                                ),


                                //TODO:  Country Code

                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 55, top: 2, right: 45),
                                  child: Text(
                                    "+966",
                                    style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                        color: AppColor.appColor,
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),

                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(right: 20.w),
                                child: TextFormField(
                                  maxLength: 9,  // max mobile no
                                  controller: otpController,
                                  validator: validateMobile,
                                  scrollPadding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  keyboardType: TextInputType.number,
                                  style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                      color: AppColor.appColor,
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                  decoration: InputDecoration(
                                    fillColor: AppColor.appColor,
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColor.whiteColor,
                                      ),
                                    ),
                                    hintText: 'Enter your phone number',
                                    hintStyle: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                        color: AppColor.appColor,
                                        fontSize: 15.sp,
                                        height: 1.5.w,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
/*
                         GestureDetector(
                          onTap: () {

                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    "Kindly allow to access this device’s location.",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w300,
                                      color: AppColor.blackColor,
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text(
                                        'DENY',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: AppColor.redColor,
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    SizedBox(width: 135.w),
                                    TextButton(
                                      style: ElevatedButton.styleFrom(),
                                      child: Text(
                                        'ALLOW',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: AppColor.blackColor,
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        NavigatorAnimation(context, const IntroPage1())
                                            .navigateFromRight();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );

                            // NavigatorAnimation(context, const IntroPage5()).navigateFromRight();
                          //  NavigatorAnimation(context, const IntroPage1()).navigateFromRight();
                          },
                          child: Container(
                            margin: const EdgeInsets.all(15),
                            width: double.infinity,
                            height: 40.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3.0),
                              gradient: const LinearGradient(
                                begin: Alignment(0.0, -0.95),
                                end: Alignment(0.0, 1.0),
                                colors: [
                                  Colors.white,
                                  Color(0xff0484E0),
                                ],
                                stops: [0.0, 1.0],
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Next',
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.appColor,
                                    fontSize: 18.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),*/
                      ],
                    ),
                    SizedBox(height: 30.h),
                    GestureDetector(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  "Kindly allow to access this device’s location.",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w300,
                                    color: AppColor.blackColor,
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text(
                                      'DENY',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: AppColor.redColor,
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  SizedBox(width: 135.w),
                                  TextButton(
                                    style: ElevatedButton.styleFrom(),
                                    child: Text(
                                      'ALLOW',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: AppColor.blackColor,
                                      ),
                                    ),
                                    onPressed: () {
                                      onSendOtpApi();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },


                      child: Container(
                        margin: const EdgeInsets.all(15),
                        width: double.infinity,
                        height: 40.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.0),
                          gradient: const LinearGradient(
                            begin: Alignment(0.0, -0.95),
                            end: Alignment(0.0, 1.0),
                            colors: [
                              Colors.white,
                              Color(0xff0484E0),
                            ],
                            stops: [0.0, 1.0],
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Next',
                            style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: AppColor.appColor,
                                fontSize: 18.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 10.h),
                  ])
              ),
                ),
          ));
    });
  }

  Widget droPDownButton() {
 //   PrefObj.preferences!.put(PrefKeys.LANG, 'eng');
    return DropdownButton<String>(
      focusColor: AppColor.appColor,
      value: selectedValue,
      style: GoogleFonts.montserrat(
        textStyle: TextStyle(
          color: AppColor.appColor,
          fontSize: 12.sp,
        ),
      ),
      alignment: Alignment.centerRight,
      iconEnabledColor: AppColor.appColor,
      isExpanded: true,

      dropdownColor: AppColor.greyColor,
      items: <String>['English', 'Arabic'].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                color: AppColor.appColor,
                fontSize: 13.sp,
              ),
            ),
          ),
        );
      }).toList(),
      hint: Text(
        "English",
        style: GoogleFonts.montserrat(
          textStyle: TextStyle(
            color: AppColor.appColor,
            fontSize: 12.sp,
          ),
        ),
      ),

      onChanged: (String? value) {
        setState(() {
          selectedValue = value;
          if (value == 'English') {
            PrefObj.preferences!.put(PrefKeys.LANG, 'eng');
            languageModel!.changeLanguage('en');
          } else {
            PrefObj.preferences!.put(PrefKeys.LANG, 'ar');
            languageModel!.changeLanguage('ar');
          }
        });
      },

    );
  }

  void showpopDialog(BuildContext context, String title, String body) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(body),
          actions: <Widget>[
            FlatButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  String? validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Enter Your Mobile Number';
    } else if (value.length != 9) {
      return 'Mobile Number must be of 9 digit';
    }
    return null;
  }
  dynamic onSendOtpApi() async {
    // show loader
    Loader().showLoader(context);
    final CheckMobileModel isOtp = await repository.onSendOTP(
      otpController.text,
    );
    Loader().hideLoader(context);

    if(isOtp.status!){
      // PrefObj.preferences!.put(PrefKeys.TOKEN, isOtp.token);
      //   PrefObj.preferences!.put(PrefKeys.USERID, "2");
      NavigatorAnimation(context, IntroPage3(isOtp.token, otpController.text))
          .navigateFromRight()
          .then((value) {
        setState(() {
          userstr = PrefObj.preferences!.containsKey(PrefKeys.TOKEN) ? true : false;
        });
      });


    }else if(!isOtp.status!){


// For Testing
/*      PrefObj.preferences!.put(PrefKeys.TOKEN, "15|JJdXH1rFQ4TVBF5Fg2XgW64WtIfdqk5CCyXfxrYF");
      NavigatorAnimation(context, IntroPage3(isOtp.otp,otpController.text))
          .navigateFromRight()
          .then((value) {
        setState(() {
          userstr = PrefObj.preferences!.containsKey(PrefKeys.TOKEN) ? true : false;
        });
      });*/

      final snackBar = SnackBar(
          content: Text(isOtp.message.toString()+".Kindly Register",
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);


      PrefObj.preferences!.clear();
      NavigatorAnimation(context, RegisterUser(otpController.text))
          .navigateFromRight();
      setState(() {});

    }else{
      showpopDialog(context, 'Error!','Some thing wrong! Please try after some time.');
    }

/*
    if (isOtp.status == '0') {
      showpopDialog(
          context, 'Error', isOtp.message != null ? isOtp.message! : '');
    } else if (isOtp.status == '1') {
      if (isOtp.otp == 0) {
        PrefObj.preferences!.put(PrefKeys.TOKEN, isOtp.token);
        FocusScope.of(context).requestFocus(FocusNode());

        NavigatorAnimation(context, IntroPage3(isOtp.otp)).navigateFromRight();
      } else {
        PrefObj.preferences!.clear();
        NavigatorAnimation(context, RegisterUser(otpController.text))
            .navigateFromRight();

        setState(() {});
      }
    } else if (isOtp.status == '2') {
      PrefObj.preferences!.put(PrefKeys.TOKEN, isOtp.token);
      NavigatorAnimation(context, IntroPage3(isOtp.otp))
          .navigateFromRight()
          .then((value) {
        setState(() {
          userstr =
              PrefObj.preferences!.containsKey(PrefKeys.TOKEN) ? true : false;
        });
      });
    }*/

  }
}
