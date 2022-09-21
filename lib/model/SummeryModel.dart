class SummeryModel {
  Package? package;
  List<ExtraServices>? extraServices;
  dynamic totalExtraServicePrice;
  dynamic slotStartTime;
  dynamic slotEndTime;
  dynamic appointmentDate;
  dynamic timeDuration;
  dynamic total;



  SummeryModel(
      {this.package,
        this.extraServices,
        this.totalExtraServicePrice,
        this.slotStartTime,
        this.slotEndTime,
        this.appointmentDate,
        this.timeDuration,
        this.total});

  SummeryModel.fromJson(Map<String, dynamic> json) {
    package =
    json['package'] != null ? new Package.fromJson(json['package']) : null;
    if (json['extra_services'] != null) {
      extraServices = <ExtraServices>[];
      json['extra_services'].forEach((v) {
        extraServices!.add(new ExtraServices.fromJson(v));
      });
    }
    totalExtraServicePrice = json['total_extra_service_price'];
    slotStartTime = json['slot_start_time'];
    slotEndTime = json['slot_end_time'];
    appointmentDate = json['appointment_date'];
    timeDuration = json['time_duration'];
    total = json['total'];
  }



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.package != null) {
      data['package'] = this.package!.toJson();
    }
    if (this.extraServices != null) {
      data['extra_services'] =
          this.extraServices!.map((v) => v.toJson()).toList();
    }
    data['total_extra_service_price'] = this.totalExtraServicePrice;
    data['slot_start_time'] = this.slotStartTime;
    data['slot_end_time'] = this.slotEndTime;
    data['appointment_date'] = this.appointmentDate;
    data['time_duration'] = this.timeDuration;
    data['total'] = this.total;
    return data;
  }
}




class Package {
  dynamic id;
  dynamic categoryId;
  dynamic carSizeId;
  dynamic nameEng;
  dynamic nameAr;
  dynamic image;
  List<String>? serviceIds;
  dynamic packagePrice;
  dynamic packageOfferPrice;
  dynamic showDashboard;
  dynamic timeDuration;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;
  dynamic name;

  Package(
      {this.id,
        this.categoryId,
        this.carSizeId,
        this.nameEng,
        this.nameAr,
        this.image,
        this.serviceIds,
        this.packagePrice,
        this.packageOfferPrice,
        this.showDashboard,
        this.timeDuration,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.name});

  Package.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    carSizeId = json['car_size_id'];
    nameEng = json['name_eng'];
    nameAr = json['name_ar'];
    image = json['image'];
    serviceIds = json['service_ids'].cast<String>();
    packagePrice = json['package_price'];
    packageOfferPrice = json['package_offer_price'];
    showDashboard = json['show_dashboard'];
    timeDuration = json['time_duration'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['car_size_id'] = this.carSizeId;
    data['name_eng'] = this.nameEng;
    data['name_ar'] = this.nameAr;
    data['image'] = this.image;
    data['service_ids'] = this.serviceIds;
    data['package_price'] = this.packagePrice;
    data['package_offer_price'] = this.packageOfferPrice;
    data['show_dashboard'] = this.showDashboard;
    data['time_duration'] = this.timeDuration;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['name'] = this.name;
    return data;
  }
}

class ExtraServices {
  int? id;
  int? categoryId;
  int? carSizeId;
  String? nameEng;
  String? nameAr;
  String? servicePrice;
  String? serviceOfferPrice;
  String? timeDuration;
  String? showDashboard;
  String? status;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;
  String? name;

  ExtraServices(
      {this.id,
        this.categoryId,
        this.carSizeId,
        this.nameEng,
        this.nameAr,
        this.servicePrice,
        this.serviceOfferPrice,
        this.timeDuration,
        this.showDashboard,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.name});



  ExtraServices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    carSizeId = json['car_size_id'];
    nameEng = json['name_eng'];
    nameAr = json['name_ar'];
    servicePrice = json['service_price'];
    serviceOfferPrice = json['service_offer_price'];
    timeDuration = json['time_duration'];
    showDashboard = json['show_dashboard'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    name = json['name'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['car_size_id'] = this.carSizeId;
    data['name_eng'] = this.nameEng;
    data['name_ar'] = this.nameAr;
    data['service_price'] = this.servicePrice;
    data['service_offer_price'] = this.serviceOfferPrice;
    data['time_duration'] = this.timeDuration;
    data['show_dashboard'] = this.showDashboard;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['name'] = this.name;
    return data;
  }


}