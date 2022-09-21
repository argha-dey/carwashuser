class AppointmentModel {

  String? message;

  AppointmentModel({this.message});

  AppointmentModel.fromJson(Map<String, dynamic> json) {

    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['message'] = message;
    return data;
  }
}
