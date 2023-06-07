class dateClass {
  String? day;
  String? dateString;
  String ?date;

  dateClass({this.day, this.dateString, this.date});

  dateClass.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    dateString = json['dateString'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['day'] = day;
    data['dateString'] = dateString;
    data['date'] = date;
    return data;
  }
}
