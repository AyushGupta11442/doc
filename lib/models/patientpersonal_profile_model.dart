class PatientPersonalProfile {
  PatientPersonalProfile({
    required this.data,
  });

  final Data? data;

  factory PatientPersonalProfile.fromJson(Map<String, dynamic> json) {
    return PatientPersonalProfile(
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    required this.message,
    required this.profile,
  });

  final String message;
  final Profile? profile;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      message: json["message"] ?? "",
      profile:
          json["profile"] == null ? null : Profile.fromJson(json["profile"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "message": message,
        "profile": profile?.toJson(),
      };
}

class Profile {
  Profile({
    required this.id,
    required this.name,
    required this.countryCode,
    required this.phoneNumber,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
    required this.gender,
    required this.dateOfBirth,
    required this.bloodGroup,
    required this.height,
    required this.weight,
    required this.address,
    required this.smokingHabits,
    required this.alcoholConsumption,
    required this.foodPreference,
    required this.activityLevel,
    required this.occupation,
    required this.maritalStatus,
    required this.allergies,
    required this.chronicDiseases,
    required this.injuries,
    required this.surgeries,
    required this.imageFile,
  });

  final int id;
  final String name;
  final String countryCode;
  final String phoneNumber;
  final String email;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String gender;
  final dynamic dateOfBirth;
  final dynamic bloodGroup;
  final dynamic height;
  final dynamic weight;
  final dynamic address;
  final String smokingHabits;
  final String alcoholConsumption;
  final dynamic foodPreference;
  final dynamic activityLevel;
  final dynamic occupation;
  final dynamic maritalStatus;
  final String allergies;
  final dynamic chronicDiseases;
  final dynamic injuries;
  final dynamic surgeries;
  final String imageFile;

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      countryCode: json["country_code"] ?? "",
      phoneNumber: json["phone_number"] ?? "",
      email: json["email"] ?? "",
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
      gender: json["gender"] ?? "",
      dateOfBirth: json["date_of_birth"],
      bloodGroup: json["blood_group"],
      height: json["height"],
      weight: json["weight"],
      address: json["address"],
      smokingHabits: json["smoking_habits"] ?? "",
      alcoholConsumption: json["alcohol_consumption"] ?? "",
      foodPreference: json["food_preference"],
      activityLevel: json["activity_level"],
      occupation: json["occupation"],
      maritalStatus: json["marital_status"],
      allergies: json["allergies"] ?? "",
      chronicDiseases: json["chronic_diseases"],
      injuries: json["injuries"],
      surgeries: json["surgeries"],
      imageFile: json["image_file"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country_code": countryCode,
        "phone_number": phoneNumber,
        "email": email,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "gender": gender,
        "date_of_birth": dateOfBirth,
        "blood_group": bloodGroup,
        "height": height,
        "weight": weight,
        "address": address,
        "smoking_habits": smokingHabits,
        "alcohol_consumption": alcoholConsumption,
        "food_preference": foodPreference,
        "activity_level": activityLevel,
        "occupation": occupation,
        "marital_status": maritalStatus,
        "allergies": allergies,
        "chronic_diseases": chronicDiseases,
        "injuries": injuries,
        "surgeries": surgeries,
        "image_file": imageFile,
      };
}


// class PatientPersonalProfile {
//   PatientPersonalProfile({
//     required this.data,
//   });

//   final Data? data;

//   factory PatientPersonalProfile.fromJson(Map<String, dynamic> json) {
//     return PatientPersonalProfile(
//       data: json["data"] == null ? null : Data.fromJson(json["data"]),
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "data": data?.toJson(),
//       };

//   @override
//   String toString() {
//     return '$data';
//   }
// }

// class Data {
//   Data({
//     required this.message,
//     required this.profile,
//   });

//   final String message;
//   final Profile? profile;

//   factory Data.fromJson(Map<String, dynamic> json) {
//     return Data(
//       message: json["message"] ?? "",
//       profile:
//           json["profile"] == null ? null : Profile.fromJson(json["profile"]),
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "message": message,
//         "profile": profile?.toJson(),
//       };

//   @override
//   String toString() {
//     return '$message, $profile';
//   }
// }

// class Profile {
//   Profile({
//     required this.id,
//     required this.name,
//     required this.countryCode,
//     required this.phoneNumber,
//     required this.email,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.gender,
//     required this.dateOfBirth,
//     required this.bloodGroup,
//     required this.height,
//     required this.weight,
//     required this.address,
//     required this.smokingHabits,
//     required this.alcoholConsumption,
//     required this.foodPreference,
//     required this.activityLevel,
//     required this.occupation,
//     required this.maritalStatus,
//     required this.allergies,
//     required this.chronicDiseases,
//     required this.injuries,
//     required this.surgeries,
//     required this.imageFile,
//   });

//   final int id;
//   final String name;
//   final String countryCode;
//   final String phoneNumber;
//   final String email;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final String gender;
//   final dynamic dateOfBirth;
//   final dynamic bloodGroup;
//   final dynamic height;
//   final dynamic weight;
//   final dynamic address;
//   final String smokingHabits;
//   final String alcoholConsumption;
//   final dynamic foodPreference;
//   final dynamic activityLevel;
//   final dynamic occupation;
//   final dynamic maritalStatus;
//   final dynamic allergies;
//   final dynamic chronicDiseases;
//   final dynamic injuries;
//   final dynamic surgeries;
//   final String imageFile;

//   factory Profile.fromJson(Map<String, dynamic> json) {
//     return Profile(
//       id: json["id"] ?? 0,
//       name: json["name"] ?? "",
//       countryCode: json["country_code"] ?? "",
//       phoneNumber: json["phone_number"] ?? "",
//       email: json["email"] ?? "",
//       createdAt: json["created_at"] == null
//           ? null
//           : DateTime.parse(json["created_at"]),
//       updatedAt: json["updated_at"] == null
//           ? null
//           : DateTime.parse(json["updated_at"]),
//       gender: json["gender"] ?? "",
//       dateOfBirth: json["date_of_birth"],
//       bloodGroup: json["blood_group"],
//       height: json["height"],
//       weight: json["weight"],
//       address: json["address"],
//       smokingHabits: json["smoking_habits"] ?? "",
//       alcoholConsumption: json["alcohol_consumption"] ?? "",
//       foodPreference: json["food_preference"],
//       activityLevel: json["activity_level"],
//       occupation: json["occupation"],
//       maritalStatus: json["marital_status"],
//       allergies: json["allergies"],
//       chronicDiseases: json["chronic_diseases"],
//       injuries: json["injuries"],
//       surgeries: json["surgeries"],
//       imageFile: json["image_file"] ?? "",
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "country_code": countryCode,
//         "phone_number": phoneNumber,
//         "email": email,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "gender": gender,
//         "date_of_birth": dateOfBirth,
//         "blood_group": bloodGroup,
//         "height": height,
//         "weight": weight,
//         "address": address,
//         "smoking_habits": smokingHabits,
//         "alcohol_consumption": alcoholConsumption,
//         "food_preference": foodPreference,
//         "activity_level": activityLevel,
//         "occupation": occupation,
//         "marital_status": maritalStatus,
//         "allergies": allergies,
//         "chronic_diseases": chronicDiseases,
//         "injuries": injuries,
//         "surgeries": surgeries,
//         "image_file": imageFile,
//       };

//   @override
//   String toString() {
//     return '$id, $name, $countryCode, $phoneNumber, $email, $createdAt, $updatedAt, $gender, $dateOfBirth, $bloodGroup, $height, $weight, $address, $smokingHabits, $alcoholConsumption, $foodPreference, $activityLevel, $occupation, $maritalStatus, $allergies, $chronicDiseases, $injuries, $surgeries, $imageFile';
//   }
// }
