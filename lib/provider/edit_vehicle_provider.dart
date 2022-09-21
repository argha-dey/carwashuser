import 'dart:async';
import 'dart:convert';
import 'package:famous_steam_user/const/config.dart';
import 'package:famous_steam_user/const/prefKeys.dart';
import 'package:famous_steam_user/model/data_not_found.model.dart';
import 'package:famous_steam_user/model/edit_vehicle_model.dart';
import 'package:http/http.dart' as http;

class AddvehicleApi {
  Future<dynamic> onaddvehicleApi(
      String categoryid, String fuelid, String sizeid, String brandid,String vehicleid) async {
    try {
      final uri = Uri.parse(
          Config.apiurl + Config.editvehicle + '?' + 'tokan=' + PrefKeys.TOKEN);
      dynamic postData = {
        'categoryid': categoryid,
        'fuelid': fuelid,
        'sizeid': sizeid,
        'brandid': brandid,
        'vehicle_id': vehicleid,
      };
      final response = await http.post(uri,
          body: json.encode(postData),
          headers: {'content-Type': 'application/json'});
      if (Config.isDebug) {
        print('url---- $uri');
        print('post---- $postData');
        print('res---- '+json.decode(response.body).toString());
      }
      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        return EdiVehicleModel.fromJson(responseJson);
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
