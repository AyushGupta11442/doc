class consultants_list {
  Data? data;

  consultants_list({this.data});

  consultants_list.fromJson(Map<String, dynamic> json) {
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
  List<void>? errors;
  String? message;
  List<Doctor>? doctor;

  Data({this.errors, this.message, this.doctor});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['errors'] != null) {
      errors = json['errors'];
    }
    message = json['message'];
    if (json['doctor'] != null) {
      doctor = <Doctor>[];
      json['doctor'].forEach((v) {
        doctor!.add(Doctor.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (doctor != null) {
      data['doctor'] = doctor!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Doctor {
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
  String? recommend;
  int? consultationFee;
  NextSlot? nextSlot;
  Pivot? pivot;
  List<Speciality>? speciality;
  District? district;

  Doctor(
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
      this.recommend,
      this.consultationFee,
      this.nextSlot,
      this.pivot,
      this.speciality,
      this.district});

  Doctor.fromJson(Map<String, dynamic> json) {
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
    recommend = json['recommend'];
    consultationFee = json['consultation_fee'];
    nextSlot = json['next_slot'] != null
        ? NextSlot.fromJson(json['next_slot'])
        : null;
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
    if (json['speciality'] != null) {
      speciality = <Speciality>[];
      json['speciality'].forEach((v) {
        speciality!.add(Speciality.fromJson(v));
      });
    }
    district = json['district'] != null
        ? District.fromJson(json['district'])
        : null;
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
    data['recommend'] = recommend;
    data['consultation_fee'] = consultationFee;
    if (nextSlot != null) {
      data['next_slot'] = nextSlot!.toJson();
    }
    if (pivot != null) {
      data['pivot'] = pivot!.toJson();
    }
    if (speciality != null) {
      data['speciality'] = speciality!.map((v) => v.toJson()).toList();
    }
    if (district != null) {
      data['district'] = district!.toJson();
    }
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

class Pivot {
  int? clinicDetailId;
  int? doctorId;
  String? createdAt;
  String? updatedAt;

  Pivot({this.clinicDetailId, this.doctorId, this.createdAt, this.updatedAt});

  Pivot.fromJson(Map<String, dynamic> json) {
    clinicDetailId = json['clinic_detail_id'];
    doctorId = json['doctor_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['clinic_detail_id'] = clinicDetailId;
    data['doctor_id'] = doctorId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Speciality {
  int? id;
  String? name;
  int? status;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;

  Speciality(
      {this.id,
      this.name,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.pivot});

  Speciality.fromJson(Map<String, dynamic> json) {
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
