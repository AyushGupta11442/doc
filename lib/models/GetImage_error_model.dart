import 'package:doctor/models/patientpersonal_profile_model.dart';

class ErrorModel {
  final String? error;
  final  PatientPersonalProfile? data;

  ErrorModel({
    required this.error,
    required this.data,
  });
}
