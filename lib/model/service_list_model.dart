class ServiceListModel {
  List<ServiceData>? data;


  ServiceListModel({this.data});

  ServiceListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ServiceData>[];
      json['data'].forEach((v) {
        data!.add(new ServiceData.fromJson(v));
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

class ServiceData {
  int? serviceId;
  Category? category;
  Carsize? carSize;
  String? serviceName;
  String? servicePrice;
  String? serviceOfferPrice;
  String? timeDuration;
  String? showDashboard;

  ServiceData(
      {this.serviceId,
        this.category,
        this.carSize,
        this.serviceName,
        this.servicePrice,
        this.serviceOfferPrice,
        this.timeDuration,
        this.showDashboard});

  ServiceData.fromJson(Map<String, dynamic> json) {
    serviceId = json['service_id'];
    category = json['category']!= null ? new Category.fromJson(json['category']) : null;
    carSize = json['car_size']!= null ? new Carsize.fromJson(json['car_size']) : null;
    serviceName = json['service_name'];
    servicePrice = json['service_price'];
    serviceOfferPrice = json['service_offer_price'];
    timeDuration = json['time_duration'];
    showDashboard = json['show_dashboard'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_id'] = this.serviceId;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.carSize != null) {
      data['car_size'] = this.carSize!.toJson();
    }
    data['service_name'] = this.serviceName;
    data['service_price'] = this.servicePrice;
    data['service_offer_price'] = this.serviceOfferPrice;
    data['time_duration'] = this.timeDuration;
    data['show_dashboard'] = this.showDashboard;
    return data;
  }
}

class Carsize {
  int? car_size_id;
  String? size_name;


  Carsize({this.car_size_id, this.size_name});

  Carsize.fromJson(Map<String, dynamic> json) {
    car_size_id = json['car_size_id'];
    size_name = json['size_name'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['car_size_id'] = this.car_size_id;
    data['size_name'] = this.size_name;

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