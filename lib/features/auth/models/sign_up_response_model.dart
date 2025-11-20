// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

enum SignUpStatus { success, error }

class SignUpResponseModel {
  SignUpStatus status;
  String? message;
  SignUpErrors? errors;
  SignUpResponseData? data;
  SignUpResponseModel({
    required this.status,
    this.message,
    this.errors,
    this.data,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status.name,
      'message': message,
      'errors': errors?.toMap(),
      'data': data?.toMap(),
    };
  }

  factory SignUpResponseModel.fromMap(Map<String, dynamic> map) {
    return SignUpResponseModel(
      status: map['status'] == "error"
          ? SignUpStatus.error
          : SignUpStatus.success,
      message: map['message'] != null ? map['message'] as String : null,
      errors: map['errors'] != null
          ? SignUpErrors.fromMap(map['errors'] as Map<String, dynamic>)
          : null,
      data: map['data'] != null
          ? SignUpResponseData.fromMap(map['data'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SignUpResponseModel.fromJson(String source) =>
      SignUpResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class SignUpResponseData {
  int userId;
  String message;
  SignUpResponseData({required this.userId, required this.message});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'user_id': userId, 'message': message};
  }

  factory SignUpResponseData.fromMap(Map<String, dynamic> map) {
    return SignUpResponseData(
      userId: map['user_id'],
      message: map['message'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SignUpResponseData.fromJson(String source) =>
      SignUpResponseData.fromMap(json.decode(source) as Map<String, dynamic>);
}

class SignUpErrors {
  List email;
  SignUpErrors({required this.email});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'email': email};
  }

  factory SignUpErrors.fromMap(Map<String, dynamic> map) {
    return SignUpErrors(email: List.from((map['email'])));
  }

  String toJson() => json.encode(toMap());

  factory SignUpErrors.fromJson(String source) =>
      SignUpErrors.fromMap(json.decode(source) as Map<String, dynamic>);
}
