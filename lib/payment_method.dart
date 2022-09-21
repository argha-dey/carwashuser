import 'dart:io';



import 'package:famous_steam_user/model/package_index_model.dart';
import 'package:famous_steam_user/track_Order.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
/*import 'package:myfatoorah_flutter/embeddedapplepay/MFApplePayButton.dart';
import 'package:myfatoorah_flutter/model/initsession/SDKInitSessionResponse.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';
import 'package:myfatoorah_flutter/utils/MFCountry.dart';
import 'package:myfatoorah_flutter/utils/MFEnvironment.dart';*/
import 'package:toast/toast.dart';

import 'Bottombar/bottombar.dart';
import 'Repository/repository.dart';
import 'const/all_direction_navigator.dart';
import 'const/colors.dart';
import 'const/global.dart';
import 'const/prefKeys.dart';
import 'homePage.dart';
import 'localizations/app_localizations.dart';
import 'model/SummeryModel.dart';
import 'model/appointment_model.dart';
import 'model/payment_method_model.dart';
import 'model/payments_status_model.dart';


import 'package:flutter/material.dart';
import 'package:my_fatoorah/my_fatoorah.dart';

import 'model/vehicle_list_model.dart';




class PaymentMethodPage extends StatefulWidget {

  final PackageData selectedPackageData;
  final  List<ServiceListData> selectedExtraServiceData;
  final VehicleDetails selectedvahicleDetails;
  final String slotDate;
  final String slotTime;
  final String addressId;
  final String  address;
  final SummeryModel summeryData;
  final Paymentmethod paymentMode;
  const PaymentMethodPage({Key? key,
    required this.selectedPackageData,
    required this.selectedExtraServiceData,
    required this.selectedvahicleDetails,
    required this.slotDate,
    required this.slotTime,
    required this.addressId,
    required this.address,
    required this.summeryData,
    required this.paymentMode}) : super(key: key);

  // final String title;

  @override
  _PaymentMethodPageState createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {


  Repository repository = Repository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.lightrgrey,
        appBar: AppBar(title: Text('')),
        body: MyFatoorah(
          onResult: (response) {
            print('response payment :---'+response.paymentId.toString());

            if(response.isSuccess){
              Loader().showLoader(context);
              print('response: ${response.paymentId}');
              onServiceBookOnlineAPI(response.paymentId.toString());
            }else{

            }

            print('status:'+response.status.toString());

          },

          afterPaymentBehaviour: AfterPaymentBehaviour.BeforeCallbackExecution,

          // Live
          request: MyfatoorahRequest.live(
              currencyIso: Country.SaudiArabia,
              successUrl: 'https://www.google.com',
              errorUrl: 'https://www.google.com',
              invoiceAmount: double.parse(widget.summeryData.total.toString()),
              language: ApiLanguage.English,

              //Live Key
              token:"OKrHTLXHVvaEF5-f3cGJ0svPVbHQ4staT_78onfBMhrjj5hiZ0D_u_zl7Ty6CJaZAZPDPoMol84tgb6KFsPDXEs7gOjOMONuWVTnAoScCzy3krHUxYKVgneg_Y1JcSFIX_MIfUMotCGrwxzONyQLmtbAiR7exMN4q2JLQpOsuruo7ILRMryNVPcRTM0Riax9tSuqyu8ngHmJBwE522tsbI6b2HmUrM5deSfZvFSD2LUP_YwJSTzBdwdyhUGiOjgzluBtV4JlOTEUCdXC4vXU64xZTxobEBhrg16Rb-NBdki3TqDDSKm7O_vNFOzbh_3fnbYN5pcDk9tIeKCtEJavY-rjymTgNcurv29aIoPJ-g7wqSA-e5MQcUJE43yirOH51w6Rs2n8UIPz1tA3w0UIr7-dPcNv7sQ-i_ld-MiHgeY84jZ8WfHNoRo1kr7aYTotYaX6VWDZBV9xqHpJPIJ0HXE24-kc4QCzUPmt1i4rCoTDRvSLie1htYfk0YzPQ63S6g4nepnZp5jC6SKXEa_HPyvobT-eQ1Mrqq_I7jdsX3mEpQnJDx2VJJ1-zEZEh-GnOPgx-schzLi019XmQjxr7cfMCQZzxOJAqg0L9LdW2Lahmuo688wLdgCEQrx5ThGFlP6FPIDh922pp4j79Rl0mnhked9qa_KEJDKI0tJ_oX18ON1t"

          ),

          // Test
       /*   request: MyfatoorahRequest.test(
              currencyIso: Country.SaudiArabia,
              successUrl: 'https://www.google.com',
              errorUrl: 'https://www.google.com',
              invoiceAmount: double.parse(widget.summeryData.total.toString()),
              language: ApiLanguage.English,

            //Test Key
             token: "rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL"

          ),*/

        ));
  }

  dynamic onServiceBookOnlineAPI(paymentId) async {

    final AppointmentModel appointmentSuccess = await repository.onappointment(
        widget.selectedPackageData,
        widget.selectedExtraServiceData,
        widget.selectedvahicleDetails,
        widget.slotTime,
        widget.slotDate,
        widget.addressId,
        widget.address,
        widget.summeryData,
        widget.paymentMode,
        paymentId
    );
    if (appointmentSuccess.message == 'order create Successfully') {
      Loader().hideLoader(context);
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





Widget paymentErrorFullPage() {


  return Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 170,
            padding: EdgeInsets.all(35),
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              'images/error_payment.png',
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 30),
          Text(
            "Error!",
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.w600,
              fontSize: 36,
            ),
          ),
          SizedBox(height: 30),
          Text(
            "Payment Not Done",
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w400,
              fontSize: 17,
            ),
          ),
          SizedBox(height: 30),
          Text(
            "Click to back page",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 30),
/*          Flexible(
         *//*   child: HomeButton(
              title: 'Home',
              onTap: () {},
            ),*//*
          ),*/
        ],
      ),
    ),
  );

}




