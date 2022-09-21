import 'dart:async';
import 'dart:convert';
import 'package:famous_steam_user/const/config.dart';
import 'package:famous_steam_user/const/prefKeys.dart';
import 'package:famous_steam_user/model/data_not_found.model.dart';
import 'package:famous_steam_user/model/model_list_by_brand.dart';
import 'package:famous_steam_user/model/size_list_by_model.dart';
import 'package:famous_steam_user/model/vehicle_list_by_cetegory_model.dart';
import 'package:famous_steam_user/model/year_list_data_model.dart';
import 'package:http/http.dart' as http;

class VehiclelYearlistbySizeApi {
  Future<dynamic> onvehicleYearlistbySizeApi(String lang,String category_id,String brand_id,String modelId,String sizeId) async {
    try {

      final uri = Uri.parse(Config.apiurl + 'year?category_id='+category_id+"&brand_id="+brand_id+"&car_model_id="+modelId+"&car_size_id="+sizeId);

      Map<String, String>  requestHeaders = {
        'Accept-Language': '${PrefObj.preferences!.get(PrefKeys.LANG)}',
        'Accept': 'application/json',
      };

      final response =  await http.get(uri,headers: requestHeaders);





      if (Config.isDebug) {
        print('url---- $uri');
        print('post---- $requestHeaders');
        print('res---- '+json.decode(response.body).toString());
      }


      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        return YearListDataModel.fromJson(responseJson);
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

final vehiclelYearlistbySizeApi = VehiclelYearlistbySizeApi();
