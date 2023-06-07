class search_by_clinic_id {
  Data? data;

  search_by_clinic_id({this.data});

  search_by_clinic_id.fromJson(Map<String, dynamic> json) {
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
  List<Clinices>? clinices;

  Data({this.clinices});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['clinices'] != null) {
      clinices = <Clinices>[];
      json['clinices'].forEach((v) {
        clinices!.add(Clinices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (clinices != null) {
      data['clinices'] = clinices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Clinices {
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
  String? selectId;
  String? idPhoto;
  String? registrationDocument;
  String? imageFile;
  String? about;
  String? avarageRating;
  int? ownClinic;
  int? visitClinic;
  ClinicTypee? clinicType;

  Clinices(
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
      this.selectId,
      this.idPhoto,
      this.registrationDocument,
      this.imageFile,
      this.about,
      this.avarageRating,
      this.ownClinic,
      this.visitClinic,
      this.clinicType});

  Clinices.fromJson(Map<String, dynamic> json) {
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
    selectId = json['select_id'];
    idPhoto = json['id_photo'];
    registrationDocument = json['registration_document'];
    imageFile = json['image_file'];
    about = json['about'];
    avarageRating = json['avarage_rating'];
    ownClinic = json['own_clinic'];
    visitClinic = json['visit_clinic'];
    clinicType = json['clinic_type'] != null
        ? ClinicTypee.fromJson(json['clinic_type'])
        : null;
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
    data['select_id'] = selectId;
    data['id_photo'] = idPhoto;
    data['registration_document'] = registrationDocument;
    data['image_file'] = imageFile;
    data['about'] = about;
    data['avarage_rating'] = avarageRating;
    data['own_clinic'] = ownClinic;
    data['visit_clinic'] = visitClinic;
    if (clinicType != null) {
      data['clinic_type'] = clinicType!.toJson();
    }
    return data;
  }
}

class ClinicTypee {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  ClinicTypee({this.id, this.name, this.createdAt, this.updatedAt});

  ClinicTypee.fromJson(Map<String, dynamic> json) {
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
