import 'package:flutter/material.dart';
import 'package:road_helperr/ui/public_details/validation_form.dart';
import 'package:road_helperr/utils/app_colors.dart';

class SignupScreen extends StatefulWidget {
  static const String routeName = "signupscreen";
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? const Color(0xFFF5F8FF)
          : AppColors.getBackgroundColor(context),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.35,
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.light
                    ? const Color(0xFF86A5D9)
                    : const Color(0xFF1F3551),
                image: const DecorationImage(
                  image: AssetImage("assets/images/rafiki.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.35,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.white
                    : const Color(0xFF1F3551),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: const SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: ValidationForm(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
