class PackageIndexModel {
  List<PackageData>? data;



  PackageIndexModel({this.data});

  PackageIndexModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <PackageData>[];
      json['data'].forEach((v) {
        data!.add(new PackageData.fromJson(v));
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

class PackageData {
  int? packageId;
  Category? category;
  CarSize? carSize;
  String? packageName;
  dynamic packageImage;
  String? packagePrice;
  String? packageOfferPrice;
  dynamic packageDiscount;
  String? timeDuration;
  String? showDashboard;
  List<PackageServices>? packageServices;
 dynamic packageRating;

  PackageData(
      {this.packageId,
        this.category,
        this.carSize,
        this.packageName,
        this.packageImage,
        this.packagePrice,
        this.packageOfferPrice,
        this.packageDiscount,
        this.timeDuration,
        this.showDashboard,
        this.packageServices,
        this.packageRating});

  PackageData.fromJson(Map<String, dynamic> json) {
    packageId = json['package_id'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    carSize = json['car_size'] != null
        ? new CarSize.fromJson(json['car_size'])
        : null;
    packageName = json['package_name'];
    packageImage = json['package_image'];
    packagePrice = json['package_price'];
    packageOfferPrice = json['package_offer_price'];
    packageDiscount = json['package_discount'];
    timeDuration = json['time_duration'];
    showDashboard = json['show_dashboard'];
    if (json['package_services'] != null) {
      packageServices = <PackageServices>[];
      json['package_services'].forEach((v) {
        packageServices!.add(new PackageServices.fromJson(v));
      });
    }
    packageRating = json['package_rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['package_id'] = this.packageId;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.carSize != null) {
      data['car_size'] = this.carSize!.toJson();
    }
    data['package_name'] = this.packageName;
    data['package_image'] = this.packageImage;
    data['package_price'] = this.packagePrice;
    data['package_offer_price'] = this.packageOfferPrice;
    data['package_discount'] = this.packageDiscount;
    data['time_duration'] = this.timeDuration;
    data['show_dashboard'] = this.showDashboard;
    if (this.packageServices != null) {
      data['package_services'] =
          this.packageServices!.map((v) => v.toJson()).toList();
    }
    data['package_rating'] = this.packageRating;
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

class PackageServices {
  int? serviceId;
  Category? category;
  CarSize? carSize;
  String? serviceName;
  String? servicePrice;
  String? serviceOfferPrice;
  String? timeDuration;
  String? showDashboard;

  PackageServices(
      {this.serviceId,
        this.category,
        this.carSize,
        this.serviceName,
        this.servicePrice,
        this.serviceOfferPrice,
        this.timeDuration,
        this.showDashboard});

  PackageServices.fromJson(Map<String, dynamic> json) {
    serviceId = json['service_id'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    carSize = json['car_size'] != null
        ? new CarSize.fromJson(json['car_size'])
        : null;
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





