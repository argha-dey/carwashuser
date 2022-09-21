class AddvehicleModel {
  bool? success;
  String? message;
  String? error;
  AddvehicleModel({this.success, this.message, this.error});

  AddvehicleModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['error'] = error;
    
    return data;
  }
}
