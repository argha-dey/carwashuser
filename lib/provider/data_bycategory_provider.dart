import 'dart:async';
import 'dart:convert';
import 'package:famous_steam_user/const/config.dart';
import 'package:famous_steam_user/const/prefKeys.dart';
import 'package:famous_steam_user/model/data_not_found.model.dart';
import 'package:famous_steam_user/model/data_bycategory_model.dart';
import 'package:http/http.dart' as http;

class DatabycategoryApi {
  Future<dynamic> ondatabycategoryApi(
    String categoryid,
    String lang,
  ) async {
    try {
      final uri = Uri.parse(Config.apiurl + Config.databycategory);

      dynamic postData = {
        'category_id': categoryid,
        'lang': PrefObj.preferences!.get(PrefKeys.LANG),
      };

      final response = await http.post(uri,
          body: json.encode(postData),
          headers: {'content-Type': 'application/json'});
      if (Config.isDebug) {
        print('url---- $uri');
        print('url---- $postData');
        print('res---- '+json.decode(response.body).toString());
      }
      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        return DatabycategoryModel.fromJson(responseJson);
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

final databycategoryApi = DatabycategoryApi();
