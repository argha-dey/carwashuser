
/*JSON
data
first_name : "Argha"
last_name : "Dey"
email : "argha05@gmail.com"
country_code : "+966"
mobile : "983206085"
updated_at : "2022-06-23T12:44:03.000000Z"
created_at : "2022-06-23T12:44:03.000000Z"
id : 2
access_token : "15|JJdXH1rFQ4TVBF5Fg2XgW64WtIfdqk5CCyXfxrYF"
message : "register Successfully"
debug*/



class Errors {
  List<String>? email;


  Errors({this.email});

  Errors.fromJson(Map<String, dynamic> json) {
    email = json['email'].cast<String>();

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;

    return data;
  }
}

class RegisterModel {
  UserDataClass? data;
  String? accessToken;
  String? message;
  Errors? errors;


  RegisterModel({this.data, this.accessToken, this.message,this.errors});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new UserDataClass.fromJson(json['data']) : null;
    accessToken = json['access_token'];
    message = json['message'];
    errors = json['errors'] != null ? new Errors.fromJson(json['errors']) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['access_token'] = this.accessToken;
    data['message'] = this.message;
    if (this.errors != null) {
      data['errors'] = this.errors!.toJson();
    }
    return data;
  }
}

class UserDataClass {
  String? nameEng;
  String? nameAr;
  String? email;
  String? countryCode;
  String? mobile;
  String? gender;
  String? updatedAt;
  String? createdAt;
  int? id;
  String? userDisplayId;
  int? numberOfRequests;
  int? numberOfCompletedServices;
  int? numberOfCancelledServices;
  int? numberOfServices;

  UserDataClass(
      {this.nameEng,
        this.nameAr,
        this.email,
        this.countryCode,
        this.mobile,
        this.gender,
        this.updatedAt,
        this.createdAt,
        this.id,
        this.userDisplayId,
        this.numberOfRequests,
        this.numberOfCompletedServices,
        this.numberOfCancelledServices,
        this.numberOfServices});

  UserDataClass.fromJson(Map<String, dynamic> json) {
    nameEng = json['name_eng'];
    nameAr = json['name_ar'];
    email = json['email'];
    countryCode = json['country_code'];
    mobile = json['mobile'];
    gender = json['gender'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    userDisplayId = json['user_display_id'];
    numberOfRequests = json['number_of_requests'];
    numberOfCompletedServices = json['number_of_completed_services'];
    numberOfCancelledServices = json['number_of_cancelled_services'];
    numberOfServices = json['number_of_services'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name_eng'] = this.nameEng;
    data['name_ar'] = this.nameAr;
    data['email'] = this.email;
    data['country_code'] = this.countryCode;
    data['mobile'] = this.mobile;
    data['gender'] = this.gender;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['user_display_id'] = this.userDisplayId;
    data['number_of_requests'] = this.numberOfRequests;
    data['number_of_completed_services'] = this.numberOfCompletedServices;
    data['number_of_cancelled_services'] = this.numberOfCancelledServices;
    data['number_of_services'] = this.numberOfServices;
    return data;
  }
}

