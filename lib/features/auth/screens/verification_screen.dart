import 'dart:async';

import 'package:expense_tracker/core/utils.dart';
import 'package:expense_tracker/features/auth/controller/auth_controller.dart';
import 'package:expense_tracker/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class VerificationScreen extends ConsumerStatefulWidget {
  String email;
  VerificationScreen({super.key, required this.email});

  @override
  ConsumerState<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends ConsumerState<VerificationScreen> {
  TextEditingController pinController = TextEditingController(text: '');

  bool click = false;

  Future<void> verify() async {
    if (click) {
      return;
    }
    click = true;
    setState(() {});
    await ref
        .watch(authControllerProvider.notifier)
        .verifyEmail(
          email: widget.email,
          otp: pinController.text,
          context: context,
        );
    click = false;
    setState(() {});
  }

  late Timer _timer;
  int _remainingSeconds = 300;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds == 0) {
        timer.cancel();
      } else {
        setState(() {
          _remainingSeconds--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    pinController.dispose();
    super.dispose();
  }

  String formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    // click = false;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Verification",
          style: GoogleFonts.inter(
            fontWeight: .w600,
            fontSize: 18,
            letterSpacing: 0,
            color: DarkPalette.dark50,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: .stretch,
          children: [
            Spacer(),
            Text(
              "Enter your\nVerification Code",
              style: GoogleFonts.inter(
                fontWeight: .w500,
                fontSize: 20,
                letterSpacing: 0,
                color: DarkPalette.dark100,
              ),
            ),
            SizedBox(height: 93),
            Align(
              alignment: AlignmentGeometry.centerLeft,
              child: Pinput(
                length: 6,
                controller: pinController,
                followingPinTheme: PinTheme(
                  width: 16,
                  height: 16,
                  textStyle: GoogleFonts.inter(
                    fontSize: 32,
                    color: Color.fromRGBO(30, 60, 87, 1),
                    fontWeight: FontWeight.w700,
                    height: 39 / 32,
                  ),
                  decoration: BoxDecoration(
                    color: DarkPalette.darkBlue,
                    shape: BoxShape.circle,
                  ),
                ),
                defaultPinTheme: PinTheme(
                  width: 22,
                  height: 39,
                  textStyle: GoogleFonts.inter(
                    fontSize: 32,
                    color: DarkPalette.dark75,
                    fontWeight: FontWeight.w700,
                    height: 39 / 32,
                  ),
                ),
              ),
            ),
            SizedBox(height: 47),
            Text(
              formatTime(_remainingSeconds),
              style: GoogleFonts.inter(
                fontSize: 18,
                color: LightPalette.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              width: 321,
              child: RichText(
                text: TextSpan(
                  text: "We send verification code to your email ",
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: DarkPalette.dark25,
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    TextSpan(
                      text: widget.email,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: DarkPalette.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: ". You can check your inbox.",
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: DarkPalette.dark50,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              "I didn't received the code? Send again",
              style: GoogleFonts.inter(
                fontSize: 16,
                color: LightPalette.primaryColor,
                fontWeight: FontWeight.w500,
                letterSpacing: 0,
              ),
            ),
            SizedBox(height: 46),
            InkWell(
              onTap: () {
                if (pinController.text.length < 6) {
                  showSnackBar(context, "Enter OTP");
                } else {
                  verify();
                }
              },
              child: Container(
                height: 56,
                decoration: BoxDecoration(
                  color: LightPalette.primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: click
                      ? CircularProgressIndicator()
                      : Text(
                          "Verify",
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            color: DarkPalette.dark80,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
