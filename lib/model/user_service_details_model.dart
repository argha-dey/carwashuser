class UserservicedetailsModel {
  bool? success;
  WaitingServices? waitingServices;

  UserservicedetailsModel({this.success, this.waitingServices});

  UserservicedetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    waitingServices = json['waiting_services'] != null
        ? WaitingServices.fromJson(json['waiting_services'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (waitingServices != null) {
      data['waiting_services'] = waitingServices!.toJson();
    }
    return data;
  }
}

class WaitingServices {
  String? serviceNo;
  String? serviceValue;
  String? serviceType;
  String? serviceName;
  String? vehicleBrand;
  String? vehicleSize;
  String? vehicleType;
  String? slotDate;
  String? slotStartTime;
  String? slotEndTime;
  String? address;

  WaitingServices(
      {this.serviceNo,
      this.serviceValue,
      this.serviceType,
      this.serviceName,
      this.vehicleBrand,
      this.vehicleSize,
      this.vehicleType,
      this.slotDate,
      this.slotStartTime,
      this.slotEndTime,
      this.address});

  WaitingServices.fromJson(Map<String, dynamic> json) {
    serviceNo = json['service_no'].toString();
    serviceValue = json['service_value'];
    serviceType = json['service_type'];
    serviceName = json['service_name'];
    vehicleBrand = json['vehicle_brand'];
    vehicleSize = json['vehicle_size'];
    vehicleType = json['vehicle_type'];
    slotDate = json['slot_date'];
    slotStartTime = json['slot_start_time'];
    slotEndTime = json['slot_end_time'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['service_no'] = serviceNo;
    data['service_value'] = serviceValue;
    data['service_type'] = serviceType;
    data['service_name'] = serviceName;
    data['vehicle_brand'] = vehicleBrand;
    data['vehicle_size'] = vehicleSize;
    data['vehicle_type'] = vehicleType;
    data['slot_date'] = slotDate;
    data['slot_start_time'] = slotStartTime;
    data['slot_end_time'] = slotEndTime;
    data['address'] = address;
    return data;
  }
}
