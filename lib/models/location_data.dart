// class LocationData extends Equatable {
//   const LocationData({
//     required this.data,
//   });

//   final Data? data;

//   factory LocationData.fromJson(Map<String, dynamic> json) {
//     return LocationData(
//       data: json["data"] == null ? null : Data.fromJson(json["data"]),
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "data": data?.toJson(),
//       };

//   @override
//   List<Object?> get props => [
//         data,
//       ];
// }

// class Data extends Equatable {
//   const Data({
//     required this.message,
//     required this.districts,
//   });

//   final String message;
//   final List<District> districts;

//   factory Data.fromJson(Map<String, dynamic> json) {
//     return Data(
//       message: json["message"] ?? "",
//       districts: json["districts"] == null
//           ? []
//           : List<District>.from(
//               json["districts"]!.map((x) => District.fromJson(x))),
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "message": message,
//         "districts": List<District>.from(districts.map((x) => x.toJson())),
//       };

//   @override
//   List<Object?> get props => [
//         message,
//         districts,
//       ];
// }

class District {
  const District({
    required this.id,
    required this.state,
    required this.district,
    required this.stateType,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String state;
  final String district;
  final String stateType;
  final dynamic createdAt;
  final dynamic updatedAt;

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      id: json["id"] ?? 0,
      state: json["state"] ?? "",
      district: json["district"] ?? "",
      stateType: json["state_type"] ?? "",
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
    );
  }
  static List<District> fromJsonList(List list) {
    if (list == null) return null!;
    return list.map((item) => District.fromJson(item)).toList();
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "state": state,
        "district": district,
        "state_type": stateType,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
