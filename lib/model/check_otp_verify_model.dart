class CheckOtpVerifyModel {

  String? otp;
  bool? status;
  String? token;
  String? message;

  CheckOtpVerifyModel(
      {
      this.otp,
      this.status,
      this.token,
      this.message});

  CheckOtpVerifyModel.fromJson(Map<String, dynamic> json) {

    otp = json['otp'].toString();
    status = json['status'];
    token = json['token'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['otp'] = otp;
    data['status'] = status;
    data['token'] = token;
    data['message'] = message;
    return data;
  }
}

