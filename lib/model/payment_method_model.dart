class PaymentmethodModel {
  bool? success;
  List<Paymentmethod>? data;

  PaymentmethodModel({this.success, this.data});

  PaymentmethodModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Paymentmethod>[];
      json['data'].forEach((v) {
        data!.add(Paymentmethod.fromJson(v));
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

class Paymentmethod {
  String? id;
  String? name;
  String? slug;

  Paymentmethod({this.id, this.name,this.slug});

  Paymentmethod.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    return data;
  }
}
