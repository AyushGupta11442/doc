class searhedclinicdata {
 int? id;
  String? name;
  String? country_code;
  String? phone_number;
  String? email;
  String? created_at;
  String? updated_at;
  int? profile_type;
  String? gender;
  String? registration_no;
  String? registration_council;
  int? registration_year;
  int? experience;
  int? district_id;
  String? image_file;
  String? select_id;
  String? id_photo;
  String? registration_document;
  String? ownership_id;
  String? ownership_document;
  String? about;

  searhedclinicdata({ 
    this.id,
    this.name,
    this.country_code,
    this.phone_number,
    this.email,
    this.created_at,
    this.updated_at,
    this.profile_type,
    this.gender,
    this.registration_no,
    this.registration_council,
    this.registration_year,
    this.experience,
    this.district_id,
    this.image_file,
    this.select_id,
    this.id_photo,
    this.registration_document,
    this.ownership_id,
    this.ownership_document,
    this.about,
});

  searhedclinicdata.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['country_code'] = country_code;
    data['phone_number'] = phone_number;
    data['email'] = email;
    data['created_at'] = created_at;
    data['updated_at'] = updated_at;
    data['profile_type'] = profile_type;
    data['gender'] = gender;
    data['registration_no'] = registration_no;
    data['registration_council'] = registration_council;
    data['registration_year'] = registration_year;
    data['experience'] = experience;
    data['district_id'] = district_id;
    data['image_file'] = image_file;
    data['select_id'] = select_id;
    data['id_photo'] = id_photo;
    data['registration_document'] = registration_document;
    data['ownership_id'] = ownership_id;
    data['ownership_document'] = ownership_document;
    data['about'] = about;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['country_code'] = country_code;
    data['phone_number'] = phone_number;
    data['email'] = email;
    data['created_at'] = created_at;
    data['updated_at'] = updated_at;
    data['profile_type'] = profile_type;
    data['gender'] = gender;
    data['registration_no'] = registration_no;
    data['registration_council'] = registration_council;
    data['registration_year'] = registration_year;
    data['experience'] = experience;
    data['district_id'] = district_id;
    data['image_file'] = image_file;
    data['select_id'] = select_id;
    data['id_photo'] = id_photo;
    data['registration_document'] = registration_document;
    data['ownership_id'] = ownership_id;
    data['ownership_document'] = ownership_document;
    data['about'] = about;
    return data;
  }
}
