class GetaddressbyidModel {
  bool? success;
  Data? data;

  GetaddressbyidModel({this.success, this.data});

  GetaddressbyidModel.fromJson(Map<String, dynamic> json) {
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
  String? addLine1;
  String? addLine2;
  String? landmark;
  String? city;
  String? zip;

  Data({this.addLine1, this.addLine2, this.landmark, this.city, this.zip});

  Data.fromJson(Map<String, dynamic> json) {
    addLine1 = json['add_line1'];
    addLine2 = json['add_line2'];
    landmark = json['landmark'];
    city = json['city'];
    zip = json['zip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['add_line1'] = addLine1;
    data['add_line2'] = addLine2;
    data['landmark'] = landmark;
    data['city'] = city;
    data['zip'] = zip;
    return data;
  }
}
