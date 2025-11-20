import 'package:expense_tracker/core/utils.dart';
import 'package:expense_tracker/features/auth/controller/auth_controller.dart';
import 'package:expense_tracker/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  bool visibility = true;
  bool isChecked = false;

  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passController = TextEditingController(text: '');

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  bool click = false;

  Future<void> signUp() async {
    if (click) {
      return;
    }
    click = true;
    setState(() {});
    await ref
        .watch(authControllerProvider.notifier)
        .registerWithEmail(
          name: nameController.text,
          email: emailController.text,
          pass: passController.text,
          context: context,
        );
    click = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // click = false;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Sign Up",
          style: GoogleFonts.inter(
            fontWeight: .w600,
            fontSize: 18,
            letterSpacing: 0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const .all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: .stretch,
              children: [
                SizedBox(height: 56),
                Container(
                  decoration: BoxDecoration(
                    border: .all(color: Color(0xffF1F1FA)),
                    borderRadius: .circular(8),
                  ),
                  child: TextFormField(
                    controller: nameController,
                    style: GoogleFonts.inter(fontWeight: .w600, fontSize: 18),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Name is required";
                      } else {
                        return null;
                      }
                    },
                    autovalidateMode: .onUserInteraction,
                    decoration: InputDecoration(
                      border: .none,
                      labelText: "Name",
                      labelStyle: GoogleFonts.inter(
                        fontSize: 18,
                        color: Color(0xff91919F),
                        letterSpacing: 0,
                      ),
                      contentPadding: .only(left: 16),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Container(
                  decoration: BoxDecoration(
                    border: .all(color: Color(0xffF1F1FA)),
                    borderRadius: .circular(8),
                  ),
                  child: TextFormField(
                    controller: emailController,
                    style: GoogleFonts.inter(fontWeight: .w600, fontSize: 18),
                    validator: (value) {
                      final simpleEmail = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
                      if (value == null || value.isEmpty) {
                        return "Email is required";
                      } else if (!simpleEmail.hasMatch(value)) {
                        return "Invalid email";
                      } else {
                        return null;
                      }
                    },
                    autovalidateMode: .onUnfocus,
                    keyboardType: .emailAddress,
                    decoration: InputDecoration(
                      border: .none,
                      labelText: "Email",
                      labelStyle: GoogleFonts.inter(
                        fontSize: 18,
                        color: Color(0xff91919F),
                        letterSpacing: 0,
                      ),
                      contentPadding: .only(left: 16),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Container(
                  decoration: BoxDecoration(
                    border: .all(color: Color(0xffF1F1FA)),
                    borderRadius: .circular(8),
                  ),
                  child: TextFormField(
                    controller: passController,
                    obscureText: !visibility,
                    style: GoogleFonts.inter(fontWeight: .w600, fontSize: 18),
                    keyboardType: .emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password is required";
                      } else if (value.length < 8) {
                        return "Minimum 8 characters needed";
                      } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
                        return "Must contain at least 1 uppercase letter";
                      } else if (!RegExp(r'[0-9]').hasMatch(value)) {
                        return "Must contain at least 1 number";
                      } else if (!RegExp(
                        r'[!@#$%^&*(),.?":{}|<>]',
                      ).hasMatch(value)) {
                        return "Must contain at least 1 special character";
                      } else {
                        return null;
                      }
                    },
                    autovalidateMode: .onUnfocus,
                    decoration: InputDecoration(
                      border: .none,
                      labelText: "Password",
                      labelStyle: GoogleFonts.inter(
                        fontSize: 18,
                        color: Color(0xff91919F),
                        letterSpacing: 0,
                      ),
                      contentPadding: .only(left: 16),
                      suffixIconConstraints: BoxConstraints(
                        minHeight: 14.98,
                        minWidth: 21.82,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          visibility = !visibility;
                          setState(() {});
                        },
                        child: visibility
                            ? Padding(
                                padding: const .only(right: 21),
                                child: SvgPicture.asset(
                                  "assets/visibility.svg",
                                ),
                              )
                            : Padding(
                                padding: const .only(right: 21),
                                child: Icon(
                                  Icons.visibility_off,
                                  color: Color(0xff91919F),
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 17),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() => isChecked = !isChecked);
                      },
                      child: Container(
                        margin: .all(4),
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          borderRadius: .circular(4), // change if needed
                          border: .all(
                            color: LightPalette.primaryColor,
                            width: 2,
                          ),
                          color: isChecked
                              ? LightPalette.primaryColor
                              : Colors.transparent,
                        ),
                        alignment: .center,
                        child: isChecked
                            ? Icon(Icons.check, size: 16, color: Colors.white)
                            : null,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: "By signing up, you agree to the ",
                          style: GoogleFonts.inter(
                            color: Colors.black,
                            fontWeight: .w500,
                            fontSize: 14,
                            height: 18 / 14,
                            letterSpacing: 0,
                          ),
                          children: [
                            TextSpan(
                              text: "Terms of Service and Privacy Policy",
                              style: GoogleFonts.inter(
                                color: LightPalette.primaryColor,
                                fontWeight: .w500,
                                fontSize: 14,
                                height: 18 / 14,
                                letterSpacing: 0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 27),
                GestureDetector(
                  onTap: () {
                    if (formKey.currentState?.validate() ?? false) {
                      if (!isChecked) {
                        showSnackBar(
                          context,
                          "Please agree to the Terms of Service and Privacy Policy",
                        );
                      } else {
                        signUp();
                      }
                    }
                  },
                  child: Container(
                    height: 56,
                    decoration: BoxDecoration(
                      color: LightPalette.primaryColor,
                      borderRadius: .circular(8),
                    ),
                    child: Center(
                      child: click
                          ? CircularProgressIndicator()
                          : Text(
                              "Sign Up",
                              style: GoogleFonts.inter(
                                color: LightPalette.light80,
                                fontWeight: .w600,
                                fontSize: 18,
                                letterSpacing: 0,
                              ),
                            ),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Center(
                  child: Text(
                    "Or with",
                    style: GoogleFonts.inter(
                      color: LightPalette.light20,
                      fontWeight: .w600,
                      fontSize: 18,
                      letterSpacing: 0,
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Container(
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: .circular(16),
                    border: .all(color: LightPalette.light60),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisSize: .min,
                      children: [
                        SvgPicture.asset("assets/google_icon.svg"),
                        SizedBox(width: 10),
                        Text(
                          "Sign Up with Google",
                          style: GoogleFonts.inter(
                            color: DarkPalette.dark50,
                            fontWeight: .w600,
                            fontSize: 18,
                            letterSpacing: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
