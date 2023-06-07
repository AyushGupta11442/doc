class Customer {
  int? id;
  String? name;
  String? imageFile;

  Customer({this.id, this.name, this.imageFile});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageFile = json['image_file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image_file'] = imageFile;
    return data;
  }
}
