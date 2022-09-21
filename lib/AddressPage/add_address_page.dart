


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_place/google_place.dart';
//import 'package:google_place/google_place.dart';

import '../Repository/repository.dart';
import '../const/colors.dart';
import '../const/global.dart';
import '../const/maps_utils/address_autocomplete_search.dart';
import '../const/maps_utils/address_place_picker.dart';
import '../model/add_address_model.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController _addline1Controller = TextEditingController();
//  FocusNode addlineNodes = FocusNode();

  LatLng? currentPosition;
  String myInputLocation ="";
  Position? currentLocation;
  String? placeId;
  late Placemark _lookup;
  GooglePlace? googlePlace;
  List<AutocompletePrediction> predictions = [];
/*
  Future<Position> locateUser() async {
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
*/

  @override
  void initState() {
    currentPosition = const LatLng(0.0, 0.0);
   googlePlace = GooglePlace('AIzaSyC2x2tslPSu9ewNvPZP1rp_i2MP0a-dfD8');
    super.initState();
  }



  @override
  void dispose() {
    _addline1Controller.dispose();
    super.dispose();

  }

  void clearControllerText(){
    _addline1Controller.clear();

  }

/*  getUserLocation() async {
    currentLocation = await locateUser();
    setState(() {
      currentPosition = LatLng(currentLocation!.latitude, currentLocation!.longitude);
    });
  }*/

  final repository = Repository();
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.lightrgrey,
        appBar: PreferredSize(
            child: Padding(
              padding: const EdgeInsets.only(right: 18, left: 18, top: 40),
              child: appbarWidget(context, _key),
            ),
            preferredSize:  Size(double.infinity, 60)),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 18.w, right: 18.w),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /*   appbarWidget(context, _key),*/
                  SizedBox(height: 30.w),
                  addText(),
                  SizedBox(height: 30.w),
                   //textField(),
                  addressTextField(),
                  addressList(),
                  SizedBox(height: 30.w),
                  loctionbutton(),
                  SizedBox(height: 30.w),
                  savebutton(),
                ],
              ),
            ),
          ),
        ));
  }

  Widget addText() {
    return Text(
      "Add Address",
      style: GoogleFonts.montserrat(
          textStyle: TextStyle(
            color: AppColor.greyColor1,
            fontWeight: FontWeight.w500,
            fontSize: 15.sp,
          )),
    );
  }


 Widget addressTextField(){
    return TextField(
      controller: _addline1Controller,
      decoration: InputDecoration(
        labelText: "Type Address",
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
      ),
      onChanged: (value) {
        if (value.isNotEmpty) {
          autoCompleteSearch(value);
        }else {
          if (predictions.length > 0 && mounted) {
            setState(() {
              predictions = [];
            });
          }
        }
      },
    );
  }


  Widget addressList(){
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: predictions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(predictions[index].description.toString()),
          onTap: () {
            setState(() async {
              _addline1Controller.text = predictions[index].description.toString();
              GeoData geoData = await Geocoder2.getDataFromAddress(
                  address: predictions[index].description.toString(),
                  googleMapApiKey: 'AIzaSyC2x2tslPSu9ewNvPZP1rp_i2MP0a-dfD8');
              latitudefatched =  geoData.latitude.toString();
              longitudefatched = geoData.longitude.toString();
              placemarks = await placemarkFromCoordinates(double.parse(latitudefatched!),double.parse(longitudefatched!));
              _lookup = placemarks![0];
            });
          },
        );
      },

    );
  }


  Future<void> autoCompleteSearch(String value) async {
    var result = await googlePlace!.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted) {
      setState(() {
        predictions = result.predictions!;

      });
    }
  }


/*
 Widget textField() {
    return AutoAddressPlacePicker(
      apiKey: "AIzaSyC2x2tslPSu9ewNvPZP1rp_i2MP0a-dfD8",
      initialPosition: currentPosition!,
      onPicked: (result) async {
        List placemarks = await placemarkFromCoordinates(result.location.lat, result.location.lng);
        print(placemarks);
        Placemark place = placemarks[0];
        latitudefatched = result.location.lat.toString();
        longitudefatched = result.location.lng.toString();
        myInputLocation = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
        print("My Current Location => "+myInputLocation);
        setState(()  {
        });
      },
    );
  }*/

Widget savebutton() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      GestureDetector(
        onTap: () {
          if (formKey.currentState!.validate()) {
            onAddAddressAPI();
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

Widget loctionbutton() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      GestureDetector(
        onTap: () {
          Loader().showLoader(context);
          getCurrentLocation().then((value) {
            setState(() async {
              //  controller.text = location;
              _addline1Controller.text = location;
              Loader().hideLoader(context);
            });
          });
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColor.appColor,
            borderRadius: BorderRadius.circular(3),
          ),
          child: Center(
            child: Text(
              'Current Location',
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

dynamic onAddAddressAPI() async {



  // show loader
  Loader().showLoader(context);
  final AddAddressModel isAddAddress = await repository.onAddAddress(
    _addline1Controller.text,
    latitudefatched!,
    longitudefatched!,
    '',
    '',
    _lookup,
  );

  if (isAddAddress.message=="create Successfully") {
    FocusScope.of(context).requestFocus(FocusNode());
    Loader().hideLoader(context);
    showSnackBar(context, isAddAddress.message.toString());
    clearControllerText();
    Navigator.pop(context);

  } else {
    Loader().hideLoader(context);
    showSnackBar(context, isAddAddress.error.toString());
  }


}


List<Placemark>? placemarks;
String? latitudefatched;
String? longitudefatched;
String location = '';

Future getCurrentLocation() async {
  final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  // print(position);

  latitudefatched = position.latitude.toString();
  longitudefatched = position.longitude.toString();

  placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
  _lookup = placemarks![0];

  location = placemarks != null
      ? '${placemarks![0].street},${placemarks![0].subLocality},${placemarks![0].locality},${placemarks![0].administrativeArea},${placemarks![0].country}'
      : '';


}
}



