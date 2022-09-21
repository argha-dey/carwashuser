class VerifyModel {
  Data? data;
  dynamic accessToken;
  dynamic  message;
  dynamic status;


  VerifyModel({this.data, this.accessToken, this.message,this.status});

  VerifyModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    accessToken = json['access_token'];
    message = json['message'];
    status = json['status'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['access_token'] = this.accessToken;
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}

class Data {
  int? id;
  dynamic userDisplayId;
  dynamic nameEng;
  dynamic nameAr;
  dynamic  mobile;
  dynamic countryCode;
  dynamic email;
  dynamic image;
  dynamic  address;
  dynamic address2;
  dynamic address3;
  dynamic dob;
  dynamic  gender;
  dynamic  martialStatus;
  dynamic alternativeMobile;
  dynamic  country;
  dynamic nationality;
  dynamic registrationDate;
  dynamic registered;
  dynamic emailVerifiedAt;
  dynamic phoneVerifiedAt;
  dynamic status;
  dynamic deviceToken;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;
  dynamic numberOfRequests;
  dynamic numberOfCompletedServices;
  dynamic numberOfCancelledServices;
  dynamic numberOfServices;

  Data(
      {this.id,
        this.userDisplayId,
        this.nameEng,
        this.nameAr,
        this.mobile,
        this.countryCode,
        this.email,
        this.image,
        this.address,
        this.address2,
        this.address3,
        this.dob,
        this.gender,
        this.martialStatus,
        this.alternativeMobile,
        this.country,
        this.nationality,
        this.registrationDate,
        this.registered,
        this.emailVerifiedAt,
        this.phoneVerifiedAt,
        this.status,
        this.deviceToken,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.numberOfRequests,
        this.numberOfCompletedServices,
        this.numberOfCancelledServices,
        this.numberOfServices});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userDisplayId = json['user_display_id'];
    nameEng = json['name_eng'];
    nameAr = json['name_ar'];
    mobile = json['mobile'];
    countryCode = json['country_code'];
    email = json['email'];
    image = json['image'];
    address = json['address'];
    address2 = json['address_2'];
    address3 = json['address_3'];
    dob = json['dob'];
    gender = json['gender'];
    martialStatus = json['martial_status'];
    alternativeMobile = json['alternative_mobile'];
    country = json['country'];
    nationality = json['nationality'];
    registrationDate = json['registration_date'];
    registered = json['registered'];
    emailVerifiedAt = json['email_verified_at'];
    phoneVerifiedAt = json['phone_verified_at'];
    status = json['status'];
    deviceToken = json['device_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    numberOfRequests = json['number_of_requests'];
    numberOfCompletedServices = json['number_of_completed_services'];
    numberOfCancelledServices = json['number_of_cancelled_services'];
    numberOfServices = json['number_of_services'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_display_id'] = this.userDisplayId;
    data['name_eng'] = this.nameEng;
    data['name_ar'] = this.nameAr;
    data['mobile'] = this.mobile;
    data['country_code'] = this.countryCode;
    data['email'] = this.email;
    data['image'] = this.image;
    data['address'] = this.address;
    data['address_2'] = this.address2;
    data['address_3'] = this.address3;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['martial_status'] = this.martialStatus;
    data['alternative_mobile'] = this.alternativeMobile;
    data['country'] = this.country;
    data['nationality'] = this.nationality;
    data['registration_date'] = this.registrationDate;
    data['registered'] = this.registered;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['phone_verified_at'] = this.phoneVerifiedAt;
    data['status'] = this.status;
    data['device_token'] = this.deviceToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['number_of_requests'] = this.numberOfRequests;
    data['number_of_completed_services'] = this.numberOfCompletedServices;
    data['number_of_cancelled_services'] = this.numberOfCancelledServices;
    data['number_of_services'] = this.numberOfServices;
    return data;
  }
}



