class clinicReview {
  Data? data;

  clinicReview({this.data});

  clinicReview.fromJson(Map<String, dynamic> json) {
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
  List<Reviews>? reviews;

  Data({this.errors, this.message, this.reviews});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['errors'] != null) {
      errors = [];
      json['errors'].forEach((v) {
        errors!.add(v);
      });
    }
    message = json['message'];
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(Reviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (reviews != null) {
      data['reviews'] = reviews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Reviews {
  int? id;
  int? clinicDetailId;
  int? customerId;
  int? rating;
  String? message;
  String? createdAt;
  String? updatedAt;
  String? reply; //fsdfsdfsdfsdf
  Customer? customer;

  Reviews(
      {this.id,
      this.clinicDetailId,
      this.customerId,
      this.rating,
      this.message,
      this.createdAt,
      this.updatedAt,
      this.reply,
      this.customer});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clinicDetailId = json['clinic_detail_id'];
    customerId = json['customer_id'];
    rating = json['rating'];
    message = json['message'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    reply = json['reply'];
    customer = json['customer'] != null
        ? Customer.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['clinic_detail_id'] = clinicDetailId;
    data['customer_id'] = customerId;
    data['rating'] = rating;
    data['message'] = message;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['reply'] = reply;
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    return data;
  }
}

class Customer {
  int? id;
  String? name;
  String? countryCode;
  String? phoneNumber;
  String? email;
  String? createdAt;
  String? updatedAt;
  String? gender;
  String? dateOfBirth;
  String? bloodGroup;
  String? height;
  int? weight;
  String? address;
  String? smokingHabits;
  String? alcoholConsumption;
  String? foodPreference;
  String? activityLevel;
  String? occupation;
  String? maritalStatus;
  String? allergies;
  String? chronicDiseases;
  String? injuries;
  String? surgeries;
  String? imageFile;
  String? phoneVerifiedAt;
  String? otpToken;
  String? accountStatus; //srtgdfgd
  String? emailVerifiedAt;
  String? emailOtpToken;

  Customer(
      {this.id,
      this.name,
      this.countryCode,
      this.phoneNumber,
      this.email,
      this.createdAt,
      this.updatedAt,
      this.gender,
      this.dateOfBirth,
      this.bloodGroup,
      this.height,
      this.weight,
      this.address,
      this.smokingHabits,
      this.alcoholConsumption,
      this.foodPreference,
      this.activityLevel,
      this.occupation,
      this.maritalStatus,
      this.allergies,
      this.chronicDiseases,
      this.injuries,
      this.surgeries,
      this.imageFile,
      this.phoneVerifiedAt,
      this.otpToken,
      this.accountStatus,
      this.emailVerifiedAt,
      this.emailOtpToken});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    countryCode = json['country_code'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    gender = json['gender'];
    dateOfBirth = json['date_of_birth'];
    bloodGroup = json['blood_group'];
    height = json['height'];
    weight = json['weight'];
    address = json['address'];
    smokingHabits = json['smoking_habits'];
    alcoholConsumption = json['alcohol_consumption'];
    foodPreference = json['food_preference'];
    activityLevel = json['activity_level'];
    occupation = json['occupation'];
    maritalStatus = json['marital_status'];
    allergies = json['allergies'];
    chronicDiseases = json['chronic_diseases'];
    injuries = json['injuries'];
    surgeries = json['surgeries'];
    imageFile = json['image_file'];
    phoneVerifiedAt = json['phone_verified_at'];
    otpToken = json['otp_token'];
    accountStatus = json['account_status'];
    emailVerifiedAt = json['email_verified_at'];
    emailOtpToken = json['email_otp_token'];
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
    data['gender'] = gender;
    data['date_of_birth'] = dateOfBirth;
    data['blood_group'] = bloodGroup;
    data['height'] = height;
    data['weight'] = weight;
    data['address'] = address;
    data['smoking_habits'] = smokingHabits;
    data['alcohol_consumption'] = alcoholConsumption;
    data['food_preference'] = foodPreference;
    data['activity_level'] = activityLevel;
    data['occupation'] = occupation;
    data['marital_status'] = maritalStatus;
    data['allergies'] = allergies;
    data['chronic_diseases'] = chronicDiseases;
    data['injuries'] = injuries;
    data['surgeries'] = surgeries;
    data['image_file'] = imageFile;
    data['phone_verified_at'] = phoneVerifiedAt;
    data['otp_token'] = otpToken;
    data['account_status'] = accountStatus;
    data['email_verified_at'] = emailVerifiedAt;
    data['email_otp_token'] = emailOtpToken;
    return data;
  }
}
