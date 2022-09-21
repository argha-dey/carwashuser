import 'dart:async';


import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:famous_steam_user/const/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:scoped_model/scoped_model.dart';

import 'AddressPage/add_address_page.dart';
import 'AddressPage/edit_address_page.dart';
import 'AddressPage/edit_personal_details.dart';
import 'bloc/get_user_bloc.dart';
import 'bloc/getadderss_bloc.dart';
import 'bloc/language_select_bloc.dart';
import 'const/all_direction_navigator.dart';
import 'const/colors.dart';
import 'const/global.dart';
import 'const/prefKeys.dart';
import 'localizations/app_localizations.dart';
import 'localizations/language_model.dart';
import 'model/get_address_model.dart';
import 'model/get_user_model.dart';
import 'model/language_select_model.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final GlobalKey<ExpansionTileCardState> _languageKeys = GlobalKey();
  LangModel? languageModel;
  String dropLanguageValue = 'English';
  List<GetAddressdata> addressData = [];

  final userstr =  PrefObj.preferences!.containsKey(PrefKeys.TOKEN) ? true : false;

  @override
  void initState() {
    super.initState();
    if (Config.isDebug) {print('page--> SettingPage');}

    if(PrefObj.preferences!.get(PrefKeys.LANG)=='eng'){
      dropLanguageValue = 'English';
    }else{
      dropLanguageValue = 'Arabic';
    }

  //  Timer.periodic( const Duration(seconds: 10), (Timer t) => getCurrentLocation() );

    getuserbloc.getusersink();

    //  userstr ? getuserbloc.getusersink(): loginButton(context);

    // userstr ? getadderssbloc.getaddresssink(): loginButton(context);

    Future.delayed(const Duration(milliseconds: 2000), () {
      setState(() {
        getadderssbloc.getaddresssink();
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightrgrey,
      key: _key,
      endDrawer: drawer(context),
      body: ScopedModelDescendant<LangModel>(builder: (context, child, model) {
        languageModel = model;
        return SingleChildScrollView(
          child: SingleChildScrollView(
            child: Column(
              children: [

                Padding(
                  padding: const EdgeInsets.only(left: 18, right: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 40.w),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 2),
                          child: Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColor.whiteColor,
                                boxShadow: [
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
                      SizedBox(height: 20.w),
                      topImage(),
                      SizedBox(height: 5.w),
                      text(),
                      SizedBox(height: 20.w),
                      Column(
                        children: [
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
                          SizedBox(
                            height: 10,
                          ),
                          userstr
                              ? Column(
                            children: [
                              onlytext(),
                              SizedBox(height: 20.w),
                              english(),
                              SizedBox(height: 30.w),
                            ],
                          )
                              : loginButton(context)
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
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
            Translation.of(context)!.translate('accountsetting')!,
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

          PrefObj.preferences!.put(PrefKeys.USERID,  getusersnapshot.data!.data!.id);
          return userstr
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Translation.of(context)!.translate('personaldetails')!,
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    color: const Color(0xff2F2F2F),
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    getusersnapshot.data!.data!.nameEng!.toString(),
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
                    onTap: () {
                      NavigatorAnimation(
                          context,
                          EditPersonalDetails(
                              getuserModel: getusersnapshot.data!))
                          .navigateFromRight();
                    },
                    child: const Icon(
                      Icons.edit_outlined,
                      color: Color(0xff004471),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                getusersnapshot.data!.data!.email.toString(),
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    color: const Color(0xff7E7C7C),
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
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
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    Translation.of(context)!.translate('manageaddress')!,
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        color: const Color(0xff2F2F2F),
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      NavigatorAnimation(
                        context,
                        const AddAddressPage(),
                      ).navigateFromRight().then(
                              (value) => getadderssbloc.getaddresssink());
                    },
                    child:   addressData.length>=3 ? Container(): Text(
                      Translation.of(context)!.translate('addnew')!,
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          color: const Color(0xff004471),
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              addressList(),

              const SizedBox(
                height: 10,
              ),

              const SizedBox(
                height: 20,
              ),
              Text(
                Translation.of(context)!.translate('selectlanguage')!,
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    color: const Color(0xff2F2F2F),
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          )
              : loginButton(context);
        });
  }

  Widget addressList(){
    return StreamBuilder<GetaddressModel>(
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
          addressData = getaddresssnepshot.data!.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: getaddresssnepshot.data!.data!.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Expanded(
                    child: Text(
                      getaddresssnepshot
                          .data!.data![index].address ??
                          '',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          color: const Color(0xff7E7C7C),
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                        ),
                      ),
                      maxLines: 2,

                      overflow: TextOverflow.ellipsis,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.left,),
                  ),
                  SizedBox(height: 5.h),

                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditAdderssPage(
                              editaddress: getaddresssnepshot
                                  .data!.data![index].address!, addressId:getaddresssnepshot.data!.data![index].id
                          ),
                        )),
                    child: const Icon(
                      Icons.edit_outlined,
                      color: Color(0xff004471),
                    ),
                  )
                ],
              );
            },
          );
        });
  }

  Widget english() {

    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.w),
            color: AppColor.whiteColor,
            // ignore: prefer_const_literals_to_create_immutables
            boxShadow: [
              const BoxShadow(
                color: Colors.grey,
                blurRadius: 3.0,
              ),
            ]),
        child: ExpansionTileCard(
          key: _languageKeys,
          onExpansionChanged: (value) {
            setState(() {

              // print(checkExpansionTile);
            });
            setState(() {});
          },


          children: [
            ListTile(
              title: Text(
                "English",
                style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      color: AppColor.appColor,
                      fontSize: 14.sp,
                    )),
              ),
              onTap: () {
                dropLanguageValue = 'English';
                PrefObj.preferences!.put(PrefKeys.LANG, 'eng');
                languageModel!.changeLanguage('en');
                _languageKeys.currentState?.collapse();

              },
            ),
            ListTile(
              title: Text(
                "Arabic",
                style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      color: AppColor.appColor,
                      fontSize: 14.sp,
                    )),
              ),
              onTap: () {
                setState(() {
                  dropLanguageValue = 'Arabic';
                  PrefObj.preferences!.put(PrefKeys.LANG, 'ar');
                  languageModel!.changeLanguage('ar');
                  _languageKeys.currentState?.collapse();

                }
                );
              },
            ),
          ],

          title: Text(
            dropLanguageValue,
            style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  color: AppColor.appColor,
                  fontSize: 14.sp,
                )),
          ),
        ));




    /*
    return StreamBuilder<LanguageSelectModel>(
        stream: langauageSelectbloc.getlangauageselectstream,
        builder: (context,
            AsyncSnapshot<LanguageSelectModel> langauageselectsnapshot) {
          if (!langauageselectsnapshot.hasData) {
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
          return Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.w),
                  color: AppColor.whiteColor,
                  // ignore: prefer_const_literals_to_create_immutables
                  boxShadow: [
                    const BoxShadow(
                      color: Colors.grey,
                      blurRadius: 3.0,
                    ),
                  ]),
              child: ExpansionTile(
                children: [
                  ListTile(
                    title: Text(
                      langauageselectsnapshot.data!.data!.eng!,
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                        color: AppColor.appColor,
                        fontSize: 14.sp,
                      )),
                    ),
                    onTap: () {
                      PrefObj.preferences!.put(PrefKeys.LANG, 'eng');
                      languageModel!.changeLanguage('en');
                    },
                  ),
                  ListTile(
                    title: Text(
                      langauageselectsnapshot.data!.data!.ar!,
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                        color: AppColor.appColor,
                        fontSize: 14.sp,
                      )),
                    ),
                    onTap: () {
                      setState(() {
                        PrefObj.preferences!.put(PrefKeys.LANG, 'ar');
                        languageModel!.changeLanguage('ar');
                      });
                    },
                  ),
                ],
                title: Text(
                  'English',
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                    color: AppColor.appColor,
                    fontSize: 14.sp,
                  )),
                ),
              ));
        });

        */



  }
}
