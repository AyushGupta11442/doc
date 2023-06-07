class Doctor_about_class {
  Data? data;

  Doctor_about_class({this.data});

  Doctor_about_class.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    return data;
  }
}

class Data {
  List? errors;
  String? message;
  Doctor? doctor;
  List<District>? district;
  List<Qualification>? qualification;
  List<Speciality>? speciality;

  Data(
      {this.errors,
      this.message,
      this.doctor,
      this.district,
      this.qualification,
      this.speciality});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['errors'] != null) {
      errors = json['error'];
    }
    message = json['message'];
    doctor =
        json['doctor'] != null ? Doctor.fromJson(json['doctor']) : null;
    if (json['district'] != null) {
      district = <District>[];
      json['district'].forEach((v) {
        district?.add(District.fromJson(v));
      });
    }
    if (json['qualification'] != null) {
      qualification = <Qualification>[];
      json['qualification'].forEach((v) {
        qualification?.add(Qualification.fromJson(v));
      });
    }
    if (json['speciality'] != null) {
      speciality = <Speciality>[];
      json['speciality'].forEach((v) {
        speciality?.add(Speciality.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (errors != null) {
      data['errors'] = errors?.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    if (doctor != null) {
      data['doctor'] = doctor?.toJson();
    }
    if (district != null) {
      data['district'] = district?.map((v) => v.toJson()).toList();
    }
    if (qualification != null) {
      data['qualification'] =
          qualification?.map((v) => v.toJson()).toList();
    }
    if (speciality != null) {
      data['speciality'] = speciality?.map((v) => v.toJson()).toList();
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
      this.accountStatus});

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

class Qualification {
  int? id;
  int? doctorId;
  int? degreeId;
  int? collegeId;
  int? passingYear;
  String? createdAt;
  String? updatedAt;
  Degree? degree;
  College? college;

  Qualification(
      {this.id,
      this.doctorId,
      this.degreeId,
      this.collegeId,
      this.passingYear,
      this.createdAt,
      this.updatedAt,
      this.degree,
      this.college});

  Qualification.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doctorId = json['doctor_id'];
    degreeId = json['degree_id'];
    collegeId = json['college_id'];
    passingYear = json['passing_year'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    degree =
        json['degree'] != null ? new Degree.fromJson(json['degree']) : null;
    college =
        json['college'] != null ? new College.fromJson(json['college']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['doctor_id'] = doctorId;
    data['degree_id'] = degreeId;
    data['college_id'] = collegeId;
    data['passing_year'] = passingYear;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
     if (this.degree != null) {
      data['degree'] = this.degree!.toJson();
    }
    if (this.college != null) {
      data['college'] = this.college!.toJson();
    }
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
      data['pivot'] = pivot?.toJson();
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

class Degree {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  Degree({this.id, this.name, this.createdAt, this.updatedAt});

  Degree.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class College {
  int? id;
  String? medicalCollegeName;
  String? createdAt;
  String? updatedAt;

  College({this.id, this.medicalCollegeName, this.createdAt, this.updatedAt});

  College.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    medicalCollegeName = json['medical_college_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['medical_college_name'] = this.medicalCollegeName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
