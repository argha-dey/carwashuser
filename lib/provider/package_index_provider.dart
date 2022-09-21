import 'dart:async';
import 'dart:convert';
import 'package:famous_steam_user/const/config.dart';
import 'package:famous_steam_user/const/prefKeys.dart';
import 'package:famous_steam_user/model/data_not_found.model.dart';
import 'package:famous_steam_user/model/package_index_model.dart';
import 'package:http/http.dart' as http;

class PackageIndexApi {
  Future<dynamic> onPackageIndexApi(String lang,String catId,String carSizeId) async {
    try {
      final uri;
      if(catId=='') {
        uri = Uri.parse(Config.apiurl + "package");
      } else if(carSizeId==''){
        uri = Uri.parse(Config.apiurl + "package?category_id="+catId);
      }
      else
        {
          uri = Uri.parse(Config.apiurl + "package?category_id="+catId+"&car_size_id="+carSizeId);
        }



      Map<String, String>  requestHeaders = {
        'Accept-Language': '${PrefObj.preferences!.get(PrefKeys.LANG)}',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${PrefObj.preferences!.get(PrefKeys.TOKEN)}'
      };

      if (Config.isDebug) {

        print('post---- $requestHeaders');
      }

      dynamic postData = {'lang':  PrefObj.preferences!.get(PrefKeys.LANG)};

      final response = await http.get(uri, headers: requestHeaders);


      if (Config.isDebug) {
        print('url---- $uri');
        print('post---- $postData');
        print('res---- '+json.decode(response.body).toString());
      }


      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        return PackageIndexModel.fromJson(responseJson);
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
