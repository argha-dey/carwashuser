class PackageSizeModel {
  bool? success;
  List<Data>? data;

  PackageSizeModel({this.success, this.data});

  PackageSizeModel.fromJson(Map<String, dynamic> json) {
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
  String? categoryId;
  String? name;
  String? category;

  Data({this.id, this.categoryId, this.name, this.category});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    categoryId = json['category_id'];
    name = json['name'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category_id'] = categoryId;
    data['name'] = name;
    data['category'] = category;
    return data;
  }
}
