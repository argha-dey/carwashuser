import 'package:famous_steam_user/Bottombar/bottombar.dart';
import 'package:famous_steam_user/IntroPage/enter_mobile_no_page.dart';
import 'package:famous_steam_user/const/all_direction_navigator.dart';
import 'package:famous_steam_user/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage5 extends StatefulWidget {
  const IntroPage5({Key? key}) : super(key: key);

  @override
  State<IntroPage5> createState() => _IntroPage5State();
}

class _IntroPage5State extends State<IntroPage5> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        SizedBox(
          width: double.infinity,
          child: Image.asset(
            'images/mobilebgimage.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome to FAMOUS STEAM",
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: 21.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Your car wash partner in your area",
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: 12.sp,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "please allow us to track your current ",
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: 12.sp,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "location to track our availability of service in your area.",
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: 12.sp,
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  SizedBox(width: 10.w),
                  SizedBox(width: 10.w),
                  Text(
                    "         Location : for finding available services near you",
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        color: AppColor.whiteColor,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        "Allow Lorem to access this device’s location?",
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
                    'ALLOW',
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
      ]),
    );
  }
}
