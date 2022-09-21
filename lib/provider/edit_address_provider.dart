import 'dart:convert';

import 'package:famous_steam_user/const/config.dart';
import 'package:famous_steam_user/const/prefKeys.dart';
import 'package:famous_steam_user/model/data_not_found.model.dart';
import 'package:famous_steam_user/model/edit_address_model.dart';
import 'package:http/http.dart' as http;

class EditAddressApi {
  Future<dynamic> onEditAddressApi(
      String addressid,
      String addline1,
      String addline2,
      String city,
      String landmark,
      String zip,
      String latitude,
      String longitude,
      ) async {
    try {
      final uri = Uri.parse(Config.apiurl + 'user-address/'+addressid);



      Map<String, String>  requestHeaders = {
        'Accept-Language': '${PrefObj.preferences!.get(PrefKeys.LANG)}',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${PrefObj.preferences!.get(PrefKeys.TOKEN)}'
      };
      Map<String,dynamic>  requestPostData = <String, dynamic>{

        "add_line1": addline1,
        "latitude": latitude,
        "longitude": longitude,


      };

      final response = await http.put(
          uri,
          body: requestPostData,
          headers:requestHeaders
      );

      if (Config.isDebug) {
        print('url---- $uri');
        print('post---- $requestPostData');
        print('res---- '+json.decode(response.body).toString());
      }
      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        return EditAdderssModel.fromJson(responseJson);
      } else if (response.statusCode == 301) {
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
