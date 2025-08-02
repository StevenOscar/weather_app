import 'package:flutter/material.dart';
import 'package:weather_app/constants/app_color.dart';
import 'package:weather_app/constants/assets_fonts.dart';
import 'package:weather_app/screens/home_screen.dart';
import 'package:weather_app/styles/app_text_styles.dart';
import 'package:weather_app/widgets/elevated_button_widget.dart';
import 'package:weather_app/widgets/text_form_field_widget.dart';

class LoginScreen extends StatefulWidget {
  static const String id = "/login";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isUsernameValid = false;
  bool isPasswordValid = false;
  String? usernameError;
  String? passwordError;
  bool _isLoading = false;
  bool _obscureText = true;
  bool isFormValid = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Memastikan username dan password sudah valid
  void checkValidity() {
    setState(() {
      isFormValid = isUsernameValid && isPasswordValid;
    });
  }

  Future<void> login() async {
    setState(() {
      _isLoading = true;
    });
    Navigator.pushNamedAndRemoveUntil(
      context,
      HomeScreen.id,
      (route) => false,
      arguments: usernameController.text,
    );
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
          child: IntrinsicHeight(
            child: Stack(
              children: [
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: AppColors.backgroundGradient,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 150,
                        color: Color.fromARGB(179, 59, 38, 123),
                        offset: Offset(-40, 60),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.cloud_outlined, size: 125, color: AppColors.whitePrimary),
                    SizedBox(height: 32),
                    Text(
                      "Welcome Back",
                      style: AppTextStyles.boldLargeTItle(fontFamily: AssetsFonts.sfProDisplay),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Login to your account",
                      style: AppTextStyles.regularBody(fontFamily: AssetsFonts.sfProDisplay),
                    ),
                    SizedBox(height: 48),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.loginContainer.withValues(alpha: 0.45),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 48),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildLabel("Username"),
                          SizedBox(height: 12),
                          TextFormFieldWidget(
                            keyboardType: TextInputType.emailAddress,
                            controller: usernameController,
                            hintText: "Username",
                            maxlines: 1,
                            errorText: usernameError,
                            onChanged: (value) {
                              setState(() {
                                if (value.isEmpty) {
                                  isUsernameValid = false;
                                  usernameError = "Username can't be empty";
                                } else {
                                  isUsernameValid = true;
                                  usernameError = null;
                                }
                                checkValidity();
                              });
                            },
                            prefixIcon: Icon(
                              Icons.person_outlined,
                              size: 24,
                              color: AppColors.weatherColorSolid1,
                            ),
                          ),
                          SizedBox(height: 28),
                          buildLabel("Password"),
                          SizedBox(height: 12),
                          TextFormFieldWidget(
                            controller: passwordController,
                            hintText: "Password",
                            errorText: passwordError,
                            obscureText: _obscureText,
                            onChanged: (value) {
                              setState(() {
                                if (value.isEmpty) {
                                  isPasswordValid = false;
                                  passwordError = "Password can't be empty";
                                } else {
                                  isPasswordValid = true;
                                  passwordError = null;
                                }
                                checkValidity();
                              });
                            },
                            maxlines: 1,
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              size: 24,
                              color: AppColors.weatherColorSolid1,
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(right: 4),
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                                icon: Icon(
                                  _obscureText
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  size: 22,
                                  color: AppColors.weatherColorSolid1,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 40),
                          _isLoading
                              ? Center(child: CircularProgressIndicator())
                              : SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButtonWidget(
                                    radius: 10,
                                    text: "Login",
                                    backgroundColor: AppColors.loginContainer.withValues(alpha: 1),
                                    elevation: 4,
                                    onPressed: isFormValid
                                        ? () {
                                            login();
                                          }
                                        : null,
                                    verticalPadding: 16,
                                  ),
                                ),
                          SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        text,
        style: AppTextStyles.boldHeadline(
          fontFamily: AssetsFonts.sfProDisplay,
          color: AppColors.whitePrimary.withValues(alpha: 0.9),
        ),
      ),
    );
  }
}
