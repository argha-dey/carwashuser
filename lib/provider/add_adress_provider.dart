import 'dart:convert';
import 'package:famous_steam_user/const/config.dart';
import 'package:famous_steam_user/const/prefKeys.dart';
import 'package:famous_steam_user/model/add_address_model.dart';
import 'package:famous_steam_user/model/data_not_found.model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;

class AddAddressApi {
  Future<dynamic> onAddAddressApi(
      String address,
      String lat,
      String lang,
      String landmark,
      String zip,
      Placemark _lookup,
      ) async {
    try {

      var lookupAddress  =  AddressLookUp(_lookup.administrativeArea.toString(),
          _lookup.country.toString(),
          _lookup.postalCode.toString(),
          _lookup.locality.toString(),
          '',
          _lookup.street.toString(),
          _lookup.isoCountryCode.toString(),
          '',
          address,
          new Coordinates(double.parse(lat),double.parse(lang)));


      final uri = Uri.parse(Config.apiurl +'user-address');


      Map<String, String>  requestHeaders = {
        'Accept-Language': '${PrefObj.preferences!.get(PrefKeys.LANG)}',
        'Accept': 'application/json',
        'Content-Type':'application/json',
        'Authorization': 'Bearer ${PrefObj.preferences!.get(PrefKeys.TOKEN)}'
      };



      var _body = json.encode({
        'add_line1': address,
        'latitude':lat,
        'longitude':lang,
        'lookup':lookupAddress,
      });

      if (Config.isDebug) {
        print('url---- $uri');
        print('post---- '+_body);

      }

      final response =  await http.post(uri,body: _body,headers: requestHeaders);

      if (Config.isDebug) {
        print('res---- '+json.decode(response.body).toString());
      }

      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        return AddAddressModel.fromJson(responseJson);
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