import 'package:expense_tracker/core/utils.dart';
import 'package:expense_tracker/features/auth/repository/auth_repository.dart';
import 'package:expense_tracker/features/auth/screens/signup_screen.dart';
import 'package:expense_tracker/features/auth/screens/verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authControllerProvider = NotifierProvider<AuthController, bool>(
  () => AuthController(),
);

class AuthController extends Notifier<bool> {
  @override
  build() {
    return false;
  }

  Future registerWithEmail({
    required String name,
    required String email,
    required String pass,
    required BuildContext context,
  }) async {
    var res = await ref
        .watch(authRepositoryProvider)
        .registerWithEmail(name: name, email: email, pass: pass);

    res.fold(
      (l) {
        showSnackBar(context, l.message);
      },
      (r) {
        showSnackBar(
          context,
          "User registered successfully, please verify your email",
        );
        Future.delayed(Duration(seconds: 1), () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VerificationScreen(email: email),
            ),
          );
        });
      },
    );
  }

  Future verifyEmail({
    required String email,
    required String otp,
    required BuildContext context,
  }) async {
    var res = await ref
        .watch(authRepositoryProvider)
        .verifyEmail(email: email, otp: otp);

    res.fold(
      (l) {
        showSnackBar(context, l.message);
      },
      (r) {
        showSnackBar(context, "User verified successfully");
        Future.delayed(Duration(seconds: 1), () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => SignupScreen()),
            (route) => false,
          );
        });
      },
    );
  }
}
