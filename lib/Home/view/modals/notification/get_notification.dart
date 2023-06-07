class get_notification {
  Data? data;

  get_notification({this.data});

  get_notification.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? message;
  List<Notification_data>? notification;
  Data({this.message, this.notification});
  Data.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['notification'] != null) {
      notification = <Notification_data>[];
      json['notification'].forEach((v) {
        notification?.add(Notification_data.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (notification != null) {
      data['notification'] = notification!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notification_data {
  String? id;
  String? type;
  String? notifiableType;
  int? notifiableId;
  Datas? data;
  String? readAt;
  String? createdAt;
  String? updatedAt;

  Notification_data(
      {this.id,
      this.type,
      this.notifiableType,
      this.notifiableId,
      this.data,
      this.readAt,
      this.createdAt,
      this.updatedAt});

  Notification_data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    notifiableType = json['notifiable_type'];
    notifiableId = json['notifiable_id'];
    data = json['data'] != null ? Datas.fromJson(json['data']) : null;
    readAt = json['read_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['notifiable_type'] = notifiableType;
    data['notifiable_id'] = notifiableId;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['read_at'] = readAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Datas {
  String? type;
  String? appointmentId;
  String? customerName;
  String? date;
  String? doctorName;
  String? slotTiming;

  Datas(
      {this.type,
      this.appointmentId,
      this.customerName,
      this.date,
      this.doctorName,
      this.slotTiming});

  Datas.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    appointmentId = json['appointment_id'];
    customerName = json['customer_name'];
    date = json['date'];
    doctorName = json['doctor_name'];
    slotTiming = json['slot_timing'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['appointment_id'] = appointmentId;
    data['customer_name'] = customerName;
    data['date'] = date;
    data['doctor_name'] = doctorName;
    data['slot_timing'] = slotTiming;
    return data;
  }
}
