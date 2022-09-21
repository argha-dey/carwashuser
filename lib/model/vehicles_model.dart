
class Vehicles {
  String? id;
  String? brandId;
  String? brand;
  String? sizeId;
  String? size;
  String? fuelId;
  String? fuel;
  String? categoryId;
  String? category;

  Vehicles(
      {this.id,
        this.brandId,
        this.brand,
        this.sizeId,
        this.size,
        this.fuelId,
        this.fuel,
        this.categoryId,
        this.category});

  Vehicles.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    brandId = json['brand_id'].toString();
    brand = json['brand'];
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
    data['brand'] = brand;
    data['size_id'] = sizeId;
    data['size'] = size;
    data['fuel_id'] = fuelId;
    data['fuel'] = fuel;
    data['category_id'] = categoryId;
    data['category'] = category;
    return data;
  }
}