import 'dart:async';
import 'dart:convert';
import 'package:famous_steam_user/const/config.dart';
import 'package:famous_steam_user/const/prefKeys.dart';
import 'package:famous_steam_user/model/data_not_found.model.dart';
import 'package:famous_steam_user/model/delete_vehicle_model.dart';
import 'package:http/http.dart' as http;

class DeletevehicleApi {
  Future<dynamic> ondeletevehicleApi(String _vehicleid) async {


    try {

      final  uri = Uri.parse(Config.apiurl + "user-vehicle/"+_vehicleid).toString();

      print('url---- $uri');

      Map<String, String>  requestHeaders = {
        'Accept-Language': '${PrefObj.preferences!.get(PrefKeys.LANG)}',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${PrefObj.preferences!.get(PrefKeys.TOKEN)}'
      };







      if (Config.isDebug) {
        print('url---- $uri');
        print('post---- $requestHeaders');

      }


      final response = await http.delete( Uri.parse(uri), headers: requestHeaders);

      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        return DeletevehicleModel.fromJson(responseJson);
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

final deletevehicleApi = DeletevehicleApi();
