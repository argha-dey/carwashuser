import 'dart:async';
import 'dart:convert';
import 'package:famous_steam_user/const/config.dart';
import 'package:famous_steam_user/const/prefKeys.dart';
import 'package:famous_steam_user/model/check_mob_otp_model.dart';
import 'package:famous_steam_user/model/data_not_found.model.dart';
import 'package:famous_steam_user/model/register_model.dart';
import 'package:famous_steam_user/model/verify_otp_model.dart';
import 'package:http/http.dart' as http;

class OtpVerifyApi {
  Future<dynamic> onOtpVerifyApi(String mobile,String otp,String token_device_token) async {
    try {
    //  final uri = Uri.parse(Config.apiurl + Config.checkmbl);
      final uri = Uri.parse(Config.apiurl + "verify-otp");

/*{
    "mobile": "591316132",
    "code": "716713"
}*/

      print(mobile);
      print(otp);


      Map<String, String>  requestPostData = {
        'mobile': mobile,
        'code': otp,
        'device_token': token_device_token
      };


   /*   dynamic postData = {
        'mobile': mobile,
        'code':otp
      };*/

      Map<String, String>  requestHeaders = {
        'Accept-Language': '${PrefObj.preferences!.get(PrefKeys.LANG)}',
        'Accept': 'application/json',

      };




      final response = await http.post(uri, body: requestPostData, headers: requestHeaders);



      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        return VerifyModel.fromJson(responseJson);
      }else if (response.statusCode == 422) {
        responseJson = json.decode(response.body);
        return VerifyModel.fromJson(responseJson);
      }  else if (response.statusCode == 404) {
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

final otpverifyApi = OtpVerifyApi();
