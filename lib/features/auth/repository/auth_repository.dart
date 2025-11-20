import 'dart:convert';

import 'package:expense_tracker/core/failure.dart';
import 'package:expense_tracker/core/type_defs.dart';
import 'package:expense_tracker/features/auth/models/sign_up_response_model.dart';
import 'package:expense_tracker/features/auth/models/verify_response_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

import '../../../core/api.dart';

final authRepositoryProvider = Provider((ref) {
  return AuthRepository();
});

class AuthRepository {
  FutureEither<SignUpResponseModel> registerWithEmail({
    required String name,
    required String email,
    required String pass,
  }) async {
    var headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "X-api-key": Api.apiKey,
    };

    var request = http.Request(
      'POST',
      Uri.parse(Api.baseUrl + Api.signUpEmail),
    );

    request.body = jsonEncode({
      "email": email,
      "password": pass,
      "username": name,
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var jsonData = await response.stream.bytesToString();
    Map<String, dynamic> decodeData = jsonDecode(jsonData);
    print(decodeData);
    var model = SignUpResponseModel.fromMap(decodeData);

    if (model.status == SignUpStatus.success) {
      return right(model);
    } else {
      return left(
        Failure(
          model.message == "Unauthorized: Invalid API key"
              ? "Invalid API key."
              : model.errors!.email.first == "Already_Exist_Google"
              ? "This email is already linked with Google login."
              : "Email already registered. Please try another.",
        ),
      );
    }
  }

  FutureEither<VerifyResponse> verifyEmail({
    required String email,
    required String otp,
  }) async {
    var headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "X-api-key": Api.apiKey,
    };

    var request = http.Request(
      'POST',
      Uri.parse(Api.baseUrl + Api.verifyEmail),
    );

    request.body = jsonEncode({"email": email, "otp": otp});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var jsonData = await response.stream.bytesToString();
    Map<String, dynamic> decodeData = jsonDecode(jsonData);
    print(decodeData);
    var model = VerifyResponse.fromJson(decodeData);

    if (model.status == VerifyStatus.success) {
      return right(model);
    } else {
      return left(
        Failure(
          model.message == "Unauthorized: Invalid API key"
              ? "Invalid API key."
              : model.message == "Invalid or expired OTP"
              ? "Invalid or expired OTP"
              : model.errors!.email.first,
        ),
      );
    }
  }
}
