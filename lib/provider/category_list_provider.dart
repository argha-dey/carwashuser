import 'dart:async';
import 'dart:convert';
import 'package:famous_steam_user/const/config.dart';
import 'package:famous_steam_user/const/prefKeys.dart';
import 'package:famous_steam_user/model/category_list_model.dart';
import 'package:famous_steam_user/model/data_not_found.model.dart';
import 'package:http/http.dart' as http;

class CategorylistApi {
  Future<dynamic> oncategorylistApi(String lang) async {
    try {

    //  final uri = Uri.parse("https://carwash.developerconsole.xyz/api/category");
      final uri = Uri.parse(Config.apiurl + 'category');

      Map<String, String>  requestHeaders = {
        'Accept-Language': '${PrefObj.preferences!.get(PrefKeys.LANG)}',
        'Accept': 'application/json',
     /*   'Authorization': 'Bearer ${PrefObj.preferences!.get(PrefKeys.TOKEN)}'*/
      };


      final response =  await http.get(uri,headers: requestHeaders);


/*       final uri = Uri.parse(Config.apiurl + Config.category);
      dynamic postData = {
        'lang': PrefObj.preferences!.get(PrefKeys.LANG),
      };

      final response = await http.post(uri, body: postData, headers: {
        'Authorization': 'Bearer ${PrefObj.preferences!.get(PrefKeys.TOKEN)}'
      });


         final response = await http.get(uri, headers: {
        'Authorization': 'Bearer ${PrefObj.preferences!.get(PrefKeys.TOKEN)}'
      });
      */




      if (Config.isDebug) {
        print('url---- $uri');
       print('post---- $requestHeaders');
        print('res---- '+json.decode(response.body).toString());
      }
      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        return CategoryListModel.fromJson(responseJson);
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

final categorylistApi = CategorylistApi();
