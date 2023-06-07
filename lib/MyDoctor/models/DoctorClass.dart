class mydoctor_class {
  Data? data;

  mydoctor_class({this.data});

  mydoctor_class.fromJson(Map<String, dynamic> json) {
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
  List<Doctor>? doctor;

  Data({this.message, this.doctor});

  Data.fromJson(Map<String, dynamic> json) {
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
  List<Speciality>? speciality;
  List<ClinicDetails>? clinicDetails;

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
      this.speciality,
      this.clinicDetails});

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
    if (json['speciality'] != null) {
      speciality = <Speciality>[];
      json['speciality'].forEach((v) {
        speciality!.add(Speciality.fromJson(v));
      });
    }
     if (json['clinic_details'] != null) {
      clinicDetails = <ClinicDetails>[];
      json['clinic_details'].forEach((v) {
        clinicDetails!.add(new ClinicDetails.fromJson(v));
      });
    }
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
    if (speciality != null) {
      data['speciality'] = speciality!.map((v) => v.toJson()).toList();
    }
    if (this.clinicDetails != null) {
      data['clinic_details'] =
          this.clinicDetails!.map((v) => v.toJson()).toList();
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
  // Pivot? pivot;

  Speciality(
      {this.id,
      this.name,
      this.status,
      this.createdAt,
      this.updatedAt,
      // this.pivot
      });

  Speciality.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    // pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    // if (pivot != null) {
    //   data['pivot'] = pivot!.toJson();
    // }
    return data;
  }
}

// class Pivot {
//   int? doctorId;
//   int? specialityId;

//   Pivot({this.doctorId, this.specialityId});

//   Pivot.fromJson(Map<String, dynamic> json) {
//     doctorId = json['doctor_id'];
//     specialityId = json['speciality_id'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['doctor_id'] = doctorId;
//     data['speciality_id'] = specialityId;
//     return data;
//   }
// }

class ClinicDetails {
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
  Pivot? pivot;

  ClinicDetails(
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
      this.about,
      this.pivot});

  ClinicDetails.fromJson(Map<String, dynamic> json) {
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
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['clinic_type_id'] = this.clinicTypeId;
    data['district_id'] = this.districtId;
    data['address'] = this.address;
    data['clinic_number'] = this.clinicNumber;
    data['fees'] = this.fees;
    data['owner_id'] = this.ownerId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image_file'] = this.imageFile;
    data['about'] = this.about;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? doctorId;
  int? clinicDetailId;
  String? createdAt;
  String? updatedAt;

  Pivot({this.doctorId, this.clinicDetailId, this.createdAt, this.updatedAt});

  Pivot.fromJson(Map<String, dynamic> json) {
    doctorId = json['doctor_id'];
    clinicDetailId = json['clinic_detail_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doctor_id'] = this.doctorId;
    data['clinic_detail_id'] = this.clinicDetailId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
