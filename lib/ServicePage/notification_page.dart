import 'package:famous_steam_user/bloc/notification_bloc.dart';
import 'package:famous_steam_user/const/colors.dart';
import 'package:famous_steam_user/const/config.dart';
import 'package:famous_steam_user/const/global.dart';
import 'package:famous_steam_user/const/prefKeys.dart';
import 'package:famous_steam_user/localizations/app_localizations.dart';
import 'package:famous_steam_user/model/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final userstr =
      PrefObj.preferences!.containsKey(PrefKeys.TOKEN) ? true : false;
  @override
  void initState() {
    super.initState();

    if (Config.isDebug) {print('page--> NotificationPage');}

    userstr ? notificationbloc.notificationsink() : loginButton(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightrgrey,
      key: _key,
      endDrawer: drawer(context),
      appBar: PreferredSize(
          child: Padding(
            padding: const EdgeInsets.only(top: 40,left: 12),
            child: appbarWidget(context, _key)
          ),
          preferredSize: const Size(double.infinity, 60)),
      body: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18),
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (notification) {
            notification.disallowGlow();
            return true;
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.w),
                notificationHistory(),
                SizedBox(height: 25.w),
                Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
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
                        height: 10,
                      ),
                      userstr ? card() : loginButton(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget notificationHistory() {
    return Text(
      Translation.of(context)!.translate('notification1')!,
      style: GoogleFonts.montserrat(
          textStyle: TextStyle(
        fontSize: 18.sp,
      )),
    );
  }

  Widget card() {
    return StreamBuilder<NotificationModel>(
      stream: notificationbloc.notificationstream,
      builder:
          (context, AsyncSnapshot<NotificationModel> notificationsnapshot) {
        if (!notificationsnapshot.hasData) {
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
        return notificationsnapshot.data!.data!.isNotEmpty
            ? ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: notificationsnapshot.data!.data!.length,
            itemBuilder: (context, index) {
              return userstr
                  ? Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.transparent,
                    child: Container(
                      height: 70.h,
                      width: 350.w,
                      decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 3.0,
                            ),
                          ],
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.all(Radius.circular(3.0))),
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 10),
                            child:Text(
                              notificationsnapshot.data!
                                  .data![index].notification!.title!,
                              style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color:
                                  const Color(0xff004471)),
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.only(left: 10.sp),
                            child: Text(
                              notificationsnapshot.data!
                                  .data![index].notification!.message!,
                              style: GoogleFonts.montserrat(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xff7E7C7C)),
                            ),
                          ),
                          const SizedBox(
                            height: 7,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )
                  : loginButton(context);
            }):  SizedBox(
                height: MediaQuery.of(context).size.height - 100,
                child: Center(
                  child: Text(
                    Translation.of(context)!.translate('nodatafound')!,
                  ),
                ),
              )
             ;
      },
    );
  }
}
