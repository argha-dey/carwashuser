import 'dart:async';
import 'dart:convert';
import 'package:famous_steam_user/const/config.dart';
import 'package:famous_steam_user/const/prefKeys.dart';
import 'package:famous_steam_user/model/data_not_found.model.dart';
import 'package:famous_steam_user/model/get_address_model.dart';
import 'package:http/http.dart' as http;

class GetaddressApi {
  Future<dynamic> ongetaddressApi() async {
    try {

      final uri = Uri.parse(Config.apiurl +'user-address');


      Map<String, String>  requestHeaders = {
        'Accept-Language': '${PrefObj.preferences!.get(PrefKeys.LANG)}',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${PrefObj.preferences!.get(PrefKeys.TOKEN)}'
      };


      final response =  await http.get(uri,headers: requestHeaders);



      if (Config.isDebug) {
        print('url---- $uri');
        print('requestHeaders---- requestHeaders');
        print('res---- '+json.decode(response.body).toString());
      }

      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        return GetaddressModel.fromJson(responseJson);
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

  Future<dynamic> onpostaddressApi(String address) async {
    try {

      final uri = Uri.parse(Config.apiurl +'user-address');


      Map<String, String>  requestHeaders = {
        'Accept-Language': '${PrefObj.preferences!.get(PrefKeys.LANG)}',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${PrefObj.preferences!.get(PrefKeys.TOKEN)}'
      };

      Map<String, String>  requestPostData = {
        'add_line1': address,

      };

      final response =  await http.post(uri,body: requestPostData,headers: requestHeaders);



      if (Config.isDebug) {
        print('url---- $uri');
        print('requestPostData---- ' +json.encode(requestPostData));
        print('requestHeaders---- requestHeaders');
        print('res---- '+json.decode(response.body).toString());
      }

      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        return GetaddressModel.fromJson(responseJson);
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

final getaddressApi = GetaddressApi();
