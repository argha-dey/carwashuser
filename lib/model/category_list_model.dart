class CategoryListModel {
  bool? success;
  List<VehicleData>? data;

  CategoryListModel({this.success, this.data});

  CategoryListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <VehicleData>[];
      json['data'].forEach((v) {
        data!.add(VehicleData.fromJson(v));
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

class VehicleData {
  String? id;
  String? image;
  String? name;


/*  "id": 2,
  "name_eng": "Bike",
  "name_ar": "\u062f\u0631\u0627\u062c\u0629 \u0647\u0648\u0627\u0626\u064a\u0629",
  "image": "uploads\/category\/978474381649832653.png",
  "status": "Active",
  "created_at": "2022-03-24T23:39:45.000000Z",
  "updated_at": "2022-04-13T01:20:53.000000Z",
  "deleted_at": null*/






  VehicleData({this.id, this.image, this.name/*,this.name_ar,this.name_eng*/});

  VehicleData.fromJson(Map<String, dynamic> json) {
    id = json['category_id'].toString();
    image = json['image'];
    name = json['name'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_id'] = id;
    data['image'] = image;
    data['name'] = name;

    return data;
  }
}
