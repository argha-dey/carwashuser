/*
class VehicleListModel {
  bool? success;
  List<Vehicles>? vehicles;

  VehicleListModel({this.success, this.vehicles});

  VehicleListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['vehicles'] != null) {
      vehicles = <Vehicles>[];
      json['vehicles'].forEach((v) {
        vehicles!.add(Vehicles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (vehicles != null) {
      data['vehicles'] = vehicles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

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
*/
class VehicleListModel {
  List<VehicleDetails>? data;


  VehicleListModel({this.data});

  VehicleListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <VehicleDetails>[];
      json['data'].forEach((v) {
        data!.add(new VehicleDetails.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class VehicleDetails {
  int? userVehicleId;
  Category? category;
  Brand? brand;
  Fuel? fuel;
  CarSize? carSize;
  CarModel? carModel;
  Year? year;
  VehicleDetails(
      {this.userVehicleId,
        this.category,
        this.brand,
        this.fuel,
        this.carSize,
        this.carModel
      ,this.year});

  VehicleDetails.fromJson(Map<String, dynamic> json) {
    userVehicleId = json['user_vehicle_id'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    brand = json['brand'] != null ? new Brand.fromJson(json['brand']) : null;
    fuel = json['fuel'] != null ? new Fuel.fromJson(json['fuel']) : null;
    carSize = json['car_size'] != null
        ? new CarSize.fromJson(json['car_size'])
        : null;
    carModel = json['car_model'] != null
        ? new CarModel.fromJson(json['car_model'])
        : null;

    year = json['year'] != null
        ? new Year.fromJson(json['year'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_vehicle_id'] = this.userVehicleId;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.brand != null) {
      data['brand'] = this.brand!.toJson();
    }
    if (this.fuel != null) {
      data['fuel'] = this.fuel!.toJson();
    }
    if (this.carSize != null) {
      data['car_size'] = this.carSize!.toJson();
    }
    if (this.carModel != null) {
      data['car_model'] = this.carModel!.toJson();
    }
    if (this.year != null) {
      data['year'] = this.year!.toJson();
    }
    return data;
  }
}


class Year {
  int? yearId;
  String? yearName;


  Year({this.yearId, this.yearName});

  Year.fromJson(Map<String, dynamic> json) {
    yearId = json['year_id'];
    yearName = json['year_name'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['year_id'] = this.yearId;
    data['year_name'] = this.yearName;

    return data;
  }
}

class Category {
  int? categoryId;
  String? name;
  String? image;

  Category({this.categoryId, this.name, this.image});

  Category.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}

class Brand {
  int? brandId;
  String? name;
  String? image;

  Brand({this.brandId, this.name, this.image});

  Brand.fromJson(Map<String, dynamic> json) {
    brandId = json['brand_id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand_id'] = this.brandId;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}

class Fuel {
  int? fuelId;
  String? name;
  String? image;

  Fuel({this.fuelId, this.name, this.image});

  Fuel.fromJson(Map<String, dynamic> json) {
    fuelId = json['fuel_id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fuel_id'] = this.fuelId;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}

class CarSize {
  int? carSizeId;
  String? sizeName;

  CarSize({this.carSizeId, this.sizeName});

  CarSize.fromJson(Map<String, dynamic> json) {
    carSizeId = json['car_size_id'];
    sizeName = json['size_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['car_size_id'] = this.carSizeId;
    data['size_name'] = this.sizeName;
    return data;
  }
}

class CarModel {
  int? carModelId;
  String? carModelName;

  CarModel({this.carModelId, this.carModelName});

  CarModel.fromJson(Map<String, dynamic> json) {
    carModelId = json['car_model_id'];
    carModelName = json['car_model_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['car_model_id'] = this.carModelId;
    data['car_model_name'] = this.carModelName;
    return data;
  }
}








