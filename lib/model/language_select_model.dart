class LanguageSelectModel {
  Data? data;
  bool? success;
  String? message;

  LanguageSelectModel({this.data, this.success, this.message});

  LanguageSelectModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['success'] = success;
    data['message'] = message;
    return data;
  }
}

class Data {
  String? eng;
  String? ar;

  Data({this.eng, this.ar});

  Data.fromJson(Map<String, dynamic> json) {
    eng = json['eng'];
    ar = json['ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['eng'] = eng;
    data['ar'] = ar;
    return data;
  }
}
