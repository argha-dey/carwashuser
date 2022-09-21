import 'dart:convert';

import 'package:famous_steam_user/Repository/repository.dart';
import 'package:famous_steam_user/bloc/payment_method_bloc.dart';
import 'package:famous_steam_user/const/colors.dart';
import 'package:famous_steam_user/const/config.dart';
import 'package:famous_steam_user/const/global.dart';
import 'package:famous_steam_user/const/prefKeys.dart';
import 'package:famous_steam_user/homePage.dart';
import 'package:famous_steam_user/localizations/app_localizations.dart';
import 'package:famous_steam_user/model/SummeryModel.dart';
import 'package:famous_steam_user/model/package_index_model.dart';
import 'package:famous_steam_user/model/payment_method_model.dart';
import 'package:famous_steam_user/model/vehicle_list_model.dart';
import 'package:famous_steam_user/payment_method.dart';
import 'package:famous_steam_user/track_Order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:my_fatoorah/my_fatoorah.dart';

import 'const/all_direction_navigator.dart';
import 'model/appointment_model.dart';

class SelectpaymentMethod extends StatefulWidget {
  final PackageData selectedPackageData;
  final  List<ServiceListData> selectedExtraServiceData;
  final VehicleDetails selectedvahicleDetails;
  final String slotDate;
  final String slotTime;
  final String addressId;
  final String  address;
  final SummeryModel summeryData;

  const SelectpaymentMethod(
      {Key? key,
        required this.selectedPackageData,
        required this.selectedExtraServiceData,
        required this.selectedvahicleDetails,
        required this.slotDate,
        required this.slotTime,
        required this.addressId,
        required this.address,
        required this.summeryData
      })
      : super(key: key);

  @override
  State<SelectpaymentMethod> createState() => _SelectpaymentMethodState();
}

class _SelectpaymentMethodState extends State<SelectpaymentMethod> {
  SingingCharacter? _character = SingingCharacter.lafayette;

  Repository repository = Repository();
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final userstr = PrefObj.preferences!.containsKey(PrefKeys.TOKEN)
      ? true
      : false;


  List<Paymentmethod> users = [
    Paymentmethod(id: "1", name: "Payment Gateway", slug: "pg"),
    Paymentmethod(id: "2", name: "Cash On Delivery", slug: "cash")
  ];


  Paymentmethod? selectedPaymentMode;
  int? selectedRadio;
  int? selectedRadioTile;
  String paymentId='';

  @override
  void initState() {
    super.initState();
    if (Config.isDebug) {
      print('page--> SelectpaymentMethod');
    }

    setState(() {
      userstr ? "" : loginButton(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightrgrey,
      key: _key,
      endDrawer: drawer(context),
      appBar: PreferredSize(
          child: Padding(
            padding: const EdgeInsets.only(right: 18, left: 18, top: 40),
            child: appbarWidget(context, _key),
          ),
          preferredSize: const Size(double.infinity, 60)),
      body: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 25.w),
              Text(
                Translation.of(context)!.translate('selectpaymentmethod')!,
                style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      color: const Color(0xff2F2F2F),
                      fontSize: 18.h,
                    )),
              ),
              SizedBox(height: 30.w),
              radioButton(),
              SizedBox(height: 50.w),
              placeBookingButton(),
            ],
          ),
        ),
      ),
    );
  }


  setSelectedUser(Paymentmethod user) {
    setState(() {
      selectedPaymentMode = user;
    });
  }

  List<Widget> createRadioListUsers() {
    List<Widget> widgets = [];
    for (Paymentmethod user in users!) {
      widgets.add(
        Column(
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
                  Radio<Paymentmethod>(
                    value: user,
                    groupValue: selectedPaymentMode,
                    onChanged: (Paymentmethod? currentUser) {
                      print("Current User ${currentUser!.name!}");
                      setSelectedUser(currentUser!);
                      if (currentUser.name!.contains('COD')) {

                      }
                    },
                    activeColor: AppColor.appColor,
                  ),
                  Text(
                   Translation.of(context)!.translate( user.name!)!,
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          fontSize: 14.sp,
                        )),
                  )
                ],
              ),
            ),
            const SizedBox(height: 5),
          ],
        ),
      );
    }
    return widgets;
  }

  Widget radioButton() {
    return Column(
      children: createRadioListUsers(),
    );
  }

  Widget placeBookingButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            if (selectedPaymentMode!.slug == 'cash') {
              onServiceBookAPI();
            } else if (selectedPaymentMode!.slug == 'pg') {
              //  onPaymentCall();

              NavigatorAnimation( context,PaymentMethodPage(
                selectedPackageData: widget.selectedPackageData,
                selectedExtraServiceData: widget.selectedExtraServiceData,
                selectedvahicleDetails: widget.selectedvahicleDetails,
                slotDate: widget.slotDate,
                slotTime: widget.slotTime,
                addressId: widget.addressId,
                address: widget.address,
                summeryData:widget.summeryData!,
                paymentMode: selectedPaymentMode!,
              )).navigateFromRight();

              // onServiceBookByOnlinePayment();
            } else {

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
                Translation.of(context)!.translate('placebooking')!,
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







  dynamic onServiceBookAPI() async {
    Loader().showLoader(context);
    final AppointmentModel appointmentSuccess = await repository.onappointment(
        widget.selectedPackageData,
        widget.selectedExtraServiceData,
        widget.selectedvahicleDetails,
        widget.slotTime,
        widget.slotDate,
        widget.addressId,
        widget.address,
        widget.summeryData,
        selectedPaymentMode!,
        ''
    );
    if (appointmentSuccess.message == 'order create Successfully') {
      FocusScope.of(context).requestFocus(FocusNode());
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Text(
                appointmentSuccess.message.toString(),
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
                    Translation.of(context)!.translate('ok')!,
                    style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColor.whiteColor)),
                  ),
                  onPressed: () {
                    NavigatorAnimation(
                      context,
                      const TrackOderPage(),
                    ).navigateFromRight();
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
    } else {
      Loader().hideLoader(context);
      showSnackBar(context, appointmentSuccess.message.toString());
      PrefObj.preferences!.clear();
      setState(() {});
    }
  }


}
