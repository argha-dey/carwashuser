import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:famous_steam_user/const/config.dart';
import 'package:famous_steam_user/const/global.dart';
import 'package:famous_steam_user/const/prefKeys.dart';
import 'package:famous_steam_user/homePage.dart';
import 'package:famous_steam_user/model/SummeryModel.dart';
import 'package:famous_steam_user/model/add_vehicle_model.dart';
import 'package:famous_steam_user/model/data_not_found.model.dart';
import 'package:famous_steam_user/model/package_index_model.dart';
import 'package:famous_steam_user/model/vehicle_list_model.dart';
import 'package:http/http.dart' as http;


class GetSummaryApi {


  Future<dynamic> onGetSummaryApi(
      PackageData selectedPackageData,
      List<ServiceListData> selectedExtraServiceData,
      VehicleDetails selectedvahicleDetails,
      String slotTime,
      String slotDate,
      String addressId) async {

    try {
      List<dynamic> values = [];


      for( int i=0;i<selectedExtraServiceData.length;i++){
        values.add(selectedExtraServiceData[i].id);
      }



   //   List<String> stringList = (jsonDecode(values) as List<dynamic>).cast<String>();

  //      result = values.map((val) => val.trim()).join(',');

  //    result = "[$result]";
  //    var tagsJson = jsonDecode(result);
   //   List<int>? tags = tagsJson != null ? List.from(tagsJson) : null;
  //    print(tags);

 //var extraServiceIds = List.from(values);


      //"extra_service_ids":[],
   //   print("joint list => "+result);





      Map<String,dynamic>  requestPostData = <String, dynamic>{

        "category_id":selectedvahicleDetails.category!.categoryId,
        "brand_id":selectedvahicleDetails.brand!.brandId,
        "car_model_id":selectedvahicleDetails.carModel!.carModelId,
        "car_size_id":selectedvahicleDetails.carSize!.carSizeId,
        "package_id":selectedPackageData.packageId,
        "extra_service_ids":List<dynamic>.from(values.map((x) => x)),
        "vehicle_id":selectedvahicleDetails.userVehicleId,
        "timeslot_id":slotTime,
        "appointment_date":slotDate,
        "user_address_id":addressId
      };


      var _body = json.encode(requestPostData);
      print("request_json=$_body");

      Map<String, String>  requestHeaders = {
        'Accept-Language': '${PrefObj.preferences!.get(PrefKeys.LANG)}',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${PrefObj.preferences!.get(PrefKeys.TOKEN)}'
      };

      final uri = Uri.parse(Config.apiurl + "order/summery");



      final  response  = await http.post(
          uri,
          headers: requestHeaders,
          body: _body,
      );


      dynamic responseJson;
      if (response.statusCode == 200) {
        return  SummeryModel.fromJson(json.decode(response.body));
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





final getSummaryApi = GetSummaryApi();

