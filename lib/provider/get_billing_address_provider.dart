import 'dart:async';
import 'dart:convert';
import 'package:famous_steam_user/const/config.dart';
import 'package:famous_steam_user/model/data_not_found.model.dart';
import 'package:famous_steam_user/model/get_billing_address_model.dart';
import 'package:http/http.dart' as http;

class GetbillingaddressApi {
  Future<dynamic> ongetbillingaddressApi() async {
    try {
      final uri = Uri.parse(Config.apiurl + Config.getbillingaddres);

      final response =
          await http.post(uri, headers: {'content-Type': 'application/json'});


      if (Config.isDebug) {
        print('url---- $uri');
       // print('post---- $postData');
        print('res---- '+json.decode(response.body).toString());
      }
      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        return GetbillingaddressModel.fromJson(responseJson);
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

final getbillingaddressApi = GetbillingaddressApi();
