
import 'package:famous_steam_user/Repository/repository.dart';
import 'package:famous_steam_user/const/global.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:google_fonts/google_fonts.dart';

import '../const/colors.dart';
import '../const/textfieldData.dart';
import '../model/edit_address_model.dart';

// ignore: must_be_immutable
class EditAdderssPage extends StatefulWidget {
  EditAdderssPage({Key? key, this.editaddress,this.addressId}) : super(key: key);
  String? editaddress;
  String? addressId;

  @override
  State<EditAdderssPage> createState() => _EditAdderssPageState();
}

class _EditAdderssPageState extends State<EditAdderssPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController addline1Controller = TextEditingController();
  FocusNode addlineNodes = FocusNode();
  TextEditingController addline2Controller = TextEditingController();
  FocusNode addlineNodes1 = FocusNode();
  TextEditingController landmarkController = TextEditingController();
  FocusNode landmarkNodes = FocusNode();
  TextEditingController cityController = TextEditingController();
  FocusNode cityNodes = FocusNode();
  TextEditingController zipController = TextEditingController();
  FocusNode zipNodes = FocusNode();
  final repository = Repository();
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    addline1Controller.text = widget.editaddress!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.lightrgrey,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 18.w, right: 18.w),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 45.w),
                  appbarWidget(context, _key),
                  SizedBox(height: 30.w),
                  editText(),
                  SizedBox(height: 30.w),
                  textField(),
                  SizedBox(height: 50.w),
                  savebutton(),
                ],
              ),
            ),
          ),
        ));
  }

  Widget editText() {
    return Text(
      "Edit Address",
      style: GoogleFonts.montserrat(
          textStyle: TextStyle(
            color: AppColor.greyColor1,
            fontWeight: FontWeight.w500,
            fontSize: 15.sp,
          )),
    );
  }

  Widget textField() {
    return Column(
      children: [
        CustomTextField(
          ontap: (){},
          onchange: (p0) {},
          controller: addline1Controller,
          labelText: 'New Address',
          hintText: 'New Address',
          validateName: validatevalidAddress1,
          focusNode: addlineNodes1,
          keyboardType: TextInputType.streetAddress,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(FocusNode());
          },
        ),
        SizedBox(height: 25.w),
      ],
    );
  }

  Widget savebutton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            if (formKey.currentState!.validate()) {
              onEditAddressAPI();
            }
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColor.appColor,
              borderRadius: BorderRadius.circular(3),
            ),
            child: Center(
              child: Text(
                'Save',
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
    );
  }

  String? validatevalidAddress1(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Filled Address Line1';
    }
    return null;
  }

  String? validatevalidAddress2(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Filled Address Line2';
    }
    return null;
  }

  String? validatelandmark(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Filled Landmark';
    }
    return null;
  }

  String? validateCity(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Filled City';
    }
    return null;
  }

  String? validateZip(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Filled Zip';
    }
    return null;
  }

  dynamic onEditAddressAPI() async {

    GeoData geoData = await Geocoder2.getDataFromAddress(
        address: addline1Controller.text,
        googleMapApiKey: 'AIzaSyC2x2tslPSu9ewNvPZP1rp_i2MP0a-dfD8');
    var latitude =  geoData.latitude.toString();
    var  longitude = geoData.longitude.toString();
    // show loader
    Loader().showLoader(context);
    final EditAdderssModel isEditAddress = await repository.onEditAddress(
      widget.addressId.toString(),
      addline1Controller.text,
      addline2Controller.text,
      cityController.text,
      landmarkController.text,
      zipController.text,
      latitude,
      longitude,
    );
    if (true) {
      FocusScope.of(context).requestFocus(FocusNode());
      Loader().hideLoader(context);
      showSnackBar(context, isEditAddress.message.toString());
    } else {
      Loader().hideLoader(context);
      showSnackBar(context, isEditAddress.error.toString());
    }
  }
}
