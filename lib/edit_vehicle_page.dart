import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:famous_steam_user/bloc/year_list_by_size_bloc.dart';
import 'package:famous_steam_user/const/prefKeys.dart';
import 'package:famous_steam_user/model/model_list_by_brand.dart';
import 'package:famous_steam_user/model/size_list_by_model.dart';
import 'package:famous_steam_user/model/vehicle_list_by_cetegory_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'Repository/repository.dart';
import 'bloc/category_list_bloc.dart';
import 'bloc/data_bycategory_block.dart';
import 'bloc/get_fuel_bloc.dart';
import 'bloc/model_list_by_brand_bloc.dart';
import 'bloc/size_list_by_model_bloc.dart';
import 'bloc/vehicle_list_by_cetegory_bloc.dart';
import 'const/colors.dart';
import 'const/global.dart';
import 'localizations/app_localizations.dart';
import 'model/add_vehicle_model.dart';
import 'model/category_list_model.dart';
import 'model/data_bycategory_model.dart';
import 'model/get_fuel_model.dart';
import 'model/year_list_data_model.dart';

class Editvehiclepage extends StatefulWidget {
  final ScreenType screenType;
  final Function? isBack;

  final String? brandId;
  final String? modelid;
  final String? fuelId;
  final String? sizeId;
  final String? vehiclesid;
  final String? categoryId;
  final String? yearId;

  final String?  categoryName;
  final String? sizeName;
  final String? modelName;
  final String? brandName;
  final String? fuelName;
  final String? yearName;
  Editvehiclepage({
    Key? key,
    this.isBack,
    required this.screenType,
    this.brandId,
    this.modelid,
    this.fuelId,
    this.sizeId,
    this.vehiclesid,
    this.categoryId,
    this.yearId,

    this.categoryName,
    this.sizeName,
    this.modelName,
    this.brandName,
    this.fuelName,
    this.yearName,
  }) : super(key: key);




  @override
  State<Editvehiclepage> createState() => _EditvehiclepageState();
}

class _EditvehiclepageState extends State<Editvehiclepage> {

  String? _brandId;
  String? _modelid;
  String? _fuelId;
  String? _sizeId;
  String? _vehiclesid;
  String? _categoryId;
  String? _yearId;

  String?   _categoryName;
  String? _sizeName;
  String? _modelName;
  String? _brandName;
  String? _fuelName;
  String? _yearName;

  bool checkExpansionTile = false;
  bool checkfueltype = true;
  final GlobalKey<ExpansionTileCardState> brandKeys = GlobalKey();
  final GlobalKey<ExpansionTileCardState> sizeKeys = GlobalKey();
  final GlobalKey<ExpansionTileCardState> carModelKeys = GlobalKey();
  final GlobalKey<ExpansionTileCardState> carYearKeys = GlobalKey();
  final repository = Repository();

  String dropValueBrand = 'Select Brand';
  String dropValueModel = 'Select Model';
  String dropValueSize = 'Select Size';
  String dropValueYear = 'Select Year';

  int seletectIndex = 0;

  List<VehicleData>? users;
  VehicleData? selectedUser;




  setSelectedUser(VehicleData user) {
    setState(() {
      selectedUser = user;
    });
  }

