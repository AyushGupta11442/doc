class clinicspeciality {
  int? id;
  String? name;
  int? status;
  String? created_at;
  String? updated_at;

  clinicspeciality({
    this.id,
    this.name,
    this.status,
    this.created_at,
    this.updated_at,
  });

  clinicspeciality.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['created_at'] = created_at;
    data['updated_at'] = updated_at;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['created_at'] = created_at;
    data['updated_at'] = updated_at;
    return data;
  }
}
