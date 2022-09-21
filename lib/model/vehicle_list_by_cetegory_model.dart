class VehiclelbrandlistbycategoryModel {
  bool? success;
  List<Vehicleslist>? vehicles;

  VehiclelbrandlistbycategoryModel({this.success, this.vehicles});

  VehiclelbrandlistbycategoryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      vehicles = <Vehicleslist>[];
      json['data'].forEach((v) {
        vehicles!.add(Vehicleslist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (vehicles != null) {
      data['data'] = vehicles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


/* "id": 5001,
            "parent_id": 0,
            "category_id": "1",
            "name_eng": "Acura",
            "name_ar": "Acura",
            "status": "Active",
            "created_at": "2022-05-12T15:02:14.000000Z",
            "updated_at": "2022-05-12T15:21:39.000000Z",
            "deleted_at": null*/

class Vehicleslist {
  String? id;
  String? brandId;
  String? brand;
  String? sizeId;
  String? size;
  String? fuelId;
  String? fuel;
  String? categoryId;
  String? category;

  Vehicleslist(
      {this.id,
      this.brandId,
      this.brand,
      this.sizeId,
      this.size,
      this.fuelId,
      this.fuel,
      this.categoryId,
      this.category});

  Vehicleslist.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    brandId = json['brand_id'].toString();
    brand = json['name'];
    sizeId = json['size_id'].toString();
    size = json['size'];
    fuelId = json['fuel_id'].toString();
    fuel = json['fuel'];
    categoryId = json['category_id'].toString();
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['brand_id'] = brandId;
    data['name'] = brand;
    data['size_id'] = sizeId;
    data['size'] = size;
    data['fuel_id'] = fuelId;
    data['fuel'] = fuel;
    data['category_id'] = categoryId;
    data['category'] = category;
    return data;
  }
}
