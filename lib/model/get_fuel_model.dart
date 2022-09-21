class GetFuelModel {
  bool? success;
  List<Data>? data;

  GetFuelModel({this.success, this.data});

  GetFuelModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? image;
  String? name;

  Data({this.id, this.image, this.name});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['fuel_id'].toString();
    image = json['image'] ?? 'https://famoussteam.com/crm/uploads/fuel/20669941481648289780.png';
    name = json['name'] ?? 'test';

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fuel_id'] = id;
    data['image'] = image;
    data['name'] = name;
    return data;
  }
}
