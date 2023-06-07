class top_doctors {
  Data? data;

  top_doctors({this.data});

  top_doctors.fromJson(Map<String, dynamic> json) {
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
  List<Doctors>? doctors;

  Data({this.message, this.doctors});

  Data.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['doctors'] != null) {
      doctors = <Doctors>[];
      json['doctors'].forEach((v) {
        doctors!.add(Doctors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (doctors != null) {
      data['doctors'] = doctors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Doctors {
  int? id;
  String? name;
  String? countryCode;
  String? phoneNumber;
  String? email;
  String? createdAt;
  String? updatedAt;
  int? profileType;
  String? gender;
  String? registrationNo;
  String? registrationCouncil;
  int? registrationYear;
  int? experience;
  int? districtId;
  String? imageFile;
  String? selectId;
  String? idPhoto;
  String? registrationDocument;
  String? ownershipId;
  String? ownershipDocument;
  String? about;
  String? phoneVerifiedAt;
  String? otpToken;
  String? emailVerifiedAt;
  String? emailOtpToken;
  String? accountStatus;
  int? profileStatus;
  int? doctorReviewsCount;
  int? doctorRecomendCount;
  String? recommend;
  int? consultationFee;
  Clinic? clinic;
  NextSlot? nextSlot;
  List<Specialities>? specialities;
  District? district;

  Doctors(
      {this.id,
      this.name,
      this.countryCode,
      this.phoneNumber,
      this.email,
      this.createdAt,
      this.updatedAt,
      this.profileType,
      this.gender,
      this.registrationNo,
      this.registrationCouncil,
      this.registrationYear,
      this.experience,
      this.districtId,
      this.imageFile,
      this.selectId,
      this.idPhoto,
      this.registrationDocument,
      this.ownershipId,
      this.ownershipDocument,
      this.about,
      this.phoneVerifiedAt,
      this.otpToken,
      this.emailVerifiedAt,
      this.emailOtpToken,
      this.accountStatus,
      this.profileStatus,
      this.doctorReviewsCount,
      this.doctorRecomendCount,
      this.recommend,
      this.consultationFee,
      this.clinic,
      this.nextSlot,
      this.specialities,
      this.district});

  Doctors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    countryCode = json['country_code'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    profileType = json['profile_type'];
    gender = json['gender'];
    registrationNo = json['registration_no'];
    registrationCouncil = json['registration_council'];
    registrationYear = json['registration_year'];
    experience = json['experience'];
    districtId = json['district_id'];
    imageFile = json['image_file'];
    selectId = json['select_id'];
    idPhoto = json['id_photo'];
    registrationDocument = json['registration_document'];
    ownershipId = json['ownership_id'];
    ownershipDocument = json['ownership_document'];
    about = json['about'];
    phoneVerifiedAt = json['phone_verified_at'];
    otpToken = json['otp_token'];
    emailVerifiedAt = json['email_verified_at'];
    emailOtpToken = json['email_otp_token'];
    accountStatus = json['account_status'];
    profileStatus = json['profile_status'];
    doctorReviewsCount = json['doctor_reviews_count'];
    doctorRecomendCount = json['doctor_recomend_count'];
    recommend = json['recommend'];
    consultationFee = json['consultation_fee'];
    clinic = json['clinic'] != null ? Clinic.fromJson(json['clinic']) : null;
    nextSlot = null;
    // json['next_slot'] != null ? NextSlot.fromJson(json['next_slot']) : null;
    if (json['specialities'] != null) {
      specialities = <Specialities>[];
      json['specialities'].forEach((v) {
        specialities!.add(Specialities.fromJson(v));
      });
    }
    district =
        json['district'] != null ? District.fromJson(json['district']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['country_code'] = countryCode;
    data['phone_number'] = phoneNumber;
    data['email'] = email;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['profile_type'] = profileType;
    data['gender'] = gender;
    data['registration_no'] = registrationNo;
    data['registration_council'] = registrationCouncil;
    data['registration_year'] = registrationYear;
    data['experience'] = experience;
    data['district_id'] = districtId;
    data['image_file'] = imageFile;
    data['select_id'] = selectId;
    data['id_photo'] = idPhoto;
    data['registration_document'] = registrationDocument;
    data['ownership_id'] = ownershipId;
    data['ownership_document'] = ownershipDocument;
    data['about'] = about;
    data['phone_verified_at'] = phoneVerifiedAt;
    data['otp_token'] = otpToken;
    data['email_verified_at'] = emailVerifiedAt;
    data['email_otp_token'] = emailOtpToken;
    data['account_status'] = accountStatus;
    data['profile_status'] = profileStatus;
    data['doctor_reviews_count'] = doctorReviewsCount;
    data['doctor_recomend_count'] = doctorRecomendCount;
    data['recommend'] = recommend;
    data['consultation_fee'] = consultationFee;
    if (clinic != null) {
      data['clinic'] = clinic!.toJson();
    }
    if (nextSlot != null) {
      data['next_slot'] = nextSlot!.toJson();
    }
    if (specialities != null) {
      data['specialities'] = specialities!.map((v) => v.toJson()).toList();
    }
    if (district != null) {
      data['district'] = district!.toJson();
    }
    return data;
  }
}

class Clinic {
  int? id;
  String? name;
  int? clinicTypeId;
  int? districtId;
  String? address;
  String? clinicNumber;
  int? fees;
  int? ownerId;
  String? createdAt;
  String? updatedAt;
  String? imageFile;
  String? about;

  Clinic(
      {this.id,
      this.name,
      this.clinicTypeId,
      this.districtId,
      this.address,
      this.clinicNumber,
      this.fees,
      this.ownerId,
      this.createdAt,
      this.updatedAt,
      this.imageFile,
      this.about});

  Clinic.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    clinicTypeId = json['clinic_type_id'];
    districtId = json['district_id'];
    address = json['address'];
    clinicNumber = json['clinic_number'];
    fees = json['fees'];
    ownerId = json['owner_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    imageFile = json['image_file'];
    about = json['about'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['clinic_type_id'] = clinicTypeId;
    data['district_id'] = districtId;
    data['address'] = address;
    data['clinic_number'] = clinicNumber;
    data['fees'] = fees;
    data['owner_id'] = ownerId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['image_file'] = imageFile;
    data['about'] = about;
    return data;
  }
}

class NextSlot {
  String? day;
  String? time;

  NextSlot({this.day, this.time});

  NextSlot.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['day'] = day;
    data['time'] = time;
    return data;
  }
}

class Specialities {
  int? id;
  String? name;
  int? status;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;

  Specialities(
      {this.id,
      this.name,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.pivot});

  Specialities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (pivot != null) {
      data['pivot'] = pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? doctorId;
  int? specialityId;
  int? healthChecked;
  int? appointmentChecked;
  int? healthStatus;
  String? createdAt;
  String? updatedAt;

  Pivot(
      {this.doctorId,
      this.specialityId,
      this.healthChecked,
      this.appointmentChecked,
      this.healthStatus,
      this.createdAt,
      this.updatedAt});

  Pivot.fromJson(Map<String, dynamic> json) {
    doctorId = json['doctor_id'];
    specialityId = json['speciality_id'];
    healthChecked = json['health_checked'];
    appointmentChecked = json['appointment_checked'];
    healthStatus = json['health_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['doctor_id'] = doctorId;
    data['speciality_id'] = specialityId;
    data['health_checked'] = healthChecked;
    data['appointment_checked'] = appointmentChecked;
    data['health_status'] = healthStatus;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class District {
  int? id;
  String? state;
  String? district;
  String? stateType;
  String? createdAt;
  String? updatedAt;

  District(
      {this.id,
      this.state,
      this.district,
      this.stateType,
      this.createdAt,
      this.updatedAt});

  District.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    state = json['state'];
    district = json['district'];
    stateType = json['state_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['state'] = state;
    data['district'] = district;
    data['state_type'] = stateType;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
