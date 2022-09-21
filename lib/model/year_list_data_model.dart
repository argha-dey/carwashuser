class YearListDataModel {
  List<YearData>? data;


  YearListDataModel({this.data});

  YearListDataModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <YearData>[];
      json['data'].forEach((v) {
        data!.add(new YearData.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class YearData {
  int? yearId;
  String? yearName;

  YearData({this.yearId, this.yearName});

  YearData.fromJson(Map<String, dynamic> json) {
    yearId = json['year_id'];
    yearName = json['year_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['year_id'] = this.yearId;
    data['year_name'] = this.yearName;
    return data;
  }
}
