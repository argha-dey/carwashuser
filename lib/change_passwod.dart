import 'dart:async';

import 'package:famous_steam_user/AddressPage/edit_address_page.dart';
import 'package:famous_steam_user/bloc/get_user_bloc.dart';
import 'package:famous_steam_user/bloc/getadderss_bloc.dart';
import 'package:famous_steam_user/const/colors.dart';
import 'package:famous_steam_user/const/config.dart';
import 'package:famous_steam_user/model/get_user_model.dart';
import 'package:famous_steam_user/model/get_address_model.dart';
import 'package:famous_steam_user/review_and_rating_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'const/global.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  void initState() {
    super.initState();
    if (Config.isDebug) {print('page--> ChangePasswordPage');}
    Timer.periodic(
        const Duration(seconds: 10), (Timer t) => getCurrentLocation());
    getadderssbloc.getaddresssink();
    getuserbloc.getusersink();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 18.w, right: 18.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30.w),
                yourLocation(context, _key),
                topImage(),
                SizedBox(height: 5.w),
                text(),
                SizedBox(height: 20.w),
                onlytext(),
                SizedBox(height: 20.w),
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
        'images/setting.png',
        height: 300,
      ),
    );
  }

  Widget text() {
    return Column(
      children: [
        Center(
          child: Text(
            "Account Setting",
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                color: const Color(0xff004471),
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget onlytext() {
    return StreamBuilder<GetuserModel>(
        stream: getuserbloc.getuserstream,
        builder: (context, AsyncSnapshot<GetuserModel> getusersnapshot) {
          if (!getusersnapshot.hasData) {
            return SizedBox(
              height: 100.h,
              width: 100.w,
              child: Lottie.asset(
                'images/102766-error.json',
              ),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Personal Details",
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    color: const Color(0xff2F2F2F),
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                  ),
                ),
              ),
              SizedBox(height: 10.w),
              Row(
                children: [
                  Text(
                    getusersnapshot.data!.data!.nameEng.toString(),
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        color: const Color(0xff7E7C7C),
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.edit_outlined,
                    color: Color(0xff004471),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                getusersnapshot.data!.data!.email!.toString(),
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    color: const Color(0xff7E7C7C),
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                  ),
                ),
              ),
              SizedBox(height: 5.w),
              Text(
                getusersnapshot.data!.data!.mobile!.toString(),
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    color: const Color(0xff7E7C7C),
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "Manage Address",
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        color: const Color(0xff2F2F2F),
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "Add new",
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        color: const Color(0xff004471),
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.w),
              StreamBuilder<GetaddressModel>(
                  stream: getadderssbloc.getaddresstream,
                  builder: (context,
                      AsyncSnapshot<GetaddressModel> getaddresssnepshot) {
                    if (!getaddresssnepshot.hasData) {
                      return Center(
                          child: SizedBox(
                        height: 100.h,
                        width: 100.w,
                        child: Lottie.asset(
                          'images/102766-error.json',
                        ),
                      ));
                    }
                    return Row(
                      children: [
                        Text(
                          getaddresssnepshot.data!.data![0].address!,
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              color: const Color(0xff7E7C7C),
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditAdderssPage(
                                  editaddress: getaddresssnepshot
                                      .data!.data![1].address!,
                                ),
                              )),
                          child: const Icon(
                            Icons.edit_outlined,
                            color: Color(0xff004471),
                          ),
                        )
                      ],
                    );
                  }),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Password",
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        color: const Color(0xff2F2F2F),
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),

                  Row(
                    children: [
                      Text(
                        "Last update 20-01-2022",
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            color: const Color(0xff7E7C7C),
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  "Change Your Password",
                                  style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                      color: const Color(0xff2F2F2F),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ),
                                content: SizedBox(
                                  height: 300,
                                  width: 500,
                                  child: Column(
                                    children: [
                                      const TextField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText:
                                              'Enter your current password',
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const TextField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Enter new passwod',
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const TextField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Re-enter new passwod',
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 35,
                                      ),
                                      savePasswordButton(),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 30,
                          width: 100,
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: const Color(0xff004471),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Center(
                            child: Text(
                              'Change',
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: const Color(0xffFFFFFF),
                                fontSize: 14.sp,
                              )),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          );
        });
  }

  Widget savePasswordButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Center(
                    child: Text(
                      "Your password changed \nsuccessfuly",
                      style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff128807)),
                    ),
                  ),
                  actions: <Widget>[
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: AppColor.appColor,
                          onPrimary: AppColor.appColor,
                        ),
                        child: Text(
                          'OK',
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColor.whiteColor,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                    ReviewAndRatingPage(orderId: "",packageId: "")));
                        },
                      ),
                    ),
                  ],
                );
              },
            );
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColor.appColor,
              borderRadius: BorderRadius.circular(3),
            ),
            child: Center(
              child: Text(
                'Save Password',
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    color: AppColor.whiteColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
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
