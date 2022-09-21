

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:famous_steam_user/ServicePage/service_list_detail_page.dart';

import 'package:famous_steam_user/add_Vehicle_Details.dart';
import 'package:famous_steam_user/bloc/category_list_bloc.dart';
import 'package:famous_steam_user/bloc/data_bycategory_block.dart';
import 'package:famous_steam_user/bloc/getpackage_bloc.dart';
import 'package:famous_steam_user/bloc/package_index_bloc.dart';
import 'package:famous_steam_user/bloc/package_size_bloc.dart';
import 'package:famous_steam_user/bloc/pickyourpackage_bloc.dart';
import 'package:famous_steam_user/bloc/service_list_bloc.dart';
import 'package:famous_steam_user/bloc/vehicle_list_bloc.dart';
import 'package:famous_steam_user/bloc/vehicle_list_by_cetegory_bloc.dart';
import 'package:famous_steam_user/const/colors.dart';
import 'package:famous_steam_user/const/config.dart';
import 'package:famous_steam_user/const/global.dart';
import 'package:famous_steam_user/const/prefKeys.dart';
import 'package:famous_steam_user/model/package_size_model.dart';
import 'package:famous_steam_user/model/pick_your_package_model.dart';
import 'package:famous_steam_user/model/service_list_model.dart';
import 'package:famous_steam_user/model/vehicle_list_by_cetegory_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';


import 'const/all_direction_navigator.dart';

import 'localizations/app_localizations.dart';
import 'model/category_list_model.dart';
import 'model/package_index_model.dart';
import 'model/vehicle_list_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

String iscategoryid = '1';

class _HomePageState extends State<HomePage> {

  final GlobalKey<ExpansionTileCardState> keySize = GlobalKey();
  final GlobalKey<ExpansionTileCardState> keyBrand = GlobalKey();
  final GlobalKey<ExpansionTileCardState> keyModel = GlobalKey();
  final _multiSelectKey = GlobalKey<FormFieldState>();
  List<String> selectedService = [];

  List<ServiceListData> extraServiceData = [];
  bool checkExpansionTile = false;
  String ratValue = '';
  String? packageid;

  String dropValueSize = 'Select Size';
  String dropValueBrand = 'Select Brand';
  String dropValueModel = 'Select Model';

  String noImageFound = "https://famoussteam.com/crm/uploads/washingplan/21389185931651097558.png";

  final userstr = PrefObj.preferences!.containsKey(PrefKeys.TOKEN) ? true : false;

  bool isCheck = false;
  List<VehicleDetails>? vehicle_details;
  String size = '';
  String sizeId = '';
  String vahicleId = '';
  String vahicleName = '';
  bool isSelected = false;
  bool isSelectedExtraService = false;
  VehicleDetails? selectedVehicleDetails;
  PackageData? packageDataDetails;
  String? selectedPackageId='';

  List<ServiceListData> selectedExtraServiceListData = [];


  @override
  void initState() {
    super.initState();
    if (Config.isDebug) {print('page--> HomePage');}


    if(PrefObj.preferences!.get(PrefKeys.LANG)=='ar'){
      PrefObj.preferences!.put(PrefKeys.LANG, 'ar');
    }else{
      PrefObj.preferences!.put(PrefKeys.LANG, 'eng');
    }


    // PrefObj.preferences!.get(PrefKeys.USERID);
    //PrefObj.preferences!.put(PrefKeys.USERID, PrefKeys.USERID);

    packageindexbloc.getPackageIndexsink('','','');
    categoryListbloc.categorylistsink('');
    vehicleListbloc.categorylistsink('-1');

    // for first time


    // vehiclelbrandlistbycategorybloc.vehiclelbrandlistbycategorysink('eng','1');
    // databycategorybloc.databycategorystreamsink('categoryid', 'lang');
    //  packageSizebloc.getPackageIndexsink('1', 'eng');



  }

