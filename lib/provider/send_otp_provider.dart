import 'dart:async';
import 'dart:convert';
import 'package:famous_steam_user/const/config.dart';
import 'package:famous_steam_user/const/prefKeys.dart';
import 'package:famous_steam_user/model/check_mob_otp_model.dart';
import 'package:famous_steam_user/model/data_not_found.model.dart';
import 'package:http/http.dart' as http;

class SendOTPApi {
  Future<dynamic> onSendOTPApi(String mobile) async {
    try {
      final uri = Uri.parse(Config.apiurl + "send-otp");



   /*   dynamic postData = {

      };*/

      Map<String, String>  requestPostData = {
        'mobile': '${mobile}',
      };


      Map<String, String>  requestHeaders = {
        'Accept-Language': '${PrefObj.preferences!.get(PrefKeys.LANG)}',
        'Accept': 'application/json',
      };


      final response = await http.post(uri, body: requestPostData, headers: requestHeaders);

      if (Config.isDebug) {
        print('url---- $uri');
        print('post---- $requestPostData');
        print('header---- $requestHeaders');
        print('res---- '+json.decode(response.body).toString());
      }

      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        return CheckMobileModel.fromJson(responseJson);
      }
      else if (response.statusCode == 422){
        responseJson = json.decode(response.body);
        return CheckMobileModel.fromJson(responseJson);
      }
      else if (response.statusCode == 404) {
        responseJson = json.decode(response.body);
        return DataNotFoundModel.fromJson(responseJson);
      } else {
        responseJson = json.decode(response.body);
        return DataNotFoundModel.fromJson(responseJson);
      }
    } catch (exception) {
      print('exception---- $exception');
      return null;
    }
  }
}

final sendOTPApi = SendOTPApi();
