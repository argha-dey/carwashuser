import 'dart:async';
import 'package:famous_steam_user/Bottombar/bottombar.dart';
import 'package:famous_steam_user/IntroPage/enter_mobile_no_page.dart';
import 'package:famous_steam_user/IntroPage/intro_page_4.dart';
import 'package:famous_steam_user/const/all_direction_navigator.dart';
import 'package:famous_steam_user/const/colors.dart';
import 'package:famous_steam_user/const/prefKeys.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _autoNavigation();
    super.initState();
  }

  Future<void> _autoNavigation() async {
    Timer(const Duration(seconds: 4), navigateUser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: AppColor.lightrgrey,
        body: new Stack(
          children: <Widget>[

            Center(
              child: SizedBox(
                width: double.infinity,
                child: Image.asset(
                  'images/package_image.png',
                  fit: BoxFit.cover,
                ),
              ),
            )



 /*
*/

          ],
        )

    );
  }
//978749509
  void navigateUser() {
    bool isregister = PrefObj.preferences!.containsKey(PrefKeys.TOKEN) ? true : false;
    NavigatorAnimation(
        context, isregister ?  BottomBarpage(pageIndex: 1) : const IntroPage4())
        .navigateFromRight();
  }
}
