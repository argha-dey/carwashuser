import 'dart:async';
import 'dart:convert';
import 'package:famous_steam_user/const/config.dart';
import 'package:famous_steam_user/const/global.dart';
import 'package:famous_steam_user/const/prefKeys.dart';
import 'package:famous_steam_user/model/add_vehicle_model.dart';
import 'package:famous_steam_user/model/data_not_found.model.dart';
import 'package:http/http.dart' as http;

class AddvehicleApi {


  Future<dynamic> onaddvehicleApi(
      String categoryid,
      String fuelid,
      String sizeid,
      String brandid,
      ScreenType screenType,
      String vehicleId, String modelId,String yearId) async {

    try {
      Map<String, String>  requestPostData = {
        "category_id": categoryid,
        "fuel_id": fuelid,
        "car_size_id": sizeid,
        "brand_id": brandid,
        "car_model_id": modelId,
        "year_id": yearId,
      };



     // final uri = Uri.parse(Config.apiurl + "user-vehicle");
       final uri = Uri.parse(Config.apiurl + (screenType == ScreenType.add ? "user-vehicle": "user-vehicle/"+vehicleId));


      Map<String, String>  requestHeaders = {
        'Accept-Language': '${PrefObj.preferences!.get(PrefKeys.LANG)}',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${PrefObj.preferences!.get(PrefKeys.TOKEN)}'
      };

      if (Config.isDebug) {
        print('url---- $uri');
        print('post---- $requestPostData');

      }

      final response = screenType == ScreenType.add ? await http.post(
        uri,
        body: requestPostData,
        headers: requestHeaders
      ):await http.put(
          uri,
          body: requestPostData,
          headers: requestHeaders
      );


      if (Config.isDebug) {

        print('res---- '+json.decode(response.body).toString());
      }
      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        return AddvehicleModel.fromJson(responseJson);
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

final addvehicleApi = AddvehicleApi();
