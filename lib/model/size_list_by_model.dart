

class VehiclelsizelistbybrandModel {
  bool? success;
  List<VehicleSizeList>? vehicleSizeList;

  VehiclelsizelistbybrandModel({this.success, this.vehicleSizeList});

  VehiclelsizelistbybrandModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      vehicleSizeList = <VehicleSizeList>[];
      json['data'].forEach((v) {
        vehicleSizeList!.add(VehicleSizeList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (vehicleSizeList != null) {
      data['data'] = vehicleSizeList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


/* {
    "data": [
        {
            "car_size_id": 4,
            "size_name": "Lydia Montoya"
        },
        {
            "car_size_id": 3,
            "size_name": "Madonna Lee"
        },
        {
            "car_size_id": 2,
            "size_name": "Signe Holloway"
        },
        {
            "car_size_id": 1,
            "size_name": "Rooney Hyde"
        }
    ]
}*/

class VehicleSizeList {

  String? car_size_id;
  String? size_name;




  VehicleSizeList(
      {
        this.car_size_id,
        this.size_name
      }
      );

  VehicleSizeList.fromJson(Map<String, dynamic> json) {
    car_size_id = json['car_size_id'].toString();
    size_name = json['size_name'].toString();

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['car_size_id'] = car_size_id;
    data['size_name'] = size_name;

    return data;
  }
}
