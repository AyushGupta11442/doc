class Review_class {
  Data? data;

  Review_class({this.data});

  Review_class.fromJson(Map<String, dynamic> json) {
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
  String? message;
  String? doctorID;
  String? doctorName;
  int? totalDoctorReview;
  String? doctorRecomended;
  List<PatientReviews>? patientReviews;

  Data(
      {this.message,
      this.doctorID,
      this.doctorName,
      this.totalDoctorReview,
      this.doctorRecomended,
      this.patientReviews});

  Data.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    doctorID = json['Doctor ID'];
    doctorName = json['Doctor Name'];
    totalDoctorReview = json['Total Doctor Review'];
    doctorRecomended = json['Doctor Recomended'];
    if (json['Patient Reviews'] != null) {
      patientReviews = <PatientReviews>[];
      json['Patient Reviews'].forEach((v) {
        patientReviews?.add(PatientReviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['Doctor ID'] = doctorID;
    data['Doctor Name'] = doctorName;
    data['Total Doctor Review'] = totalDoctorReview;
    data['Doctor Recomended'] = doctorRecomended;
    if (patientReviews != null) {
      data['Patient Reviews'] =
          patientReviews?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PatientReviews {
  int? id;
  int? customerId;
  String? experience;
  String? duration;
  String? reaction;
  int? recommend;
  String? problemDescription;
  String? createdAt;
  Customer? customer;

  PatientReviews(
      {this.id,
      this.customerId,
      this.experience,
      this.duration,
      this.reaction,
      this.recommend,
      this.problemDescription,
      this.createdAt,
      this.customer});

  PatientReviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    experience = json['experience'];
    duration = json['duration'];
    reaction = json['reaction'];
    recommend = json['recommend'];
    problemDescription = json['problem_description'];
    createdAt = json['created_at'];
    customer = json['customer'] != null
        ? Customer.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['customer_id'] = customerId;
    data['experience'] = experience;
    data['duration'] = duration;
    data['reaction'] = reaction;
    data['recommend'] = recommend;
    data['problem_description'] = problemDescription;
    data['created_at'] = createdAt;
    if (customer != null) {
      data['customer'] = customer?.toJson();
    }
    return data;
  }
}

class Customer {
  int? id;
  String? name;
  String? imageFile;
  String? gender;
  String? dateOfBirth;
  int? age;

  Customer(
      {this.id,
      this.name,
      this.imageFile,
      this.gender,
      this.dateOfBirth,
      this.age});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageFile = json['image_file'];
    gender = json['gender'];
    dateOfBirth = json['date_of_birth'];
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image_file'] = imageFile;
    data['gender'] = gender;
    data['date_of_birth'] = dateOfBirth;
    data['age'] = age;
    return data;
  }
}
