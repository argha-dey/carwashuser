class SearchResultModel {
  bool? success;
  List<Data>? data;

  SearchResultModel({this.success, this.data});

  SearchResultModel.fromJson(Map<String, dynamic> json) {
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
  String? price;
  int? offerprice;
  String? timeDuration;
  String? packagePlan;
  String? services;

  Data(
      {this.id,
      this.price,
      this.offerprice,
      this.timeDuration,
      this.packagePlan,
      this.services});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    price = json['price'];
    offerprice = json['offerprice'];
    timeDuration = json['time_duration'];
    packagePlan = json['package_plan'];
    services = json['services'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['price'] = price;
    data['offerprice'] = offerprice;
    data['time_duration'] = timeDuration;
    data['package_plan'] = packagePlan;
    data['services'] = services;
    return data;
  }
}
