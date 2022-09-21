class GetaddressModel {

  List<GetAddressdata>? data;

  GetaddressModel({this.data});

  GetaddressModel.fromJson(Map<String, dynamic> json) {

    if (json['data'] != null) {
      data = <GetAddressdata>[];
      json['data'].forEach((v) {
        data!.add(GetAddressdata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetAddressdata {
  String? id;
  String? address;


  GetAddressdata({this.id, this.address});

  GetAddressdata.fromJson(Map<String, dynamic> json) {
   id = json['user_address_id'].toString();
    address = json['add_line1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_address_id'] = id;
    data['add_line1'] = address;
    return data;
  }
}
