class GetcountrycodeModel {
  bool? success;
  List<Countrycode>? countrycode;

  GetcountrycodeModel({this.success, this.countrycode});

  GetcountrycodeModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['countrycode'] != null) {
      countrycode = <Countrycode>[];
      json['countrycode'].forEach((v) {
        countrycode!.add(Countrycode.fromJson(v));
      });
    }
  }

  get data => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (countrycode != null) {
      data['countrycode'] = countrycode!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Countrycode {
  String? id;
  String? image;
  String? name;
  String? code;

  Countrycode({this.id, this.image, this.name, this.code});

  Countrycode.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    image = json['image'];
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['name'] = name;
    data['code'] = code;
    return data;
  }
}
