import 'dart:async';
import 'dart:convert';
import 'package:famous_steam_user/const/config.dart';
import 'package:famous_steam_user/const/prefKeys.dart';
import 'package:famous_steam_user/model/booking_history_model.dart';
import 'package:famous_steam_user/model/data_not_found.model.dart';
import 'package:http/http.dart' as http;

class BookinghistoryApi {
  Future<dynamic> onbookinghistoryApi(String type,String startDate,String endDate) async {
    try {

      https://carwash.developerconsole.link/api/staff-order?request_type=approve&from_date=2022-07-30&to_date=2022-08-02

      String uri='';
      if(type=='') {
        uri = Uri.parse(Config.apiurl + 'order').toString();
      }

      else {
        uri = Uri.parse(
            Config.apiurl + 'order?from_date='+startDate+'&to_date='+endDate).toString();
      }



      Map<String, String>  requestHeaders = {
        'Accept-Language': '${PrefObj.preferences!.get(PrefKeys.LANG)}',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${PrefObj.preferences!.get(PrefKeys.TOKEN)}'
      };


      final response = await http.get(Uri.parse(uri), headers: requestHeaders);



      if (Config.isDebug) {
        print('url---- $uri');
     //   print('post---- $postData');
        print('res---- '+json.decode(response.body).toString());
      }

      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        return BookinghistoryModel.fromJson(responseJson);
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

final bookinghistoryApi = BookinghistoryApi();
