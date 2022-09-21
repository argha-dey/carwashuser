class GetbillingaddressModel {
  bool? success;
  Data? data;

  GetbillingaddressModel({this.success, this.data});

  GetbillingaddressModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? billingAddress;

  Data({this.billingAddress});

  Data.fromJson(Map<String, dynamic> json) {
    billingAddress = json['billing_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['billing_address'] = billingAddress;
    return data;
  }
}
