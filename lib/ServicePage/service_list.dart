import 'package:famous_steam_user/ServicePage/service_list_detail_page.dart';
import 'package:famous_steam_user/const/all_direction_navigator.dart';
import 'package:famous_steam_user/const/colors.dart';
import 'package:famous_steam_user/const/config.dart';
import 'package:famous_steam_user/const/global.dart';
import 'package:famous_steam_user/const/prefKeys.dart';
import 'package:famous_steam_user/localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/search_result_bloc.dart';
import '../model/search_result_model.dart';

class ServiceList extends StatefulWidget {
  const ServiceList({Key? key}) : super(key: key);

  @override
  State<ServiceList> createState() => _ServiceListState();
}

class _ServiceListState extends State<ServiceList> {
  final userstr =
      PrefObj.preferences!.containsKey(PrefKeys.TOKEN) ? true : false;
  @override
  void initState() {
    super.initState();
    if (Config.isDebug) {print('page--> ServiceListPage');}
    userstr
        ? searchResultbloc.searchResultsink('', 'eng')
        : loginButton(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightrgrey,
      body: SafeArea(
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (notification) {
            // ignore: deprecated_member_use
            notification.disallowGlow();
            return true;
          },
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 2),
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppColor.whiteColor,
                                borderRadius: BorderRadius.circular(30.w),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 3.0,
                                  ),
                                ]),
                            child: const Icon(
                              Icons.keyboard_arrow_left_sharp,
                              color: AppColor.appColor,
                              size: 35,
                            ),
                          ),
                        ),
                      ),
                      yourLocation(),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(right: 15, top: 20),
                    child: textfield2()),
                Padding(
                  padding: const EdgeInsets.only(left: 25, top: 30, right: 25),
                  child: Row(
                    children: [
                      Text(
                        Translation.of(context)!.translate('carwashingresult')!,
                        style: GoogleFonts.montserrat(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff7E7C7C)),
                      ),
                      const SizedBox(
                        width: 170,
                      ),
                      const Icon(
                        Icons.filter_list_alt,
                        size: 20,
                        color: Color(0xff004471),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(right: 15, top: 15),
                    child: userstr ? card() : loginButton(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget yourLocation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  Translation.of(context)!.translate('location')!,
                  style: GoogleFonts.montserrat(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff7E7C7C)),
                ),
                const SizedBox(width: 5),
                Icon(
                  Icons.location_on,
                  size: 15.sp,
                  color: AppColor.appColor,
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              "B-55 Yogichowk,Surat-3950010",
              style: GoogleFonts.montserrat(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff262626)),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            setState(() {});
          },
          child: Icon(
            Icons.more_vert_rounded,
            color: AppColor.appColor.withOpacity(0.9),
            size: 35.h,
          ),
        ),
      ],
    );
  }

  Widget textfield2() {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFffffff),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5.0,
            ),
          ],
        ),
        width: double.infinity,
        height: 50,
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                onChanged: (name) {
                  searchResultbloc.searchResultsink(name, 'eng');
                },
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Color(0xff004471),
                  ),
                  hintText: "Search",
                  border: InputBorder.none,
                  fillColor: Colors.grey,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'images/up_down_arrow.png',
                height: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget card() {
    return StreamBuilder<SearchResultModel>(
      stream: searchResultbloc.searchResultstream,
      builder: (context, AsyncSnapshot<SearchResultModel> serchresultsnapshot) {
        if (!serchresultsnapshot.hasData) {
          return const Center(
            child: Text(''),
          );
        }

        return serchresultsnapshot.data!.data == null
            ? SizedBox(
                height: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text(
                    'No Data Found',
                    style: GoogleFonts.montserrat(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColor.blackColor,
                    ),
                  ),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: serchresultsnapshot.data!.data!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
         /*             FocusScope.of(context).requestFocus(FocusNode());
                      NavigatorAnimation(
                        context,
                        ServiceListDetailPage(
                          selectedPackageData: serchresultsnapshot.data!.data![index],
                        ),
                      ).navigateFromRight();*/
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 20.w,
                        top: 20.w,
                        bottom: 20.w,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color:
                                    const Color(0xff004471).withOpacity(0.5)),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 2.0,
                              ),
                            ],
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(3.0))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 20),
                              child: Row(
                                children: [
                                  Text(
                                    serchresultsnapshot
                                        .data!.data![index].packagePlan!,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xff004471)),
                                  ),
                                  const Spacer(),
                                  Text(
                                    'SAR ${serchresultsnapshot.data!.data![index].price}',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xff004471)),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10, left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        serchresultsnapshot
                                            .data!.data![index].services
                                            .toString(),
                                        style: GoogleFonts.montserrat(
                                            fontSize: 13,
                                            fontWeight: FontWeight.normal,
                                            color: const Color(0xff262626)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20.w, right: 20.w),
                              child: Row(
                                children: [
                                  Text(
                                    "Location: Lorem Ipsum is sim ..",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.normal,
                                        color: const Color(0xff7E7C7C)),
                                  ),
                                  const Spacer(),
                                  Text(
                                    '${serchresultsnapshot.data!.data![index].timeDuration!} mins away',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.normal,
                                        color: const Color(0xff7E7C7C)),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
      },
    );
  }
}
