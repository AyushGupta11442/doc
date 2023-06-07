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
      this.updatedAt});

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
    return data;
  }
}
