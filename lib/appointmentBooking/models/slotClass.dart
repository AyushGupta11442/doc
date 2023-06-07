class slotClass {
  int? id;
  String? availableSlot;
  String? day;
  int? status;

  slotClass({this.id, this.availableSlot, this.day, this.status});

  slotClass.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    availableSlot = json['available_slot'];
    day = json['day'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['available_slot'] = this.availableSlot;
    data['day'] = this.day;
    data['status'] = this.status;
    return data;
  }
}
