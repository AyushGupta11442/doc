class NewAnsModel {
  Data? data;

  NewAnsModel({this.data});

  NewAnsModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? message;
  List<Questions>? questions;

  Data({this.message, this.questions});

  Data.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(new Questions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.questions != null) {
      data['questions'] = this.questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Questions {
  int? id;
  int? customerId;
  int? specialityId;
  String? title;
  String? description;
  String? createdAt;
  String? updatedAt;
  List<NewAnswers>? answers;
  Speciality? speciality;

  Questions(
      {this.id,
      this.customerId,
      this.specialityId,
      this.title,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.answers,
      this.speciality});

  Questions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    specialityId = json['speciality_id'];
    title = json['title'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['answers'] != null) {
      answers = <NewAnswers>[];
      json['answers'].forEach((v) {
        answers!.add(new NewAnswers.fromJson(v));
      });
    }
    speciality = json['speciality'] != null
        ? new Speciality.fromJson(json['speciality'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['speciality_id'] = this.specialityId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.answers != null) {
      data['answers'] = this.answers!.map((v) => v.toJson()).toList();
    }
    if (this.speciality != null) {
      data['speciality'] = this.speciality!.toJson();
    }
    return data;
  }
}

class NewAnswers {
  int? id;
  int? doctorId;
  int? questionId;
  String? description;
  String? doNext;
  String? tips;
  String? createdAt;
  String? updatedAt;
  int? draft;
  Doctor? doctor;
  List<Customers>? customers;

  NewAnswers(
      {this.id,
      this.doctorId,
      this.questionId,
      this.description,
      this.doNext,
      this.tips,
      this.createdAt,
      this.updatedAt,
      this.draft,
      this.doctor,
      this.customers});

  NewAnswers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doctorId = json['doctor_id'];
    questionId = json['question_id'];
    description = json['description'];
    doNext = json['do_next'];
    tips = json['tips'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    draft = json['draft'];
    doctor =
        json['doctor'] != null ? new Doctor.fromJson(json['doctor']) : null;
    if (json['customers'] != null) {
      customers = <Customers>[];
      json['customers'].forEach((v) {
        customers!.add(new Customers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['doctor_id'] = this.doctorId;
    data['question_id'] = this.questionId;
    data['description'] = this.description;
    data['do_next'] = this.doNext;
    data['tips'] = this.tips;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['draft'] = this.draft;
    if (this.doctor != null) {
      data['doctor'] = this.doctor!.toJson();
    }
    if (this.customers != null) {
      data['customers'] = this.customers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
  String getAnswer() {
    return description! + "\n" + doNext! + "\n" + tips!;
  }
}

class Doctor {
  int? id;
  String? name;
  int? experience;
  String? imageFile;
  int? districtId;
  List<Speciality>? speciality;
  District? district;

  Doctor(
      {this.id,
      this.name,
      this.experience,
      this.imageFile,
      this.districtId,
      this.speciality,
      this.district});

  Doctor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    experience = json['experience'];
    imageFile = json['image_file'];
    districtId = json['district_id'];
    if (json['speciality'] != null) {
      speciality = <Speciality>[];
      json['speciality'].forEach((v) {
        speciality!.add(new Speciality.fromJson(v));
      });
    }
    district = json['district'] != null
        ? new District.fromJson(json['district'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['experience'] = this.experience;
    data['image_file'] = this.imageFile;
    data['district_id'] = this.districtId;
    if (this.speciality != null) {
      data['speciality'] = this.speciality!.map((v) => v.toJson()).toList();
    }
    if (this.district != null) {
      data['district'] = this.district!.toJson();
    }
    return data;
  }
}

class Speciality {
  int? id;
  String? name;
  int? status;
  Null? createdAt;
  Null? updatedAt;
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
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? doctorId;
  int? specialityId;

  Pivot({this.doctorId, this.specialityId});

  Pivot.fromJson(Map<String, dynamic> json) {
    doctorId = json['doctor_id'];
    specialityId = json['speciality_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doctor_id'] = this.doctorId;
    data['speciality_id'] = this.specialityId;
    return data;
  }
}

class District {
  int? id;
  String? state;
  String? district;
  String? stateType;

  District({this.id, this.state, this.district, this.stateType});

  District.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    state = json['state'];
    district = json['district'];
    stateType = json['state_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['state'] = this.state;
    data['district'] = this.district;
    data['state_type'] = this.stateType;
    return data;
  }
}

class Customers {
  String? name;
  int? customerId;
  Pivot2? pivot;

  Customers({this.name, this.customerId, this.pivot});

  Customers.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    customerId = json['customer_id'];
    pivot = json['pivot'] != null ? new Pivot2.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['customer_id'] = this.customerId;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}

class Pivot2 {
  int? answerId;
  int? customerId;
  int? helpful;
  int? noHelpful;
  String? reportRemarks;
  String? createdAt;
  String? updatedAt;

  Pivot2(
      {this.answerId,
      this.customerId,
      this.helpful,
      this.noHelpful,
      this.reportRemarks,
      this.createdAt,
      this.updatedAt});

  Pivot2.fromJson(Map<String, dynamic> json) {
    answerId = json['answer_id'];
    customerId = json['customer_id'];
    helpful = json['helpful'];
    noHelpful = json['no_helpful'];
    reportRemarks = json['report_remarks'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['answer_id'] = this.answerId;
    data['customer_id'] = this.customerId;
    data['helpful'] = this.helpful;
    data['no_helpful'] = this.noHelpful;
    data['report_remarks'] = this.reportRemarks;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Speciality2 {
  int? id;
  String? name;

  Speciality2({this.id, this.name});

  Speciality2.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
