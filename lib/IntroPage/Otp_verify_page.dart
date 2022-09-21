import 'package:famous_steam_user/Bottombar/bottombar.dart';
import 'package:famous_steam_user/Repository/repository.dart';
import 'package:famous_steam_user/const/all_direction_navigator.dart';
import 'package:famous_steam_user/const/colors.dart';
import 'package:famous_steam_user/const/global.dart';
import 'package:famous_steam_user/const/prefKeys.dart';
import 'package:famous_steam_user/model/check_mob_otp_model.dart';
import 'package:famous_steam_user/model/register_model.dart';
import 'package:famous_steam_user/model/verify_otp_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage3 extends StatefulWidget {
  IntroPage3(this.otp, this.mobileNo,{Key? key}) : super(key: key);
  String? otp;
  String? mobileNo;
  @override
  State<IntroPage3> createState() => _IntroPage3State();
}

class _IntroPage3State extends State<IntroPage3> {
  TextEditingController otpcontroller = TextEditingController();
  final repository = Repository();
  @override
  void initState() {
    super.initState();
 //   otpcontroller.text = widget.otp!;

    getToken();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: AppColor.lightrgrey,
        body: Stack(children: [
          SizedBox(
            width: double.infinity,
            child: Image.asset(
              'images/package_image.png',
              fit: BoxFit.cover,
            ),
          ),
    /*      ColorFiltered(
            colorFilter: const ColorFilter.mode(
              AppColor.appColor,
              BlendMode.color,
            ),
            child:
          ),*/

          Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.6),
                    Form(
                      key: _formKey,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20.w, right: 20.w),
                        child: TextFormField(
                          autofocus: false,
                          validator: validateOTP,
                          maxLength: 6,
                          controller: otpcontroller,
                          obscureText: false,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            fontSize: 16.h,
                            color: AppColor.appColor,
                          ),
                          decoration: InputDecoration(
                            filled: false,
                            fillColor: AppColor.appColor,
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColor.appColor,
                              ),
                            ),
                            hintText: 'Enter OTP',
                            hintStyle: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                color: AppColor.appColor,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 44.h),
                    GestureDetector(
                      onTap: () {
                        onSendOtpApi();
                      },
                      child:Padding(
                        padding: EdgeInsets.only(left: 20.w, right: 20.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Resend OTP",
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                  color: AppColor.appColor,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),


                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {

                          onVerifyOtpApi();

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
                            'VERIFY OTP',
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
                  ],
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }

  String? validateOTP(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Enter Your OTP';
    } else if (value.length != 6) {
      return 'OTP must be of 6 digit';
    }
    return null;
  }

  dynamic onSendOtpApi() async {
    // show loader
    Loader().showLoader(context);
    final CheckMobileModel isOtp = await repository.onSendOTP(widget.mobileNo.toString());
    Loader().hideLoader(context);

    if(isOtp.status!){
      showSnackBar(context,"OTP Send Successfully.");

    }else if(!isOtp.status!){

      showSnackBar(context,isOtp.message.toString());
    }

  }
  String? token_device_token;
  getToken() async {
    token_device_token = await FirebaseMessaging.instance.getToken();
    print("@token=>"+token_device_token!);

  }
  dynamic onVerifyOtpApi() async {

    // show loader
    Loader().showLoader(context);
    print(widget.mobileNo.toString());
    print(widget.otp.toString());
    print(otpcontroller.text);
    FocusScope.of(context).unfocus();
    final VerifyModel isVerifyData = await repository.onVerifyotpAPI(widget.mobileNo.toString(),otpcontroller.text,token_device_token!);
    Loader().hideLoader(context);

    if(isVerifyData.status!=null) {
      if (!isVerifyData.status) {
        showRedSnackBar(context, isVerifyData.message.toString());
      }
    }

    if(isVerifyData.accessToken!.isNotEmpty){

     PrefObj.preferences!.put(PrefKeys.TOKEN, isVerifyData.accessToken);
     PrefObj.preferences!.put(PrefKeys.USERID, isVerifyData.data!.id.toString());
      showSnackBar(context,isVerifyData.message.toString());

      NavigatorAnimation(context,  BottomBarpage(pageIndex: 1,)).navigateFromRight();

    }else if(!isVerifyData.accessToken!.isNotEmpty){

      showRedSnackBar(context,isVerifyData.message.toString());
    }else{

      showRedSnackBar(context,isVerifyData.message.toString());
    }

  }
}
