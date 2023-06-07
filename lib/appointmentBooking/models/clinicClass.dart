class ClinicClass {
  int ?id;
  String? name;
  String ?address;
  String ?clinicNumber;
  int ?fees;
  String ?imageFile;

  ClinicClass(
      {this.id,
      this.name,
      this.address,
      this.clinicNumber,
      this.fees,
      this.imageFile});

  ClinicClass.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    clinicNumber = json['clinic_number'];
    fees = json['fees'];
    imageFile = json['image_file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['clinic_number'] = clinicNumber;
    data['fees'] = fees;
    data['image_file'] = imageFile;
    return data;
  }
}
