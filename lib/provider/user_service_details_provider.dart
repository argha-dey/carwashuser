import 'dart:async';
import 'dart:convert';
import 'package:famous_steam_user/const/config.dart';
import 'package:famous_steam_user/const/prefKeys.dart';
import 'package:famous_steam_user/model/data_not_found.model.dart';
import 'package:famous_steam_user/model/user_service_details_model.dart';
import 'package:http/http.dart' as http;

class UserservicedetailsApi {
  Future<dynamic> onuserservicedetailsApi(String lang, String orderid) async {
    try {
      final uri = Uri.parse(Config.apiurl + Config.userservicedetails);
      dynamic postData = {
        'lang': PrefObj.preferences!.get(PrefKeys.LANG),
        'orderid': orderid,
      };

      final response = await http.post(
        uri,
        body: json.encode(postData),
        headers: {
          'content-Type': 'application/json',
          'Authorization': 'Bearer ${PrefObj.preferences!.get(PrefKeys.TOKEN)}'
        },
      );
      if (Config.isDebug) {
        print('url---- $uri');
        print('post---- $postData');
        print('res---- '+json.decode(response.body).toString());
      }
      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        return UserservicedetailsModel.fromJson(responseJson);
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

final userservicedetailsApi = UserservicedetailsApi();
