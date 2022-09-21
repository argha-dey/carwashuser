import 'dart:async';
import 'dart:convert';
import 'package:famous_steam_user/const/config.dart';
import 'package:famous_steam_user/model/data_not_found.model.dart';
import 'package:famous_steam_user/model/get_address_by_id_model.dart';
import 'package:http/http.dart' as http;

class GetaddressbyidApi {
  Future<dynamic> ongetaddressbyidApi() async {
    try {
      final uri = Uri.parse(Config.apiurl + Config.getaddressbyyid);

      final response =
          await http.post(uri, headers: {'content-Type': 'application/json'});
      if (Config.isDebug) {
        print('url---- $uri');
     //   print('post---- $postData');
        print('res---- '+json.decode(response.body).toString());
      }
      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        return GetaddressbyidModel.fromJson(responseJson);
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

final getaddressbyidApi = GetaddressbyidApi();
