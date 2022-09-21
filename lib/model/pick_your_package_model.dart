class PickyourpackageModel {
  bool? success;
  List<Data>? data;

  PickyourpackageModel({this.success, this.data});

  PickyourpackageModel.fromJson(Map<String, dynamic> json) {
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
  String? image;
  String? packageName;

  Data({this.id, this.price, this.image, this.packageName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    price = json['price'];
    image = json['image'];
    packageName = json['package_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['price'] = price;
    data['image'] = image;
    data['package_name'] = packageName;
    return data;
  }
}
