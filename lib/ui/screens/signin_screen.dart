import 'package:flutter/material.dart';
import 'package:road_helperr/ui/public_details/main_button.dart';
import 'package:road_helperr/ui/public_details/or_border.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:road_helperr/ui/screens/bottomnavigationbar_screes/home_screen.dart';
import 'package:road_helperr/ui/screens/email_screen.dart';
import 'package:road_helperr/ui/screens/signupScreen.dart';

class SignInScreen extends StatefulWidget {
  static const String routeName = "signinscreen";

  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool status = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      emailController.text = prefs.getString('email') ?? '';
      passwordController.text = prefs.getString('password') ?? '';
      status = prefs.getBool('rememberMe') ?? false;
    });
  }

  Future<void> _saveUserData() async {
    final prefs = await SharedPreferences.getInstance();
    if (status) {
      await prefs.setString('email', emailController.text);
      await prefs.setString('password', passwordController.text);
      await prefs.setBool('rememberMe', status);
    } else {
      await prefs.remove('email');
      await prefs.remove('password');
      await prefs.remove('rememberMe');
    }
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? const Color(0xFFF5F8FF)
          : const Color(0xFF1F3551),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Image
            Container(
              width: mediaQuery.width,
              height: mediaQuery.height * 0.35,
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.light
                    ? const Color(0xFF86A5D9)
                    : const Color(0xFF1F3551),
                image: const DecorationImage(
                  image: AssetImage("assets/images/rafiki.png"),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: mediaQuery.height * 0.03),

            // Main Content
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.white
                    : const Color(0xFF1F3551),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        "Welcome Back!",
                        style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.light
                              ? Colors.black
                              : Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    // Email Input
                    InputField(
                      icon: Icons.email_outlined,
                      hintText: "Enter your email",
                      label: "Email",
                      validatorIsContinue: (emailText) {
                        final regExp = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                        if (emailText == null || emailText.isEmpty) {
                          return "Please enter your email";
                        }
                        if (!regExp.hasMatch(emailText)) {
                          return "Please enter a valid email";
                        }
                        return null;
                      },
                      controller: emailController,
                    ),

                    // Password Input
                    InputField(
                      icon: Icons.lock,
                      hintText: "Enter your password",
                      label: "Password",
                      isPassword: true,
                      validatorIsContinue: (passwordText) {
                        if (passwordText == null || passwordText.isEmpty) {
                          return "Please enter your password";
                        }
                        if (passwordText.length < 6) {
                          return "Password must be at least 6 characters";
                        }
                        return null;
                      },
                      controller: passwordController,
                    ),

                    // Remember Me & Forgot Password
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: status,
                                onChanged: (value) {
                                  setState(() {
                                    status = value!;
                                  });
                                },
                                fillColor: MaterialStateProperty.all(
                                  Theme.of(context).brightness == Brightness.light
                                      ? const Color(0xFF86A5D9)
                                      : Colors.white,
                                ),
                                checkColor: Theme.of(context).brightness == Brightness.light
                                    ? Colors.white
                                    : const Color(0xFF1F3551),
                              ),
                              Text(
                                "Remember me",
                                style: TextStyle(
                                  color: Theme.of(context).brightness == Brightness.light
                                      ? Colors.black
                                      : Colors.white,
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(EmailScreen.routeName);
                            },
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                color: Theme.of(context).brightness == Brightness.light
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Login Button
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: MainButton(
                        textButton: "Login",
                        onPress: () {
                          if (_formKey.currentState!.validate()) {
                            _saveUserData();
                            Navigator.of(context)
                                .pushNamed(HomeScreen.routeName);
                          }
                        },
                      ),
                    ),

                    const OrBorder(),

                    // Register Link
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: TextStyle(
                              color: Theme.of(context).brightness == Brightness.light
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(SignupScreen.routeName);
                            },
                            child: Text(
                              "Register",
                              style: TextStyle(
                                color: Theme.of(context).brightness == Brightness.light
                                    ? const Color(0xFF023A87)
                                    : Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// تعديل InputField Widget ليشمل controller
class InputField extends StatefulWidget {
  final IconData icon;
  final String hintText;
  final String label;
  final bool isPassword;
  final String? Function(String?)? validatorIsContinue;
  final TextEditingController controller;

  const InputField({
    super.key,
    required this.icon,
    required this.hintText,
    required this.label,
    this.isPassword = false,
    this.validatorIsContinue,
    required this.controller,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    final bool isLightMode = Theme.of(context).brightness == Brightness.light;
    final Color textColor = isLightMode ? Colors.black : Colors.white;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.isPassword ? _isObscure : false,
        validator: widget.validatorIsContinue,
        decoration: InputDecoration(
          prefixIcon: Icon(
            widget.icon,
            color: textColor,
          ),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _isObscure ? Icons.visibility_off : Icons.visibility,
                    color: textColor,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                )
              : null,
          hintText: widget.hintText,
          labelText: widget.label,
          labelStyle: TextStyle(
            color: textColor,
          ),
          hintStyle: TextStyle(
            color: isLightMode ? Colors.grey[600] : Colors.white54,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: textColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: textColor,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(color: Colors.red),
          ),
          filled: true,
          fillColor: isLightMode ? Colors.white : Colors.transparent,
        ),
        style: TextStyle(
          color: textColor,
        ),
      ),
    );
  }
}