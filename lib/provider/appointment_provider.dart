
import 'dart:async';
import 'dart:convert';
import 'package:famous_steam_user/const/config.dart';
import 'package:famous_steam_user/homePage.dart';
import 'package:famous_steam_user/model/SummeryModel.dart';
import 'package:famous_steam_user/model/appointment_model.dart';
import 'package:famous_steam_user/model/data_not_found.model.dart';
import 'package:famous_steam_user/model/package_index_model.dart';
import 'package:famous_steam_user/model/payment_method_model.dart';
import 'package:famous_steam_user/model/vehicle_list_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../const/prefKeys.dart';

class AppointmentApi {
  Future<dynamic> onappointmentApi(
      PackageData selectedPackageData,
      List<ServiceListData> selectedExtraServiceData,
      VehicleDetails selectedvahicleDetails,
      String slotTime,
      String slotDate,
      String addressId,
       String  address,
      SummeryModel  summeryData,
      Paymentmethod  selectPaymentMode,
      String paymentId,
      ) async {
    try {
      final uri = Uri.parse(Config.apiurl + 'order');

      List<dynamic> total_service_ids = [];

      List<dynamic> extra_service_ids = [];
      for( int i=0;i<selectedExtraServiceData.length;i++){
        extra_service_ids.add(selectedExtraServiceData[i].id);
        total_service_ids.add(selectedExtraServiceData[i].id);
      }

      List<dynamic> package_service_ids = [];
      for( int j=0;j<selectedPackageData.packageServices!.length;j++){
        package_service_ids.add(selectedPackageData.packageServices![j].serviceId);
        total_service_ids.add(selectedPackageData.packageServices![j].serviceId);
      }

      var now = new DateTime.now();
   //   var formatter = new DateFormat('dd-MM-yyyy');
      var formatter = new DateFormat('yyyy-MM-dd');
      String todayPaymentDate = formatter.format(now);
      final appointmentlotDate = formatter.format(DateTime.parse(slotDate.toString()));




      var paymentStatus = "";
      if(selectPaymentMode.id=="cash"){
        paymentStatus = 'pending';
      }else{
        paymentStatus = 'complete';
      }



      Map<String,dynamic>  requestPostData = <String, dynamic>{
        'category_id':selectedvahicleDetails.category!.categoryId,
        'brand_id':selectedvahicleDetails.brand!.brandId,
        'year_id':selectedvahicleDetails.year!.yearId,
        'car_size_id':selectedvahicleDetails.carSize!.carSizeId,
        'car_model_id':selectedvahicleDetails.carModel!.carModelId,
        'appointment_date':appointmentlotDate,
        'timeslot_id':slotTime,
        'slot_start_time':summeryData.slotStartTime,
        'slot_end_time':summeryData.slotEndTime,
        'package_id':selectedPackageData.packageId,
        'vehicle_id':selectedvahicleDetails.userVehicleId,

        'entry_from':'APP',
        'package_service_ids':List<dynamic>.from(package_service_ids.map((x) => x)),
        'extra_service_ids':List<dynamic>.from(extra_service_ids.map((x) => x)),
        'total_service_ids':List<dynamic>.from(total_service_ids.map((x) => x)),
        'time_duration':summeryData.timeDuration,
        'pickup_address':address,
        'user_address_id':addressId,
        'package_price':selectedPackageData.packagePrice,
        'package_offer_price':selectedPackageData.packageOfferPrice,
        'total_extra_service_price':summeryData.totalExtraServicePrice,
        'payment_status':paymentStatus,
        'payment_mode':selectPaymentMode.slug,
        'payment_date':todayPaymentDate,
        'total_amount':summeryData.total,
        "sub_total": summeryData.total,
        "tax": "0",
        "payment_id":paymentId
      };


      Map<String, String>  requestHeaders = {
        'Accept-Language': '${PrefObj.preferences!.get(PrefKeys.LANG)}',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${PrefObj.preferences!.get(PrefKeys.TOKEN)}'
      };

      var _body = json.encode(requestPostData);

      print("request_json=$_body");

      final response = await http.post(uri, body: _body, headers: requestHeaders);



      if (Config.isDebug) {
        print('url---- $uri');

        print('res---- '+json.decode(response.body).toString());
      }

      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        return AppointmentModel.fromJson(responseJson);
      } else if (response.statusCode == 404) {
        responseJson = json.decode(response.body);
        return DataNotFoundModel.fromJson(responseJson);
      } else {
        return null;
      }
    } catch (exception) {
      print('exception---- $exception');
      return null;
    }
  }
}

final appointmentApi = AppointmentApi();
