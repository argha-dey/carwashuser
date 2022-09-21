class ServicedetailsModel {
  bool? success;
  List<Data>? data;

  ServicedetailsModel({this.success, this.data});

  ServicedetailsModel.fromJson(Map<String, dynamic> json) {
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
  String? offerprice;
  String? timeDuration;
  String? image;
  String? size;
  String? categoryName;
  String? packagePlan;
  String? services;
  List<Servicerating>? servicerating;
  String? serviceratingaverage;

  Data(
      {this.id,
      this.price,
      this.offerprice,
      this.timeDuration,
      this.image,
      this.size,
      this.categoryName,
      this.packagePlan,
      this.services,
      this.servicerating,
      this.serviceratingaverage});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    price = json['price'];
    offerprice = json['offerprice'].toString();
    timeDuration = json['time_duration'];
    image = json['image'];
    size = json['size'];
    categoryName = json['category_name'];
    packagePlan = json['package_plan'];
    services = json['services'];
    if (json['servicerating'] != null) {
      servicerating = <Servicerating>[];
      json['servicerating'].forEach((v) {
        servicerating!.add(Servicerating.fromJson(v));
      });
    }
    serviceratingaverage = json['serviceratingaverage'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['price'] = price;
    data['offerprice'] = offerprice;
    data['time_duration'] = timeDuration;
    data['image'] = image;
    data['size'] = size;
    data['category_name'] = categoryName;
    data['package_plan'] = packagePlan;
    data['services'] = services;
    if (servicerating != null) {
      data['servicerating'] = servicerating!.map((v) => v.toJson()).toList();
    }
    data['serviceratingaverage'] = serviceratingaverage;
    return data;
  }
}

class Servicerating {
  String? name;
  String? rating;
  String? review;

  Servicerating({this.name, this.rating, this.review});

  Servicerating.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    rating = json['rating'];
    review = json['review'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['rating'] = rating;
    data['review'] = review;
    return data;
  }
}
