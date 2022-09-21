import 'dart:convert';
import 'package:famous_steam_user/const/config.dart';
import 'package:famous_steam_user/const/prefKeys.dart';
import 'package:famous_steam_user/model/data_not_found.model.dart';
import 'package:famous_steam_user/model/rating_star_feedback.dart';
import 'package:http/http.dart' as http;

class StarRatingFeedbackApi {
  Future<dynamic> onStarRatingFeedbackApi(
      String ratingstar,
      String orderid,
      String ratingreview,
      String modelId
      ) async {
    try {
      final uri = Uri.parse(Config.apiurl + 'rating');



      Map<String,dynamic>  requestPostData = <String, dynamic>{
        'type': 'user',
        'rating': ratingstar,
        'order_id': orderid,
        'review': ratingreview,
        "model_id": modelId,
        "author_id": '${PrefObj.preferences!.get(PrefKeys.USERID)}',
      };

      Map<String, String>  requestHeaders = {
        'Accept-Language': '${PrefObj.preferences!.get(PrefKeys.LANG)}',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${PrefObj.preferences!.get(PrefKeys.TOKEN)}'
      };

    //  var _body = json.encode(requestPostData);

      final response = await http.post(uri, body: requestPostData, headers: requestHeaders);


      if (Config.isDebug) {
        print('url---- $uri');


      }

      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        return ServiceRatingModel.fromJson(responseJson);
      } else if (response.statusCode == 301) {
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