  @override
  void initState() {
    super.initState();

    selectedUser = VehicleData(id:widget.categoryId,name: widget.categoryName);
    dropValueBrand = widget.brandName!;
    dropValueModel = widget.modelName!;
    dropValueSize = widget.sizeName!;
    dropValueYear = widget.yearName!;
    _categoryId = widget.categoryId;
    _brandId =  widget.brandId;
    _sizeId = widget.sizeId;
    _vehiclesid = widget.vehiclesid;
    _fuelId = widget.fuelId;
    _modelid = widget.modelid;
    _yearId = widget.yearId;
    _yearName = widget.yearName;

    seletectIndex = int.parse(_fuelId.toString()) - 1;

    getfuelbloc.getFuelsink('');
    categoryListbloc.categorylistsink('');



    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        vehiclelbrandlistbycategorybloc.vehiclelbrandlistbycategorysink('eng',widget.categoryId!);
      });

    });
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {

        vehiclelmodellistbybrandbloc.vehiclelmodellistbybrandsink(PrefObj.preferences!.get(PrefKeys.LANG),widget.categoryId!, widget.brandId!);
      });

    });
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        vehiclelsizelistbymodelbloc.vehiclelsizelistbymodelsink(PrefObj.preferences!.get(PrefKeys.LANG),widget.categoryId!, widget.brandId!,widget.modelid!);
      });

    });

    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        vehiclelyearlistbysizebloc.vehiclelYearlistbySizesink(PrefObj.preferences!.get(PrefKeys.LANG),widget.categoryId!, widget.brandId!,widget.modelid!,widget.sizeId);
      });

    });
  }



  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightrgrey,
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (notification) {
          notification.disallowGlow();
          return true;
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(right: 15.w, left: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40.w),
                appbarWidget(context, _key),
                SizedBox(height: 10.w),
                Text(
                    Translation.of(context)!.translate('Edit Vehicle Details')!,
                  style: GoogleFonts.montserrat(
                    textStyle:
                    const TextStyle(fontSize: 20, color: Color(0xff004471)),
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  Translation.of(context)!.translate('selectvehicle')! ,
                  style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColor.blackColor,
                      )),
                ),
                radioButton(),
                SizedBox(height: 20.w),
                brandSelectDropdown(),
                SizedBox(height: 20.w),
                modelSelectDropdown(),
                SizedBox(height: 20.w),
                sizeSelectDropdown(),
                SizedBox(height: 20.w),
                yearSelectDropdown(),
                SizedBox(height: 30.w),
                selectfuelText(),
                SizedBox(height: 20.w),
                selectfuel(),
                SizedBox(height: 20.w),
                button(),
                SizedBox(height: 20.w),
              ],
            ),
          ),
        ),
      ),
    );
  }




  Widget radioButton() {
    return StreamBuilder<CategoryListModel>(
      stream: categoryListbloc.categoryliststream,
      builder:
          (context, AsyncSnapshot<CategoryListModel> categorylistsnapshot) {
        if (!categorylistsnapshot.hasData) {
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
        users = categorylistsnapshot.data!.data!;

        return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: users!.map((data) => RadioListTile(
              value: data.name.toString(),
              groupValue: selectedUser!.name,
              onChanged: (value) {
                setState(() {

                users!.forEach((mapData) {
                  if (mapData.name == value.toString()) {
                    setSelectedUser(VehicleData(id:mapData.id.toString(),name: mapData.name.toString()));
                  }
                });


                });
                dropValueBrand = Translation.of(context)!.translate('selectbrand')!;
                dropValueModel = Translation.of(context)!.translate('selectmodel')!;
                dropValueSize = Translation.of(context)!.translate('selectsize')!;
                dropValueYear = Translation.of(context)!.translate('selectyear')!;
                vehiclelbrandlistbycategorybloc.vehiclelbrandlistbycategorysink('eng',selectedUser!.id.toString());

              },

              title: new Text(
                data.name.toString(),
              ),
            ))
                .toList(),
          );


      },
    );
  }







  Widget brandSelectDropdown() {
    return StreamBuilder<VehiclelbrandlistbycategoryModel>(
      stream: vehiclelbrandlistbycategorybloc.vehiclelistbycategorystream,
      builder:
          (context, AsyncSnapshot<VehiclelbrandlistbycategoryModel> vehiclelbrandlistbycategorysnapshot) {
        if (!vehiclelbrandlistbycategorysnapshot.hasData) {
          return Center(

          );
        }


        return Container(
          width: MediaQuery.of(context).size.width - 10,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            color: Colors.white,
            border: Border.all(),
          ),
          child: ExpansionTileCard(
            key: brandKeys,
            baseColor: Colors.transparent,
            shadowColor: Colors.transparent,
            initiallyExpanded: checkExpansionTile,
            onExpansionChanged: (value) {
              setState(() {
                checkExpansionTile = value;
                // print(checkExpansionTile);
              });

              setState(() {});
            },
            children: [
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(0),
                  shrinkWrap: true,
                  itemCount: vehiclelbrandlistbycategorysnapshot.data!.vehicles!.isNotEmpty
                      ? vehiclelbrandlistbycategorysnapshot.data!.vehicles!.length
                      : 1,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        brandKeys.currentState?.collapse();
                        dropValueModel =
                        Translation.of(context)!.translate('selectmodel')!;
                        dropValueSize =
                        Translation.of(context)!.translate('selectsize')!;
                        dropValueYear = Translation.of(context)!.translate('selectyear')!;
                        _brandId = vehiclelbrandlistbycategorysnapshot.data!.vehicles![index].brandId.toString();
                        dropValueBrand = vehiclelbrandlistbycategorysnapshot.data!.vehicles![index].brand.toString();
                        vehiclelmodellistbybrandbloc.vehiclelmodellistbybrandsink(PrefObj.preferences!.get(PrefKeys.LANG),_categoryId!, _brandId!);
                        setState(() {});
                      },
                      title:vehiclelbrandlistbycategorysnapshot.data!.vehicles!.isNotEmpty
                          ? Text(
                          vehiclelbrandlistbycategorysnapshot.data!.vehicles![index].brand.toString(),
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
                  })
            ],
            title: Text(
              dropValueBrand,
              style: TextStyle(fontFamily: 'Poppins1', fontSize: 15.sp),
            ),
          ),
        );
      },
    );
  }


  Widget modelSelectDropdown() {
    return StreamBuilder<VehiclelmodellistbybrandModel>(
      stream: vehiclelmodellistbybrandbloc.vehiclemodellistbybrandstream,
      builder:
          (context, AsyncSnapshot<VehiclelmodellistbybrandModel> vehiclelmodellistbybrandsnapshot) {
        if (!vehiclelmodellistbybrandsnapshot.hasData) {
          return Center(
            /*      child: SizedBox(
              height: 100.h,
              width: 100.w,
              child: Lottie.asset(
                'images/102766-error.json',
              ),
            ),*/
          );
        }
        return  Container(
          // height: 60,
          width: MediaQuery.of(context).size.width - 10,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            color: Colors.white,
            border: Border.all(),
          ),
          child: ExpansionTileCard(
            key: carModelKeys,
            baseColor: Colors.transparent,
            shadowColor: Colors.transparent,
            initiallyExpanded: checkExpansionTile,
            onExpansionChanged: (value) {
              setState(() {
                checkExpansionTile = value;
              });
              setState(() {});
            },
            title: Text(
              dropValueModel,
              style: TextStyle(fontFamily: 'Poppins1', fontSize: 15.sp),
            ),
            children: [
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(0),
                shrinkWrap: true,
                itemCount:  vehiclelmodellistbybrandsnapshot.data!.vehicleModelList!.isNotEmpty
                    ? vehiclelmodellistbybrandsnapshot.data!.vehicleModelList!.length
                    : 1,
                itemBuilder: (context, index) => ListTile(
                  onTap: () {
                    carModelKeys.currentState?.collapse();
                    dropValueSize = Translation.of(context)!.translate('selectsize')!;
                    dropValueYear = Translation.of(context)!.translate('selectyear')!;
                    _modelid = vehiclelmodellistbybrandsnapshot.data!.vehicleModelList![index].car_model_id.toString();
                    dropValueModel = vehiclelmodellistbybrandsnapshot.data!.vehicleModelList![index].model_name.toString();
                    vehiclelsizelistbymodelbloc.vehiclelsizelistbymodelsink(PrefObj.preferences!.get(PrefKeys.LANG),_categoryId, _brandId,_modelid!);
                    setState(() {});
                  },
                  title: vehiclelmodellistbybrandsnapshot.data!.vehicleModelList!.isNotEmpty
                      ? Text(
                    vehiclelmodellistbybrandsnapshot.data!.vehicleModelList![index].model_name.toString(),
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColor.blackColor,
                      ),
                    ),
                  )
                      : Center(
                    child: Text(
                      Translation.of(context)!.translate("No Data Found")!,
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColor.blackColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }


  Widget sizeSelectDropdown() {
    return StreamBuilder<VehiclelsizelistbybrandModel>(
      stream: vehiclelsizelistbymodelbloc.vehiclesizelistbymodelstream,
      builder:
          (context, AsyncSnapshot<VehiclelsizelistbybrandModel> vehiclelsizelistbymodelsnapshot) {
        if (!vehiclelsizelistbymodelsnapshot.hasData) {
          return Center(
            /*   child: SizedBox(
              height: 100.h,
              width: 100.w,
              child: Lottie.asset(
                'images/102766-error.json',
              ),
            ),*/
          );
        }
        return  Container(
          // height: 60,
          width: MediaQuery.of(context).size.width - 10,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            color: Colors.white,
            border: Border.all(),
          ),
          child: ExpansionTileCard(
            key: sizeKeys,
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
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(0),
                shrinkWrap: true,
                itemCount:  vehiclelsizelistbymodelsnapshot.data!.vehicleSizeList!.isNotEmpty
                    ? vehiclelsizelistbymodelsnapshot.data!.vehicleSizeList!.length
                    : 1,
                itemBuilder: (context, index) => ListTile(
                  onTap: () {
                    sizeKeys.currentState?.collapse();
                    dropValueYear = Translation.of(context)!.translate('selectyear')!;
                    _sizeId = vehiclelsizelistbymodelsnapshot.data!.vehicleSizeList![index].car_size_id
                        .toString();
                    setState(() {
                      dropValueSize =
                          vehiclelsizelistbymodelsnapshot.data!.vehicleSizeList![index].size_name.toString();
                    });
                  },
                  title: vehiclelsizelistbymodelsnapshot.data!.vehicleSizeList!.isNotEmpty
                      ? Text(
                    vehiclelsizelistbymodelsnapshot.data!.vehicleSizeList![index].size_name.toString(),
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColor.blackColor,
                      ),
                    ),
                  )
                      : Center(
                    child: Text(
                      Translation.of(context)!.translate("No Data Found")!,
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColor.blackColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
            title: Text(
              dropValueSize,
              style: TextStyle(fontFamily: 'Poppins1', fontSize: 15.sp),
            ),
          ),
        );
      },
    );
  }

  Widget yearSelectDropdown() {
    return StreamBuilder<YearListDataModel>(
      stream: vehiclelyearlistbysizebloc.vehiclesizelistbymodelstream,
      builder:
          (context, AsyncSnapshot<YearListDataModel> vehiclelyearlistbysizesnapshot) {
        if (!vehiclelyearlistbysizesnapshot.hasData) {
          return Center(
            /*   child: SizedBox(
              height: 100.h,
              width: 100.w,
              child: Lottie.asset(
                'images/102766-error.json',
              ),
            ),*/
          );
        }
        return  Container(
          // height: 60,
          width: MediaQuery.of(context).size.width - 10,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            color: Colors.white,
            border: Border.all(),
          ),
          child: ExpansionTileCard(
            key: carYearKeys,
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
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(0),
                shrinkWrap: true,
                itemCount:  vehiclelyearlistbysizesnapshot.data!.data!.isNotEmpty
                    ? vehiclelyearlistbysizesnapshot.data!.data!.length
                    : 1,
                itemBuilder: (context, index) => ListTile(
                  onTap: () {
                    carYearKeys.currentState?.collapse();
                    _yearId = vehiclelyearlistbysizesnapshot.data!.data![index].yearId
                        .toString();
                    setState(() {
                      dropValueYear =
                          vehiclelyearlistbysizesnapshot.data!.data![index].yearName.toString();
                    });
                  },
                  title: vehiclelyearlistbysizesnapshot.data!.data!.isNotEmpty
                      ? Text(
                    vehiclelyearlistbysizesnapshot.data!.data![index].yearName.toString(),
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColor.blackColor,
                      ),
                    ),
                  )
                      : Center(
                    child: Text(
                      Translation.of(context)!.translate("No Data Found")!,
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColor.blackColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
            title: Text(
              dropValueYear,
              style: TextStyle(fontFamily: 'Poppins1', fontSize: 15.sp),
            ),
          ),
        );
      },
    );
  }




  Widget selectfuelText() {
    return Visibility(
      visible: checkfueltype,
      child: Text(
        Translation.of(context)!.translate('selectfuel')!,
        style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColor.blackColor)),
      ),
    );
  }

  Widget selectfuel() {
    return Visibility(
      visible: checkfueltype,
      child: StreamBuilder<GetFuelModel>(
          stream: getfuelbloc.getFuelstream,
          builder: (context, AsyncSnapshot<GetFuelModel> getFuelsnapshot) {
            if (!getFuelsnapshot.hasData) {
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
              height: 120.w,
              child: ListView.builder(
                itemCount: getFuelsnapshot.data!.data!.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {

                  return GestureDetector(
                    onTap: () {
                      seletectIndex = index;
                      _fuelId = getFuelsnapshot.data!.data![index].id.toString();

                      setState(() {});
                    },
                    child: Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                color: seletectIndex == index
                                    ? const Color(0xff004471)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(500),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade700,
                                    blurRadius: 5.0,
                                    spreadRadius: 0.2,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Image.asset(
                                  fuleType(
                                      getFuelsnapshot.data!.data![index].name!),
                                  color: seletectIndex != index
                                      ? const Color(0xff004471)
                                      : Colors.white,
                                ),
                              ),
                            )

                        ),
                        Text(
                          getFuelsnapshot.data!.data![index].name.toString(),
                          style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.appColor)),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }),
    );
  }

  String fuleType(String type) {

    String icon ="";
    switch (type) {
      case 'Petrol':
        icon = 'images/fule.png';
        break;
      case 'Diesel':
        icon = 'images/diesel.png';
        break;
      case 'بنزين':
        icon = 'images/fule.png';
        break;
      case 'ديزل':
        icon = 'images/diesel.png';
        break;
    }
    return icon;
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
        child: Text(
          Translation.of(context)!.translate('Save vehicle')!,
          style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: AppColor.whiteColor,
              )),
        ),
        onPressed: () {
          onAddvehicleAPI();
        },
      ),
    );
  }
  /*591316132*/

  dynamic onAddvehicleAPI() async {
    // show loader
    Loader().showLoader(context);
    final AddvehicleModel isAddvehicle = await repository.onaddvehicleApi(
      _categoryId!,
      _fuelId!,
      _sizeId!,
      _brandId!,
      widget.screenType,
      _vehiclesid!,
      _modelid!,
      _yearId!,
    );

    FocusScope.of(context).requestFocus(FocusNode());
    Loader().hideLoader(context);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text(
              isAddvehicle.message.toString(),
              style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff128807))),
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
                      textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColor.whiteColor)),
                ),
                onPressed: () {
                  widget.isBack!(true);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(
              width: 100,
            ),
          ],
        );
      },
    );
  }

}