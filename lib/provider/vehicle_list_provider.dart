import 'dart:async';
import 'dart:convert';
import 'package:famous_steam_user/const/config.dart';
import 'package:famous_steam_user/const/prefKeys.dart';
import 'package:famous_steam_user/model/data_not_found.model.dart';
import 'package:famous_steam_user/model/vehicle_list_model.dart';
import 'package:http/http.dart' as http;

class VehiclelistApi {
  Future<dynamic> onvehiclelistApi(String category_id) async {
    try {
      // final uri = Uri.parse(Config.apiurl + Config.vehiclelist);
      String uri='';
      if(category_id=='') {
        uri = Uri.parse(Config.apiurl + 'user-vehicle').toString();
      }

      else {
        uri = Uri.parse(
            Config.apiurl + 'user-vehicle?category_id=' + category_id).toString();
      }


      Map<String, String>  requestHeaders = {
        'Accept-Language': '${PrefObj.preferences!.get(PrefKeys.LANG)}',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${PrefObj.preferences!.get(PrefKeys.TOKEN)}'
      };



      final response = await http.get( Uri.parse(uri), headers: requestHeaders);

      if (Config.isDebug) {
        print('url---- $uri');
        print('post---- $requestHeaders');
        print('res---- '+json.decode(response.body).toString());
      }
      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        return VehicleListModel.fromJson(responseJson);
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

final vehiclelistApi = VehiclelistApi();
