class TopQuestion {
  Data? data;

  TopQuestion({this.data});

  TopQuestion.fromJson(Map<String, dynamic> json) {
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
  List<Question>? questions;

  Data({this.message, this.questions});

  Data.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['questions'] != null) {
      questions = <Question>[];
      json['questions'].forEach((v) {
        questions!.add(new Question.fromJson(v));
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

class Question {
  int? id;
  int? customerId;
  int? specialityId;
  String? title;
  String? description;
  String? createdAt;
  String? updatedAt;
  int? answersCount;

  Question(
      {this.id,
      this.customerId,
      this.specialityId,
      this.title,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.answersCount});

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    specialityId = json['speciality_id'];
    title = json['title'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    answersCount = json['answers_count'];
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
    data['answers_count'] = this.answersCount;
    return data;
  }
}
