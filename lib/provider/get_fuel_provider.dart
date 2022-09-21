import 'dart:async';
import 'dart:convert';
import 'package:famous_steam_user/const/config.dart';
import 'package:famous_steam_user/const/prefKeys.dart';
import 'package:famous_steam_user/model/data_not_found.model.dart';
import 'package:famous_steam_user/model/get_fuel_model.dart';
import 'package:http/http.dart' as http;

class GetfuelApi {
  Future<dynamic> ongetfuelApi(String lang) async {
    try {
     // final uri = Uri.parse(Config.apiurl + Config.getfuel);

      final uri = Uri.parse(Config.apiurl + "fuel");


      Map<String, String>  requestHeaders = {
        'Accept-Language': '${PrefObj.preferences!.get(PrefKeys.LANG)}',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${PrefObj.preferences!.get(PrefKeys.TOKEN)}'
      };



      final response = await http.get(uri,headers: requestHeaders);



      if (Config.isDebug) {
        print('url---- $uri');
        print('post---- $requestHeaders');
        print('res---- '+json.decode(response.body).toString());
      }
      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        return GetFuelModel.fromJson(responseJson);
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

final getfuelApi = GetfuelApi();