  int seletectIndex = -1;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightrgrey,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(right: 15.w, left: 15.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              /*    card(),*/
              getSlider(),
              const SizedBox(height: 20),
              categories(),
              const SizedBox(height: 30),
              radioButtonSelectAddedCar(),
              const SizedBox(height: 40,),
              anotherCarText(),
              const SizedBox(height: 30),
              pickYourPackage(),
              const SizedBox(height: 30),
              pickYourExtraService(),
              const SizedBox(height: 30),
              button(),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),

    );
  }

  Widget categories() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          Text(
            Translation.of(context)!.translate('choosecategories')!,
            style: GoogleFonts.montserrat(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColor.appColor,
            ),
          ),
          SizedBox(height: 20.h),
          StreamBuilder<CategoryListModel>(
            stream: categoryListbloc.categoryliststream,
            builder:
                (context, AsyncSnapshot<CategoryListModel> categorysnapshot) {
              if (!categorysnapshot.hasData) {
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
              // Call for first time

              return SizedBox(
                height: 155.h,

                child: ListView.builder(

                    scrollDirection: Axis.horizontal,
                    itemCount: categorysnapshot.data!.data!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          seletectIndex = index;
                          iscategoryid = categorysnapshot.data!.data![index].id.toString();
                          vehicleListbloc.categorylistsink(iscategoryid);
                          selectedPackageId='';
                          if(iscategoryid=='2') {   // For Bike Only
                            getpackagebloc.getpackagesink('', iscategoryid, '');
                          }else{
                            getpackagebloc.getpackagesink('', iscategoryid, '-1');
                          }

                          setState(() {});
                        },


                        child:Column(

                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 10, right: 10,top: 8),
                              decoration: BoxDecoration(
                                color: seletectIndex == index
                                    ? AppColor.appColor
                                    : Colors.blue.shade50,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue.shade100,
                                    blurRadius: 10.0,
                                  ),
                                ],
                              ),
                              child: CircleAvatar(
                                radius: 45.0.w,
                                child: Center(
                                  child: Image.network(
                                    categorysnapshot.data!.data![index].image == null ? noImageFound : categorysnapshot.data!.data![index].image!,
                                    height: 45.h,
                                    width: 45.w,
                                    color: seletectIndex == index
                                        ? AppColor.whiteColor
                                        : AppColor.appColor,
                                  ),

                                  /* CachedNetworkImage(
                                imageUrl:  categorysnapshot.data!.data![index].image!,
                                imageBuilder: (context, imageProvider) => Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) => CircularProgressIndicator(),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                              ),*/
                                ),
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                            const SizedBox(height: 15,),
                            Text(
                              categorysnapshot.data!.data![index].name.toString().toUpperCase(),
                              style: GoogleFonts.montserrat(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColor.greyColor1,
                              ),
                            ),
                          ],
                        ),



                      );

                    }),
              );
            },
          ),
        ],
      ),
    );
  }

  setSelectedVechicle(VehicleDetails user) {
    setState(() {
      selectedVehicleDetails = user;
    });
  }


  Widget dataList() {
    return StreamBuilder<VehicleListModel>(
        stream: vehicleListbloc.vehicleliststream,
        builder: (context, AsyncSnapshot<VehicleListModel> vehiclelistsnapshot) {
          if (!vehiclelistsnapshot.hasData) {
            return Center(
                child:  Text(
                  Translation.of(context)!.translate("No Data Found")!,
                  style: GoogleFonts.montserrat(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColor.blackColor,
                  ),
                )
            );
          }
          return vehiclelistsnapshot.data!.data!.isEmpty
              ? Center(
            child: Text(
              Translation.of(context)!.translate("No Data Found")!,
              style: GoogleFonts.montserrat(
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: AppColor.blackColor,
              ),
            ),
          )
              : ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: vehiclelistsnapshot.data!.data!.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  dottedLine(),
                  SizedBox(height: 16.w),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.network(
                          vehiclelistsnapshot.data!.data![index].category!.image == null ? noImageFound:  vehiclelistsnapshot.data!.data![index].category!.image!,

                          fit:BoxFit.cover
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            vehiclelistsnapshot.data!.data![index].brand!.name.toString(),
                            style: GoogleFonts.montserrat(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColor.greyColor1,
                            ),
                          ),
                          SizedBox(height: 5.w),
                          Text(
                            vehiclelistsnapshot.data!.data![index].fuel!.name.toString(),
                            style: GoogleFonts.montserrat(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColor.greyColor1,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 20.w),

                    ],
                  ),
                ],
              );
            },
          );
        });
  }

  String carType(String type) {
    switch (type) {
      case 'Car':
        return 'images/homescreencar.png';
      case 'Bike':
        return 'images/quad_bike.png';
      case 'Bus':
        return 'images/shuttle_bus.png';
      case 'Truck':
        return 'images/homescreencar.png';
    }
    return 'images/homescreencar.png';
  }


  Widget dottedLine() {
    return Container(
      height: 10.h,
      decoration: DottedDecoration(
          shape: Shape.line, linePosition: LinePosition.bottom),
    );
  }


  Widget button() {
    return Container(
      margin: const EdgeInsets.all(15),
      width: double.infinity,
      height: 44.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: AppColor.appColor,
          onPrimary: AppColor.appColor,
        ),
        child: Text(Translation.of(context)!.translate('continue')!,
          style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: AppColor.whiteColor,
              )),
        ),
        onPressed: () {
          // Service list details page
          if(selectedPackageId==''){
            showRedSnackBar(context,Translation.of(context)!.translate('Kindly select a package!')!);
          }else {
            FocusScope.of(context)
                .requestFocus(FocusNode());
            NavigatorAnimation(
              context,
              ServiceListDetailPage(
                selectedPackageData: packageDataDetails!,
                selectedExtraServiceData: selectedExtraServiceListData,
                selectedvahicleDetails: selectedVehicleDetails!,

              ),
            ).navigateFromRight();
          }
        },
      ),
    );
  }


  Widget radioButtonSelectAddedCar() {
    return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  Translation.of(context)!.translate('pickyourvehicle')!,
                  style: GoogleFonts.montserrat(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColor.appColor,
                  ),
                ),
              ),
              /*    Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColor.appColor.withOpacity(0.9),
                size: 20.w,
              ),*/
            ],
          ),
          const SizedBox(height: 30),
          StreamBuilder<VehicleListModel>(
            stream: vehicleListbloc.vehicleliststream,
            builder:
                (context, AsyncSnapshot<VehicleListModel> vehiclelistsnapshot) {
              if (!vehiclelistsnapshot.hasData) {
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

              vehicle_details = vehiclelistsnapshot.data!.data;

              return vehicle_details?.length==0 ? Center(child: Text(  Translation.of(context)!.translate("No Data Found")!,
                  style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColor.blackColor))))    :  Column(
                children: createRadioListUsers(),
              );
            },

          )
        ]
    );
  }


  List<Widget> createRadioListUsers() {
    List<Widget> widgets = [];
    for (VehicleDetails user in vehicle_details!) {
      widgets.add(Column(
        children: [
          const SizedBox(height: 5),
          Container(
            decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.circular(3),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 1.0,
                ),
              ],
            ),
            child: Row(
              children: [
                Radio<VehicleDetails>(
                  value: user,
                  groupValue: selectedVehicleDetails,
                  onChanged: (VehicleDetails? currentUser) {
                    print("Current User ${currentUser!.carSize!.carSizeId}");
                    setSelectedVechicle(currentUser);
                    isSelected = true;

                    size = currentUser.carSize!.sizeName.toString();
                    sizeId =  currentUser.carSize!.carSizeId.toString();
                    vahicleId = currentUser.userVehicleId.toString();



                    setState(() {
                      getpackagebloc.getpackagesink('',user.category!.categoryId.toString(),sizeId);

                    });

                  },
                  activeColor: AppColor.appColor,
                ),


                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5.w),
                    Text(
                      user.brand!.name.toString()+" ( "+ user.carModel!.carModelName.toString()+" ) - "+user.year!.yearName.toString(),
                      style: GoogleFonts.montserrat(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColor.greyColor1,
                      ),
                    ),
                    SizedBox(height: 5.w),
                    /*          Text(
                      user.carSize!.sizeName.toString(),
                      style: GoogleFonts.montserrat(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColor.greyColor1,
                      ),
                    ),*/
                    /*    Text(
                      user.fuel!.name.toString()+" - "+ user.category!.name.toString(),
                      style: GoogleFonts.montserrat(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColor.greyColor1,
                      ),
                    ),*/
                    SizedBox(height: 5.w),
                  ],
                ),
                /*         Text(
                  user.brand!.name.toString()+ "   "+user.category!.name.toString()+ " ("+user.fuel!.name.toString()+") ",
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        fontSize: 14.sp,
                      )),
                )*/
              ],
            ),
          ),
          const SizedBox(height: 5),
        ],
      ));
    }
    return widgets;
  }



  Widget anotherCarText() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isCheck = !isCheck;
        });
        NavigatorAnimation(
          context,
          AddVehicleDetails(
            screenType: ScreenType.add,
            isBack: (value) {
              vehiclelbrandlistbycategorybloc.vehiclelbrandlistbycategorysink('eng', iscategoryid.toString());
            },
          ),
        ).navigateFromRight();
      },



      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(12),
        child: Row(
          children: [
            MaterialButton(
              height: 25.w,
              color: AppColor.appColor,
              onPressed: () {},
              child: Icon(
                CupertinoIcons.add,
                size: 15.h,
                color: Colors.white,
              ),
              shape: const CircleBorder(),
            ),
            Text(
              Translation.of(context)!.translate('addanothervehicle')!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColor.appColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dropdownPickYourSize() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                Translation.of(context)!.translate('pickyourSize')!,
                style: GoogleFonts.montserrat(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColor.appColor,
                ),
              ),
            ),
            /*      Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColor.appColor.withOpacity(0.9),
              size: 20.w,
            ),*/
          ],
        ),
        const SizedBox(height: 30),
        StreamBuilder<PackageSizeModel>(
          stream: packageSizebloc.getpackagesizestream,
          builder:
              (context, AsyncSnapshot<PackageSizeModel> packagesizesnapshot) {
            if (!packagesizesnapshot.hasData) {
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
            return Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 40,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    color: Colors.white,
                    border: Border.all(),
                  ),
                  child: ExpansionTileCard(
                    key: keySize,
                    baseColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    initiallyExpanded: checkExpansionTile,
                    onExpansionChanged: (value) {
                      setState(() {
                        checkExpansionTile = value;
                      });
                      setState(() {});
                    },
                    children: [
                      ListView.builder(
                          padding: const EdgeInsets.all(0),
                          shrinkWrap: true,
                          itemCount: packagesizesnapshot.data!.data!.isNotEmpty
                              ? packagesizesnapshot.data!.data!.length
                              : 1,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                                keySize.currentState?.collapse();
                                packageid = packagesizesnapshot
                                    .data!.data![index].id
                                    .toString();
                                dropValueSize = packagesizesnapshot
                                    .data!.data![index].name!;
                                pickyourpackagebloc.pickyourpackagesink(
                                    "eng", packageid!);
                                setState(() {});
                              },
                              title: packagesizesnapshot.data!.data!.isNotEmpty
                                  ? Text(
                                  packagesizesnapshot
                                      .data!.data![index].name!,
                                  style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: AppColor.blackColor)))
                                  : Center(
                                child: Text( Translation.of(context)!.translate("No Data Found")!,
                                    style: GoogleFonts.montserrat(
                                        textStyle: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: AppColor.blackColor))),
                              ),
                            );
                          }),
                    ],
                    title: Text(
                      dropValueSize,
                      style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              fontSize: 16.5,
                              fontWeight: FontWeight.w400,
                              color: AppColor.blackColor)),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget dropdownPickYourVehicleBrand() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                Translation.of(context)!.translate('pickyourbrand')!,
                style: GoogleFonts.montserrat(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColor.appColor,
                ),
              ),
            ),
            /*  Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColor.appColor.withOpacity(0.9),
              size: 20.w,
            ),*/
          ],
        ),
        const SizedBox(height: 30),
        StreamBuilder<PackageSizeModel>(
          stream: packageSizebloc.getpackagesizestream,
          builder:
              (context, AsyncSnapshot<PackageSizeModel> packagesizesnapshot) {
            if (!packagesizesnapshot.hasData) {
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
            return Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 40,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    color: Colors.white,
                    border: Border.all(),
                  ),
                  child: ExpansionTileCard(
                    key: keyBrand,
                    baseColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    initiallyExpanded: checkExpansionTile,
                    onExpansionChanged: (value) {
                      setState(() {
                        checkExpansionTile = value;
                      });
                      setState(() {});
                    },
                    children: [
                      ListView.builder(
                          padding: const EdgeInsets.all(0),
                          shrinkWrap: true,
                          itemCount: packagesizesnapshot.data!.data!.isNotEmpty
                              ? packagesizesnapshot.data!.data!.length
                              : 1,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                                keyBrand.currentState?.collapse();
                                packageid = packagesizesnapshot
                                    .data!.data![index].id
                                    .toString();
                                dropValueBrand = packagesizesnapshot
                                    .data!.data![index].name!;
                                pickyourpackagebloc.pickyourpackagesink(
                                    "eng", packageid!);
                                setState(() {});
                              },
                              title: packagesizesnapshot.data!.data!.isNotEmpty
                                  ? Text(
                                  packagesizesnapshot
                                      .data!.data![index].name!,
                                  style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: AppColor.blackColor)))
                                  : Center(
                                child: Text(  Translation.of(context)!.translate("No Data Found")!,
                                    style: GoogleFonts.montserrat(
                                        textStyle: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: AppColor.blackColor))),
                              ),
                            );
                          }),
                    ],
                    title: Text(
                      dropValueBrand,
                      style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              fontSize: 16.5,
                              fontWeight: FontWeight.w400,
                              color: AppColor.blackColor)),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget dropdownPickYourVehicleModel() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                Translation.of(context)!.translate('pickyourmodel')!,
                style: GoogleFonts.montserrat(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColor.appColor,
                ),
              ),
            ),
            /*  Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColor.appColor.withOpacity(0.9),
              size: 20.w,
            ),*/
          ],
        ),
        const SizedBox(height: 30),
        StreamBuilder<PackageSizeModel>(
          stream: packageSizebloc.getpackagesizestream,
          builder:
              (context, AsyncSnapshot<PackageSizeModel> packagesizesnapshot) {
            if (!packagesizesnapshot.hasData) {
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
            return Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 40,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    color: Colors.white,
                    border: Border.all(),
                  ),
                  child: ExpansionTileCard(
                    key: keyModel,
                    baseColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    initiallyExpanded: checkExpansionTile,
                    onExpansionChanged: (value) {
                      setState(() {
                        checkExpansionTile = value;
                      });
                      setState(() {});
                    },
                    children: [
                      ListView.builder(
                          padding: const EdgeInsets.all(0),
                          shrinkWrap: true,
                          itemCount: packagesizesnapshot.data!.data!.isNotEmpty
                              ? packagesizesnapshot.data!.data!.length
                              : 1,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                                keyModel.currentState?.collapse();
                                packageid = packagesizesnapshot
                                    .data!.data![index].id
                                    .toString();
                                dropValueModel = packagesizesnapshot
                                    .data!.data![index].name!;
                                pickyourpackagebloc.pickyourpackagesink(
                                    "eng", packageid!);
                                setState(() {});
                              },
                              title: packagesizesnapshot.data!.data!.isNotEmpty
                                  ? Text(
                                  packagesizesnapshot
                                      .data!.data![index].name!,
                                  style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: AppColor.blackColor)))
                                  : Center(
                                child: Text(  Translation.of(context)!.translate("No Data Found")!,
                                    style: GoogleFonts.montserrat(
                                        textStyle: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: AppColor.blackColor))),
                              ),
                            );
                          }),
                    ],
                    title: Text(
                      dropValueModel,
                      style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              fontSize: 16.5,
                              fontWeight: FontWeight.w400,
                              color: AppColor.blackColor)),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget pickYourPackage() {
    return isSelected? Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                Translation.of(context)!.translate('pickyourpackage')!,
                style: GoogleFonts.montserrat(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColor.appColor,
                ),
              ),
            ),
            /* Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColor.appColor.withOpacity(0.9),
              size: 20.w,
            ),*/
          ],
        ),
        SizedBox(height: 40.w),
        StreamBuilder<PackageIndexModel>(
            stream: getpackagebloc.getpackagestream,
            builder: (context,
                AsyncSnapshot<PackageIndexModel> packageindexsnapshot) {
              if (!packageindexsnapshot.hasData) {
                return SizedBox(
                  height: 100.h,
                  width: 100.w,
                  child: Lottie.asset(
                    'images/102766-error.json',
                  ),
                );
              }
              return packageindexsnapshot.data!.data!.isEmpty
                  ? Text(Translation.of(context)!.translate('No Package Found')!,

                style: GoogleFonts.montserrat(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColor.blackColor,
                ),
              )
                  : SizedBox(
                height: 70.h,
                width: double.infinity,
                child: ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(0),
                    scrollDirection: Axis.horizontal,
                    itemCount: packageindexsnapshot.data!.data!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          packageDataDetails = packageindexsnapshot.data!.data![index];
                          selectedPackageId = packageDataDetails!.packageId.toString();
                          showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Center(

                                  child: Text( Translation.of(context)!.translate('Do you want to add extra services?')!,
                                    style: GoogleFonts.montserrat(
                                        textStyle: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff128807))),
                                  ),
                                ),
                                actions: <Widget>[
                                  Center(
                                    child:Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: AppColor.appColor,
                                            onPrimary: AppColor.appColor,
                                          ),
                                          child: Text(
                                            Translation.of(context)!.translate('YES')!,
                                            style: GoogleFonts.montserrat(
                                                textStyle: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColor.whiteColor)),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context, true);
                                            // Call  service list Api
                                            setState(() {
                                              isSelectedExtraService = true;
                                              serviceListBloc.serviceListSink(packageDataDetails!.category!.categoryId.toString(),packageDataDetails!.carSize!.carSizeId.toString(),packageDataDetails!.packageId.toString());
                                            });
                                          },
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: AppColor.appColor,
                                            onPrimary: AppColor.appColor,
                                          ),
                                          child: Text(
                              Translation.of(context)!.translate('SKIP')!,

                                            style: GoogleFonts.montserrat(
                                                textStyle: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColor.whiteColor)),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context, true);
                                            FocusScope.of(context)
                                                .requestFocus(FocusNode());
                                            NavigatorAnimation(
                                              context,
                                              ServiceListDetailPage(
                                                selectedPackageData: packageDataDetails!,
                                                selectedExtraServiceData: selectedExtraServiceListData,
                                                selectedvahicleDetails:selectedVehicleDetails!,
                                              ),
                                            ).navigateFromRight();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 100,
                                  ),
                                ],
                              );
                            },
                          );












                        },
                        child: Container(
                            height: 40.h,
                            width: 160.w,
                            margin: EdgeInsets.only(left: 10.w),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Colors.blue.shade200,
                                ),
                                boxShadow: [

                                  BoxShadow(
                                    color: Colors.blue.shade50,

                                  ),

                                ],

                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0))),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: [

                                  /*   CachedNetworkImage(
                                    imageUrl:packageindexsnapshot.data!.data![index].packageImage!,
                                    imageBuilder: (context, imageProvider) => Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, url) => CircularProgressIndicator(),
                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                  ),*/



                                  /*        Image.network(
                                    packageindexsnapshot.data!.data![index].packageImage == null ? noImageFound:packageindexsnapshot.data!.data![index].packageImage!,
                                    height: 35,
                                  ),*/
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(child:    Container(
                                        height: 32.0,
                                        width: 32.0,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image:
                                            AssetImage('images/car-garage.png'),
                                            fit: BoxFit.contain,
                                          ),
                                          shape: BoxShape.rectangle,
                                        ),
                                      ),flex: 1,),
                                      Expanded(child:  Column(
                                        children: [
                                          Text(
                                            packageindexsnapshot
                                                .data!.data![index].packageName!,
                                            style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: AppColor.blackColor,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            textDirection: TextDirection.rtl,
                                            textAlign: TextAlign.center,

                                          ),
                                          SizedBox(height: 10.w),
                                          Text(
                                            "SAR  ${packageindexsnapshot.data!.data![index].packagePrice}",
                                            style: GoogleFonts.montserrat(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              color: AppColor.appColor,
                                            ),  maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            textDirection: TextDirection.ltr,
                                            textAlign: TextAlign.center,

                                          ),
                                        ],
                                      ),flex: 2,)



                                    ],
                                  )



                                ],
                              ),
                            )),
                      );
                    }),
              );
            }),
      ],
    ): Container();
  }

  Widget pickYourExtraService(){
    return isSelectedExtraService? Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                Translation.of(context)!.translate('pickextraservice')!,
                style: GoogleFonts.montserrat(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColor.appColor,
                ),
              ),
            ),
            /*    Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColor.appColor.withOpacity(0.9),
              size: 20.w,
            ),*/
          ],
        ),
        SizedBox(height: 20.w),

        StreamBuilder<ServiceListModel>(
            stream: serviceListBloc.serviceListStream,
            builder: (context, AsyncSnapshot<ServiceListModel> servicelistsnapshot) {


              if (!servicelistsnapshot.hasData) {
                return SizedBox(
                  height: 100.h,
                  width: 100.w,
                  child: Lottie.asset(
                    'images/102766-error.json',
                  ),
                );
              }

              for (ServiceData serviceList in servicelistsnapshot.data!.data!) {
                extraServiceData.add(ServiceListData(id:serviceList.serviceId,name: serviceList.serviceName.toString(),service_price: serviceList.servicePrice.toString(),service_offer_price: serviceList.serviceOfferPrice.toString()));
              }

              final _items = extraServiceData
                  .map((animal) => MultiSelectItem<ServiceListData>(animal, animal.name.toString()))
                  .toList();

              return servicelistsnapshot.data!.data!.isEmpty ? Text(
                Translation.of(context)!.translate('No Package Found')!,
                style: GoogleFonts.montserrat(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColor.blackColor,
                ),
              ) : /*DropDownMultiSelect(
                onChanged: (List<String> x) {
                  setState(() {
                    selectedService = x;
                  });
                },
                options: serviceDataList,
                selectedValues: selectedService,
                whenEmpty: 'Select Service',
              );*/

              Container(
                /*  decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(.4),
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 2,
                  ),
                ),*/
                child: Column(
                  children: <Widget>[
                    MultiSelectBottomSheetField(
                      initialChildSize: 0.4,
                      buttonIcon: Icon(
                        CupertinoIcons.add,
                        size: 22.h,
                        color: AppColor.appColor,
                      ),

                      listType: MultiSelectListType.LIST,
                      searchable: true,
                      buttonText: Text(Translation.of(context)!.translate('Select Extra Services').toString()),
                      items: _items,
                      onConfirm: (values) {
                        setState(() {

                          selectedExtraServiceListData = List<ServiceListData>.from(values);

                        });

                        // Option@14097129

                      },
                      chipDisplay: MultiSelectChipDisplay(
                        onTap: (value) {
                          setState(() {
                            selectedExtraServiceListData.remove(value);
                          });
                        },
                      ),
                    ),

                  ],
                ),
              );


            }),
      ],
    ): Container();
  }


  Widget card() {
    return Column(
      children: [
        StreamBuilder<PackageIndexModel>(
            stream: packageindexbloc.getPackageIndexstream,
            builder: (context,
                AsyncSnapshot<PackageIndexModel> packageindexsnapshot) {
              if (!packageindexsnapshot.hasData) {
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
              return SizedBox(
                  width: double.infinity,
                  height:180,
                  child: ListView.builder(
                      padding: const EdgeInsets.all(0),
                      scrollDirection: Axis.horizontal,
                      itemCount: packageindexsnapshot.data!.data!.length,
                      itemBuilder: (context, index) {
                        return Container(

                          padding: EdgeInsets.only(right: 10,left: 0),
                          margin: EdgeInsets.only(right: 10.w),
                          decoration:  BoxDecoration(
                            color:AppColor.whiteColor,
                            borderRadius: BorderRadius.all(Radius.circular(14.0)),
                            border: Border.all(
                                width: 1.2, color: Colors.blue.shade300
                              //                   <--- border width here
                            ),

                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: RotatedBox(
                                  quarterTurns: 3,
                                  child: Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(80),
                                          topLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(80),
                                          topRight: Radius.circular(80)),
                                      /*     border: Border.all(
                                        width: 0.0,
                                        color: Colors.grey,
                                      ),*/
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade200,
                                          blurRadius: 5.0,
                                        ),
                                      ],
                                      image: DecorationImage(
                                        /*   image: NetworkImage(
                                          packageindexsnapshot
                                              .data!.data![index].packageImage == null ? noImageFound : packageindexsnapshot
                                              .data!.data![index].packageImage!,
                                        ),*/





                                          image: AssetImage('images/Intersect.png'),
                                          fit:BoxFit.cover

                                      ),


                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Visibility(
                                      visible: packageindexsnapshot
                                          .data!.data![index].packagePrice == null
                                          ? false
                                          : true,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.end,
                                        children: [

                                          packageindexsnapshot.data!.data![index].packageDiscount==null?Container():Positioned(
                                            top: 0,
                                            child: Container(
                                              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                                              decoration: BoxDecoration(
                                                  color: AppColor.yellowColor,
                                                  borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(8),
                                                    bottomRight: Radius.circular(8),
                                                  ) // green shaped
                                              ),
                                              child: Text(
                                                "${packageindexsnapshot.data!.data![index].packageDiscount}% off",
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColor.whiteColor,
                                                ),
                                              ),
                                            ),
                                          )

                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 5.w),
                                    Row(

                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(

                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              packageindexsnapshot.data!.data![index].packageName!.toString(),
                                              style: GoogleFonts.montserrat(
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.w600,
                                                color: AppColor.appColor,
                                              ) ,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              textDirection: TextDirection.rtl,
                                              textAlign: TextAlign.left,
                                            ),

                                            RatingBarIndicator(
                                              itemSize: 20.w,
                                              rating: parseAmount(packageindexsnapshot.data!.data![index].packageRating),
                                              itemBuilder: (context, index) => Icon(
                                                Icons.star,
                                                color: AppColor.yellowColor,
                                              ),
                                              itemCount: 5,
                                              direction: Axis.horizontal,
                                            ),
                                            SizedBox(height: 5.w),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.4,
                                              child: Text(
                                                packageindexsnapshot.data!.data![index].packageServices![0].serviceName.toString(),
                                                maxLines: 5,
                                                overflow: TextOverflow.ellipsis,
                                                textDirection: TextDirection.rtl,
                                                textAlign: TextAlign.left,
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 9.5.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                  AppColor.lightButtonColor,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Visibility(
                                              visible: packageindexsnapshot
                                                  .data!.data![index].packageOfferPrice == null || packageindexsnapshot
                                                  .data!.data![index].packageOfferPrice ==""
                                                  ? false
                                                  : true,
                                              child: Text(
                                                "SAR  ${packageindexsnapshot.data!.data![index].packagePrice}",
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 11.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColor
                                                        .lightButtonColor,
                                                    decoration: TextDecoration
                                                        .lineThrough),
                                              ),
                                            ),
                                            Visibility(
                                              visible: packageindexsnapshot
                                                  .data!.data![index].packageOfferPrice == null
                                                  ? false
                                                  : true,
                                              child: Text(
                                                "SAR  ${packageindexsnapshot.data!.data![index].packageOfferPrice}",
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColor.appColor,
                                                ),
                                              ),
                                            ),
                                            Visibility(
                                              visible: packageindexsnapshot
                                                  .data!.data![index].packageOfferPrice == null
                                                  ? true
                                                  : false,
                                              child: Text(
                                                "SAR  ${packageindexsnapshot.data!.data![index].packagePrice}",
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColor.appColor,
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      })
              );


              /*CarouselSlider(
                options: CarouselOptions(
                  enlargeCenterPage: true,
                  viewportFraction: 1,
                  aspectRatio: 1,
                  height: MediaQuery.of(context).size.height * 0.25,
                  enableInfiniteScroll: true,

                ),
                items: [

                  SizedBox(height: 30.w),
                ],
              );*/
            }),
      ],
    );
  }

  Widget getSlider() {
    return Column(
      children: [
        StreamBuilder<PackageIndexModel>(
            stream: packageindexbloc.getPackageIndexstream,
            builder: (context,
                AsyncSnapshot<PackageIndexModel> packageindexsnapshot) {
              if (!packageindexsnapshot.hasData) {
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
              return  CarouselSlider(
                options: getOptions(), //=====Find the options in next step
                items: packageindexsnapshot.data!.data!.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width,

                          decoration:  BoxDecoration(
                            color:AppColor.whiteColor,
                            borderRadius: BorderRadius.all(Radius.circular(14.0)),
                            border: Border.all(
                                width: 1.2, color: Colors.blue.shade300
                              //                   <--- border width here
                            ),

                          ),
                          child:Row(

                            children: [

                              Align(
                                alignment: Alignment.bottomLeft,
                                child: RotatedBox(
                                  quarterTurns: 3,
                                  child: Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(80),
                                          topLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(80),
                                          topRight: Radius.circular(80)),

                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade200,
                                          blurRadius: 5.0,
                                        ),
                                      ],
                                      image: DecorationImage(
                                          image: AssetImage('images/Intersect.png'),
                                          fit:BoxFit.cover

                                      ),


                                    ),
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    i.packageDiscount==null?Text(''):
                                    Container(
                                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                                      decoration: BoxDecoration(
                                          color: AppColor.yellowColor,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            bottomRight: Radius.circular(8),
                                          ) // green shaped
                                      ),
                                      child:  Text(
                                        "${i.packageDiscount}% off",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.bold,
                                            color: AppColor.whiteColor,
                                  ),

                                      ),
                                    ),




                                    Row(

                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(

                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              i.packageName!.toString(),
                                              style: GoogleFonts.montserrat(
                                                fontSize: 11.sp,
                                                fontWeight: FontWeight.w600,
                                                color: AppColor.appColor,
                                              ) ,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                            ),

                                            RatingBarIndicator(
                                              itemSize: 18.w,
                                              rating: parseAmount(i.packageRating),
                                              itemBuilder: (context, index) => Icon(
                                                Icons.star,
                                                color: AppColor.yellowColor,
                                              ),
                                              itemCount: 5,
                                              direction: Axis.horizontal,
                                            ),
                                            SizedBox(height: 5.w),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.4,
                                              child: Text(
                                                i.packageServices![0].serviceName.toString(),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 9.5.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                  AppColor.lightButtonColor,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Visibility(
                                              visible:i.packageOfferPrice == null || i.packageOfferPrice ==""
                                                  ? false
                                                  : true,
                                              child: Text(
                                                "SAR  ${i.packagePrice}",
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 11.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColor
                                                        .lightButtonColor,
                                                    decoration: TextDecoration
                                                        .lineThrough),
                                              ),
                                            ),
                                            Visibility(
                                              visible: i.packageOfferPrice == null
                                                  ? false
                                                  : true,
                                              child: Text(
                                                "SAR  ${i.packageOfferPrice}",
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColor.appColor,
                                                ),
                                              ),
                                            ),
                                            Visibility(
                                              visible: i.packageOfferPrice == null
                                                  ? true
                                                  : false,
                                              child: Text(
                                                "SAR  ${i.packagePrice}",
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColor.appColor,
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ));
                    },
                  );
                }).toList(),
              );
            }),
      ],
    );
  }


  CarouselOptions getOptions() {
    return CarouselOptions(
      height: 180,
      aspectRatio: 16 / 9,
      viewportFraction: 1,
      initialPage: 0,
      enableInfiniteScroll: false,
      reverse: false,
      autoPlay: true,
      autoPlayInterval: const Duration(seconds: 3),
      autoPlayAnimationDuration: const Duration(milliseconds: 800),
      autoPlayCurve: Curves.fastOutSlowIn,
      enlargeCenterPage: true,
      onPageChanged: (position, reason){

      },
      scrollDirection: Axis.horizontal,
    );
  }

}


class ServiceListData {
  final int? id;
  final String? name;
  final String? service_price;
  final String? service_offer_price;

  ServiceListData({
    this.id,
    this.name,
    this.service_price,
    this.service_offer_price,
  });
  ServiceListData.fromMap(Map map) :
        this.id = map['id'],
        this.name = map['name'],
        this.service_price= map['service_price'],
        this.service_offer_price= map['service_offer_price'];


}
double parseAmount(dynamic dAmount){

  double returnAmount = 0.00;
  String strAmount;

  try {

    if (dAmount == null || dAmount == 0) return 0.0;

    strAmount = dAmount.toString();

    if (strAmount.contains('.')) {
      returnAmount = double.parse(strAmount);
    }else{
      returnAmount = double.parse(strAmount);
      // Didn't need else since the input was either 0, an integer or a double
    }
  } catch (e) {
    return 0.0;
  }

  return returnAmount;
}