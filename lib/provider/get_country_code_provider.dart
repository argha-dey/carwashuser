import 'dart:async';
import 'dart:convert';
import 'package:famous_steam_user/const/config.dart';
import 'package:famous_steam_user/model/data_not_found.model.dart';
import 'package:famous_steam_user/model/get_country_code_model.dart';
import 'package:http/http.dart' as http;

class GetcountrycodeApi {
  Future<dynamic> ongetcountrycodeApi() async {
    try {
      final uri = Uri.parse(Config.apiurl + Config.getcountrycode);
      final response = await http.get(uri, headers: {
        'content-Type': 'application/json',
      });

      if (Config.isDebug) {
        print('url---- $uri');
       // print('post---- $postData');
        print('res---- '+json.decode(response.body).toString());
      }
      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        return GetcountrycodeModel.fromJson(responseJson);
      } else if (response.statusCode == 405) {
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

final getcountrycodeApi = GetcountrycodeApi();
