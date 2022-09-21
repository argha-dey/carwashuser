import 'dart:async';

import 'package:famous_steam_user/Repository/repository.dart';
import 'package:famous_steam_user/const/colors.dart';
import 'package:famous_steam_user/const/config.dart';
import 'package:famous_steam_user/const/global.dart';
import 'package:famous_steam_user/model/rating_star_feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ReviewAndRatingPage extends StatefulWidget {
  final String orderId;
  final String packageId;
 ReviewAndRatingPage({Key? key,required this.orderId,required this.packageId}) : super(key: key);

  @override
  State<ReviewAndRatingPage> createState() => _ReviewAndRatingPageState();
}

class _ReviewAndRatingPageState extends State<ReviewAndRatingPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController reviewController = TextEditingController();
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    if (Config.isDebug) {print('page--> ReviewAndRatingPage');}

    super.initState();
  }

  String ratValue = '';

  final repository = Repository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightrgrey,
      key: _key,
      endDrawer: drawer(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 18.w, right: 18.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Container(),
             /*   yourLocation(context, _key),*/
                topImage(),
                text(),
                SizedBox(height: 5.w),
                text1(),
              /*  SizedBox(height: 20.w),
                textField(),*/
                SizedBox(height: 20.w),
                rating(),
                SizedBox(height: 20.w),
                reviews(),
                SizedBox(height: 30.w),
                submitButton(),
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
        'images/review_and_ratings.png',
        height: 300,
      ),
    );
  }

  Widget text() {
    return Column(
      children: [
        Center(
          child: Text(
            "Give your valuable feedback",
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

  Widget text1() {
    return Column(
      children: [
        Center(
          child: Text(
            "",
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                color: const Color(0xff7E7C7C),
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget textField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 10,
          ),
          child: Text(
            "User name",
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                color: const Color(0xff2F2F2F),
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
              ),
            ),
          ),
        ),
        SizedBox(height: 10.w),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: TextField(
            controller: nameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter your name',
            ),
          ),
        ),
      ],
    );
  }

  Widget rating() {
    return Padding(
      padding: EdgeInsets.only(left: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Your Rating",
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                color: const Color(0xff2F2F2F),
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
              ),
            ),
          ),
          SizedBox(height: 5.w),
          RatingBar.builder(
            itemSize: 40.w,
            initialRating: 5,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: AppColor.yellowColor,
            ),
            onRatingUpdate: (rating) {
              setState(() {
                ratValue = rating.toString();
              });
            },
          ),
        ],
      ),
    );
  }

  Widget reviews() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 10,
          ),
          child: Text(
            "Your review",
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                color: const Color(0xff2F2F2F),
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
              ),
            ),
          ),
        ),
        SizedBox(height: 10.w),

        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: TextField(
            controller: reviewController,
            decoration: const InputDecoration(
              labelText: 'write your feedback',
              border: OutlineInputBorder(),

            ),
            maxLines: 5,
            minLines: 1,
          ),
        )
      ],
    );
  }

  Widget submitButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              onStarRatingAPI();
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColor.appColor,
                borderRadius: BorderRadius.circular(3),
              ),
              child: Center(
                child: Text(
                  'Submit',
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
      ),
    );
  }

  dynamic onStarRatingAPI() async {
    Loader().showLoader(context);
 final    ServiceRatingModel starRating = await repository.onStarRating(ratValue, widget.orderId, reviewController.text,widget.packageId);

    if (starRating.message=='Rating Successfully') {
      FocusScope.of(context).requestFocus(FocusNode());

      Loader().hideLoader(context);
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "${starRating.message}",
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: const Color(0xff128807),
              ),
              textAlign: TextAlign.center,
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
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          );
        },
      );
    } else {
      Loader().hideLoader(context);
      showSnackBar(context, starRating.message.toString());
    }
  }
}
