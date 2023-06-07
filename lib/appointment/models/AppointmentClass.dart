class Appointment {
  int? id;
  String? date;
  int? status;
  int? clinicDetailId;
  int? doctorId;
  int? customerId;
  String? appointmentFor;
  String? name;
  String? gender;
  String? phoneNumber;
  String? email;
  String? createdAt;
  String? updatedAt;
  int? slotId;
  String? slotTiming;
  String? report;
  int? type;
  String? doctor_name;
  String? doctor_image_file;
  String? clinic_name;
  String? doctor_speciality;

  Appointment(
      {this.id,
      this.date,
      this.status,
      this.clinicDetailId,
      this.doctorId,
      this.customerId,
      this.appointmentFor,
      this.name,
      this.gender,
      this.phoneNumber,
      this.email,
      this.createdAt,
      this.updatedAt,
      this.slotId,
      this.slotTiming,
      this.report,
      this.type,
      this.doctor_name,
      this.doctor_image_file,
      this.clinic_name,
      this.doctor_speciality});

  Appointment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    status = json['status'];
    clinicDetailId = json['clinic_detail_id'];
    doctorId = json['doctor_id'];
    customerId = json['customer_id'];
    appointmentFor = json['appointment_for'];
    name = json['name'];
    gender = json['gender'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    slotId = json['slot_id'];
    slotTiming = json['slot_timing'];
    report = json['report'];
    type = json['type'];
    // doctor =
    //     json['doctor'] != null ? Doctor.fromJson(json['doctor']) : null;
    // clinic =
    //     json['clinic'] != null ? Doctor.fromJson(json['clinic']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['status'] = status;
    data['clinic_detail_id'] = clinicDetailId;
    data['doctor_id'] = doctorId;
    data['customer_id'] = customerId;
    data['appointment_for'] = appointmentFor;
    data['name'] = name;
    data['gender'] = gender;
    data['phone_number'] = phoneNumber;
    data['email'] = email;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['slot_id'] = slotId;
    data['slot_timing'] = slotTiming;
    data['report'] = report;
    data['type'] = type;
    // if (doctor != null) {
    //   data['doctor'] = doctor!.toJson();
    // }
    // if (clinic != null) {
    //   data['clinic'] = clinic!.toJson();
    // }
    return data;
  }
}

class Doctor {
  int? id;
  String? name;
  String? image_file;

  Doctor({this.id, this.name, this.image_file});

  Doctor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image_file = json['image_file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image_file'] = image_file;
    return data;
  }
}
