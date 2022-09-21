import 'dart:convert';
import 'dart:ffi';

import 'package:famous_steam_user/const/config.dart';
import 'package:famous_steam_user/const/prefKeys.dart';
import 'package:famous_steam_user/model/data_not_found.model.dart';
import 'package:famous_steam_user/model/register_data_not_found.model.dart';
import 'package:famous_steam_user/model/register_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;

class RegisterApi {
  Future<dynamic> onRegisterAPI(
      String name,
      String lastname,
      String email,
      String countrycode,
      String mobile,
      String addline1,
      String addline2,
      String city,
      String landmark,
      String zipcode,
      String lat,
      String lng,
      Placemark lookup,
      ) async {
    try {
      final uri = Uri.parse(Config.apiurl + Config.register);


/*

      final request = http.MultipartRequest(
        'POST',
        uri,
      );
      request.fields.addAll({
        'name': name,
        'lastname': lastname,
        'email': email,
        'country_code': countrycode,
        'mbl': mbl,
        'add_line1': addline1,
        'add_line2': addline2,
        'city': city,
        'landmark': landmark,
        'zipcode': zipcode,
      });

      final http.Response response = await http.Response.fromStream(
        await request.send(),
      );*/



      /*{
    "first_name": "Argha",
    "last_name": "Dey",
    "email": "argha054@gmail.com",
    "country_code": "+966",
    "mobile": "9832064085",
    "address": [
        {
            "add_line1": "3rd Floor, Bidhannagar, Kolkata, 700091, India"
        },
        {
            "add_line1": "3rd Floor, Bidhannagar, Kolkata, 700091, India"
        }
    ]
}*/



      List<AddressData> address = [];
      address.add(AddressData(addline1,lat,lng));

      //var jsonAddress =   address.map((player) => player.toJson()).toList();


      //  Map<String, dynamic> languages = json.decode(jsonCrossword);
      //  var user = new Lang.fromJson(languages);
/*

      List<Map> carOptionJson = new List();
      CarJson carJson = new CarJson("ca339e40-10cc-4459-b9ec-07f7df0f4c69");
      carOptionJson.add(carJson.TojsonData());

      var body = json.encode({
        "LstUserOptions": carOptionJson
      });


      {
    "state": "Eastern Province",
    "country": "Saudi Arabia",
    "zipCode": "32415",
    "cityName": "Dammam",
    "stateAbbr": "Eastern Province",
    "streetName": "Obaid Bin AlHarith Street",
    "coordinates": {
        "lat": 26.4525383,
        "lng": 50.1171918
    },
    "countryAbbr": "SA",
    "streetNumber": "",
    "formattedAddress": "Obaid Bin AlHarith St, Al Badi, Dammam 32415, Saudi Arabia"
}
 */


  var lookupAddress  =  AddressLookUp(lookup.administrativeArea.toString(),
          lookup.country.toString(),
          lookup.postalCode.toString(),
          lookup.locality.toString(),
          '',
          lookup.street.toString(),
          lookup.isoCountryCode.toString(),
          '',
          addline1,
          new Coordinates(double.parse(lat),double.parse(lng)));


      List<Map> addressJson = [];
      AddressData carJson = new AddressData(addline1,lat,lng);
      addressJson.add(carJson.TojsonData());



      var _body = json.encode({
        'name_eng': name,
        'name_ar': lastname,
        'email': email,
        'country_code': countrycode,
        'mobile': mobile,
        'address': addressJson,
        'gender':addline2,
        'device_token':PrefObj.preferences!.get(PrefKeys.USER_APP_DEVICE_TOKEN),
        'lookup':lookupAddress
      });


      Map<String, String>  requestHeaders = {
        'Accept-Language': '${PrefObj.preferences!.get(PrefKeys.LANG)}',
        'Accept': 'application/json',
        'Content-Type':'application/json',
      };

      if (Config.isDebug) {
        print('url---- $uri');
        print('post---- '+_body);

      }

      final response = await http.post(uri, body: _body, headers: requestHeaders);




      if (Config.isDebug) {
        print('res---- '+json.decode(response.body).toString());
      }

      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        return RegisterModel.fromJson(responseJson);
      }
      else  if (response.statusCode == 422) {
        responseJson = json.decode(response.body);
        return RegisterModel.fromJson(responseJson);
      }
      else if (response.statusCode == 401) {
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

/*
{
"state": "Eastern Province",
"country": "Saudi Arabia",
"zipCode": "32415",
"cityName": "Dammam",
"stateAbbr": "Eastern Province",
"streetName": "Obaid Bin AlHarith Street",
"coordinates": {
"lat": 26.4525383,
"lng": 50.1171918
},
"countryAbbr": "SA",
"streetNumber": "",
"formattedAddress": "Obaid Bin AlHarith St, Al Badi, Dammam 32415, Saudi Arabia"
}*/


class Coordinates{
  double lat;
  double  lng;
  Coordinates(this.lat,this.lng);

  Coordinates.fromJson(Map<String, dynamic> json)
      : lat = json['lat'],
        lng = json['lng'];

  Map<String, dynamic> toJson() =>{

    'lat': lat,
    'lng': lng,
  };

  Map<String, dynamic> TojsonData() {
    var map = new Map<String, dynamic>();
    map["lat"] = lat;
    map["lng"] = lng;

    return map;
  }
}

class AddressLookUp{
  String state;
  String  country;
  String  zipCode;
  String  cityName;
  String  stateAbbr;
  String  streetName;
  String  countryAbbr;
  String streetNumber;
  String formattedAddress;
  Coordinates coordinates;
  AddressLookUp(this.state,this.country,this.zipCode,this.cityName,this.stateAbbr,this.streetName
      ,this.countryAbbr,this.streetNumber,this.formattedAddress,this.coordinates);


  AddressLookUp.fromJson(Map<String, dynamic> json)
      : state = json['state'],
        country = json['country'],
        zipCode = json['zipCode'],
        cityName = json['cityName'],
        stateAbbr = json['stateAbbr'],
        streetName = json['streetName'],
        countryAbbr = json['countryAbbr'],
        streetNumber = json['streetNumber'],
        formattedAddress = json['formattedAddress'],
        coordinates = json['coordinates'];

  Map<String, dynamic> toJson() => {
    'state': state,
    'country':country,
    'zipCode':zipCode,
    'cityName':cityName,
    'stateAbbr':stateAbbr,
    'streetName':streetName,
    'countryAbbr':countryAbbr,
    'streetNumber':streetNumber,
    'formattedAddress':formattedAddress,
    'coordinates':coordinates,

  };

  Map<String, dynamic> TojsonData() {
    var map = new Map<String, dynamic>();
    map["state"] = state;
    map["country"] = country;
    map["zipCode"] = zipCode;
    map["cityName"] = cityName;
    map["stateAbbr"] = stateAbbr;
    map["streetName"] = streetName;
    map["countryAbbr"] = countryAbbr;
    map["streetNumber"] = streetNumber;
    map["formattedAddress"] = formattedAddress;
    map["coordinates"] = coordinates;
    return map;
  }

}



class AddressData {
  String add_line1;
  String lat;
  String lng;
  AddressData(this.add_line1,this.lat,this.lng);

  AddressData.fromJson(Map<String, dynamic> json)
      : add_line1 = json['add_line1'],
        lat = json['latitude'],
        lng = json['latitude'];

  Map<String, dynamic> toJson() => {
    'add_line1': add_line1,
    'latitude':lat,
    'longitude':lng,
  };

  Map<String, dynamic> TojsonData() {
    var map = new Map<String, dynamic>();
    map["add_line1"] = add_line1;
    map["latitude"] = lat;
    map["longitude"] = lng;
    return map;
  }
}









