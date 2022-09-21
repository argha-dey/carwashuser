class Paymentstatusmodel {
  bool? success;
  String? message;

  Paymentstatusmodel({this.success, this.message});

  Paymentstatusmodel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    return data;
  }
}
