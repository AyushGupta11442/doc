class clinic_detail {
  Data? data;

  clinic_detail({this.data});

  clinic_detail.fromJson(Map<String, dynamic> json) {
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
  List? errors;
  String? message;
  ClinicDetail? clinicDetail;
  RegistrationDetails? registrationDetails;
  List<ClinicType>? clinicType;
  List<District>? district;
  List<ClinicTime>? clinicTime;
  List<ClinicService>? clinicService;
  List<ClinicSpeciality>? clinicSpeciality;

  Data(
      {this.errors,
      this.message,
      this.clinicDetail,
      this.registrationDetails,
      this.clinicType,
      this.district,
      this.clinicTime,
      this.clinicService,
      this.clinicSpeciality});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['errors'] != null) {
      errors = json['errors'];
    }
    message = json['message'];
    clinicDetail = json['clinic_detail'] != null
        ? ClinicDetail.fromJson(json['clinic_detail'])
        : null;
    registrationDetails = json['registration_details'] != null
        ? RegistrationDetails.fromJson(json['registration_details'])
        : null;
    if (json['clinic_type'] != null) {
      clinicType = <ClinicType>[];
      json['clinic_type'].forEach((v) {
        clinicType!.add(ClinicType.fromJson(v));
      });
    }
    if (json['district'] != null) {
      district = <District>[];
      json['district'].forEach((v) {
        district!.add(District.fromJson(v));
      });
    }
    if (json['clinic_time'] != null) {
      clinicTime = <ClinicTime>[];
      json['clinic_time'].forEach((v) {
        clinicTime!.add(ClinicTime.fromJson(v));
      });
    }
    if (json['clinic_service'] != null) {
      clinicService = <ClinicService>[];
      json['clinic_service'].forEach((v) {
        clinicService!.add(ClinicService.fromJson(v));
      });
    }
    if (json['clinic_speciality'] != null) {
      clinicSpeciality = <ClinicSpeciality>[];
      json['clinic_speciality'].forEach((v) {
        clinicSpeciality!.add(ClinicSpeciality.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (errors != null) {
      data['errors'] = errors!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    if (clinicDetail != null) {
      data['clinic_detail'] = clinicDetail!.toJson();
    }
    if (registrationDetails != null) {
      data['registration_details'] = registrationDetails!.toJson();
    }
    if (clinicType != null) {
      data['clinic_type'] = clinicType!.map((v) => v.toJson()).toList();
    }
    if (district != null) {
      data['district'] = district!.map((v) => v.toJson()).toList();
    }
    if (clinicTime != null) {
      data['clinic_time'] = clinicTime!.map((v) => v.toJson()).toList();
    }
    if (clinicService != null) {
      data['clinic_service'] =
          clinicService!.map((v) => v.toJson()).toList();
    }
    if (clinicSpeciality != null) {
      data['clinic_speciality'] =
          clinicSpeciality!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ClinicDetail {
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

  ClinicDetail(
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

  ClinicDetail.fromJson(Map<String, dynamic> json) {
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

class RegistrationDetails {
  String? phoneNumber;
  String? email;
  String? registrationNo;
  int? registrationYear;
  String? registrationCouncil;
  RegistrationCouncils? registrationCouncils;

  RegistrationDetails(
      {this.phoneNumber,
      this.email,
      this.registrationNo,
      this.registrationYear,
      this.registrationCouncil,
      this.registrationCouncils});

  RegistrationDetails.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phone_number'];
    email = json['email'];
    registrationNo = json['registration_no'];
    registrationYear = json['registration_year'];
    registrationCouncil = json['registration_council'];
    registrationCouncils = json['registration_councils'] != null
        ? RegistrationCouncils.fromJson(json['registration_councils'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone_number'] = phoneNumber;
    data['email'] = email;
    data['registration_no'] = registrationNo;
    data['registration_year'] = registrationYear;
    data['registration_council'] = registrationCouncil;
    if (registrationCouncils != null) {
      data['registration_councils'] = registrationCouncils!.toJson();
    }
    return data;
  }
}

class RegistrationCouncils {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  RegistrationCouncils({this.id, this.name, this.createdAt, this.updatedAt});

  RegistrationCouncils.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
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

class ClinicTime {
  int? id;
  int? clinicId;
  String? day;
  String? openingTime;
  String? closingTime;
  String? createdAt;
  String? updatedAt;
  int? doctorId;
  String? consultationDuration;
  String? availableSlots;

  ClinicTime(
      {this.id,
      this.clinicId,
      this.day,
      this.openingTime,
      this.closingTime,
      this.createdAt,
      this.updatedAt,
      this.doctorId,
      this.consultationDuration,
      this.availableSlots});

  ClinicTime.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clinicId = json['clinic_id'];
    day = json['day'];
    openingTime = json['opening_time'];
    closingTime = json['closing_time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    doctorId = json['doctor_id'];
    consultationDuration = json['consultation_duration'];
    availableSlots = json['available_slots'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['clinic_id'] = clinicId;
    data['day'] = day;
    data['opening_time'] = openingTime;
    data['closing_time'] = closingTime;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['doctor_id'] = doctorId;
    data['consultation_duration'] = consultationDuration;
    data['available_slots'] = availableSlots;
    return data;
  }
}

class ClinicService {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;

  ClinicService(
      {this.id, this.name, this.createdAt, this.updatedAt, this.pivot});

  ClinicService.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (pivot != null) {
      data['pivot'] = pivot!.toJson();
    }
    return data;
  }
}

class ClinicType {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  ClinicType({this.id, this.name, this.createdAt, this.updatedAt});

  ClinicType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['clinic_detail_id'] = id;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class ClinicSpeciality {
  int? id;
  String? name;
  int? status;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;

  ClinicSpeciality(
      {this.id,
      this.name,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.pivot});

  ClinicSpeciality.fromJson(Map<String, dynamic> json) {
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
  int? clinicDetailId;
  int? specialityId;
  String? createdAt;
  String? updatedAt;

  Pivot(
      {this.clinicDetailId, this.specialityId, this.createdAt, this.updatedAt});

  Pivot.fromJson(Map<String, dynamic> json) {
    clinicDetailId = json['clinic_detail_id'];
    specialityId = json['speciality_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['clinic_detail_id'] = clinicDetailId;
    data['speciality_id'] = specialityId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
