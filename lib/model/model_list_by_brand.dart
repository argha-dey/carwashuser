class VehiclelmodellistbybrandModel {
  bool? success;
  List<VehicleModelList>? vehicleModelList;

  VehiclelmodellistbybrandModel({this.success, this.vehicleModelList});

  VehiclelmodellistbybrandModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      vehicleModelList = <VehicleModelList>[];
      json['data'].forEach((v) {
        vehicleModelList!.add(VehicleModelList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (vehicleModelList != null) {
      data['data'] = vehicleModelList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


/* {
    "data": [
        {
            "car_model_id": 4,
            "model_name": "Marcia Gillespie"
        },
        {
            "car_model_id": 3,
            "model_name": "Tiger Martin"
        },
        {
            "car_model_id": 2,
            "model_name": "Alana Mcbride"
        },
        {
            "car_model_id": 1,
            "model_name": "Ciara Underwood"
        }
    ]
}*/

class VehicleModelList {

  String? car_model_id;
  String? model_name;




  VehicleModelList(
      {
        this.car_model_id,
        this.model_name
      }
      );

  VehicleModelList.fromJson(Map<String, dynamic> json) {
    car_model_id = json['car_model_id'].toString();
    model_name = json['car_model_name'].toString();

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['car_model_id'] = car_model_id;
    data['car_model_name'] = model_name;

    return data;
  }
}
