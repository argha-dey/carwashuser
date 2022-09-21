import 'dart:async';
import 'dart:convert';
import 'package:famous_steam_user/const/config.dart';
import 'package:famous_steam_user/const/prefKeys.dart';
import 'package:famous_steam_user/model/data_not_found.model.dart';
import 'package:famous_steam_user/model/model_list_by_brand.dart';
import 'package:famous_steam_user/model/size_list_by_model.dart';
import 'package:famous_steam_user/model/vehicle_list_by_cetegory_model.dart';
import 'package:http/http.dart' as http;

class VehiclelSizelistbyModelApi {
  Future<dynamic> onvehicleSizelistbyModelApi(String lang,String category_id,String brand_id,String modelId) async {
    try {

      final uri = Uri.parse(Config.apiurl + 'car-size?category_id='+category_id+"&brand_id="+brand_id+"&car_model_id="+modelId);

      Map<String, String>  requestHeaders = {
        'Accept-Language': '${PrefObj.preferences!.get(PrefKeys.LANG)}',
        'Accept': 'application/json',
        /*   'Authorization': 'Bearer ${PrefObj.preferences!.get(PrefKeys.TOKEN)}'*/
      };

      final response =  await http.get(uri,headers: requestHeaders);

 /*     final uri = Uri.parse(Config.apiurl + Config.vehiclelistbycategory);
      dynamic postData = {'lang': lang, 'catid': catid};
      final response =
          await http.post(uri, body: json.encode(postData), headers: {
        'content-Type': 'application/json',
        'Authorization': 'Bearer ${PrefObj.preferences!.get(PrefKeys.TOKEN)}'
      });*/




      if (Config.isDebug) {
        print('url---- $uri');
       print('post---- $requestHeaders');
        print('res---- '+json.decode(response.body).toString());
      }


      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        return VehiclelsizelistbybrandModel.fromJson(responseJson);
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

final vehiclelSizelistbyModelApi = VehiclelSizelistbyModelApi();
