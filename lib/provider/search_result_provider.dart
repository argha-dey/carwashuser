import 'dart:async';
import 'dart:convert';
import 'package:famous_steam_user/const/config.dart';
import 'package:famous_steam_user/const/prefKeys.dart';
import 'package:famous_steam_user/model/data_not_found.model.dart';
import 'package:famous_steam_user/model/search_result_model.dart';
import 'package:http/http.dart' as http;

class SearchResultApi {
  Future<dynamic> onsearchResultApi(String keyword, String lang) async {
    try {
      final uri = Uri.parse(Config.apiurl + Config.searchresult);
      dynamic postData = {
        'keyword': keyword,
        'lang':  PrefObj.preferences!.get(PrefKeys.LANG),
      };

      final response =
          await http.post(uri, body: json.encode(postData), headers: {
        'content-Type': 'application/json',
        'Authorization': 'Bearer ${PrefObj.preferences!.get(PrefKeys.TOKEN)}'
      });
      if (Config.isDebug) {
        print('url---- $uri');
        print('post---- $postData');
        print('res---- '+json.decode(response.body).toString());
      }
      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        return SearchResultModel.fromJson(responseJson);
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
