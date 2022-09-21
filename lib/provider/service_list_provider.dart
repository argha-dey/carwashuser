import 'dart:async';
import 'dart:convert';
import 'package:famous_steam_user/const/config.dart';
import 'package:famous_steam_user/const/prefKeys.dart';
import 'package:famous_steam_user/model/data_not_found.model.dart';
import 'package:famous_steam_user/model/service_details_model.dart';
import 'package:famous_steam_user/model/service_list_model.dart';
import 'package:http/http.dart' as http;

class ServiceListApi {
  Future<dynamic> onServicedListApi(String categoryId, String sizeId,String packageId) async {
    try {

      final uri = Uri.parse(Config.apiurl + 'service?category_id='+categoryId+'&car_size_id='+sizeId+'&package_id='+packageId);

    /*  Map<String, dynamic>  requestPostData = {
        'category_id': categoryId,
        'size_id': sizeId,
        '':
      };*/
      Map<String, String>  requestHeaders = {
        'Accept-Language': '${PrefObj.preferences!.get(PrefKeys.LANG)}',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${PrefObj.preferences!.get(PrefKeys.TOKEN)}'
      };



      final response = await http.get(uri, headers: requestHeaders);


      if (Config.isDebug) {
        print('url---- $uri');
        print('post---- $requestHeaders');
        print('res---- '+json.decode(response.body).toString());
      }

      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        return ServiceListModel.fromJson(responseJson);
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

final serviceListApi = ServiceListApi();
