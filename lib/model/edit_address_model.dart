class EditAdderssModel {
  bool? success;
  String? message;
  String? error;

  EditAdderssModel({this.success, this.message});

  EditAdderssModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['error'] = error;
    return data;
  }
}
