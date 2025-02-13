import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:smart_shop/AUTH/forot_password_screen.dart';
import 'package:smart_shop/CONSTANTS/app_colors.dart';
import 'package:smart_shop/SERVICES/my_app_functions.dart';
import 'package:smart_shop/WIDGETS/circular_widget.dart';
import 'package:smart_shop/WIDGETS/formfield_widget.dart';
import 'package:smart_shop/WIDGETS/text_widget.dart';
import 'package:smart_shop/root_screen.dart';

import '../CONSTANTS/validator.dart';
import 'register.dart';

class LoginScreen extends StatefulWidget {
  static const routName = "/LoginScreen";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscureText = true;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;
  bool isLoading = false;
  final auth = FirebaseAuth.instance;

  final _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    if (mounted) {
      _emailController.dispose();
      _passwordController.dispose();
      _emailFocusNode.dispose();
      _passwordFocusNode.dispose();
    }
    super.dispose();
  }

  Future<void> _loginFct() async {
    final isValid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      try {
        setState(() {
          isLoading = true;
        });

        await auth.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, RootScreen.routeName);
      } on FirebaseException catch (e) {
        if (e.code == 'invalid-credential') {
          MyAppFunctions()
              .globalMassage(context: context, message: "in-valid Email");
          print("ERROR Login : ${e.toString()}");
        }
      } catch (error) {
        print("ERROR Login : ${error.toString()}");
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: LoadingManager(
          isLoading: isLoading,
          child: Padding(
            padding: const EdgeInsets.all(35.0),
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height * 0.1,
                    ),

                    //////////// LOGIN WORD
                    const Center(
                      child: Column(
                        children: [
                          TitlesTextWidget(
                            label: "Login",
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Colors.black,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          SubtitleTextWidget(
                            fontSize: 10,
                            label:
                                "Fill real email & password, don't miss the destiny",
                            color: Color.fromARGB(255, 55, 55, 55),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 17,
                    ),
                    Form(
                      key: _formkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          /////////////////////////////////////////////////// Email ///////////////////////////////////////////////
                          CustomFormField(
                            controller: _emailController,
                            focusNode: _emailFocusNode,
                            hintName: "Email",
                            iconData: IconlyLight.message,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (p0) => FocusScope.of(context)
                                .requestFocus(_passwordFocusNode),
                            validator: (value) =>
                                MyValidators.emailValidator(value),
                            keyboardType: TextInputType.emailAddress,
                            obscureText: false,
                          ),

                          const SizedBox(
                            height: 15,
                          ),
                          /////////////////////////////////////////////////  Password /////////////////////////////////////////////
                          CustomFormField(
                            controller: _passwordController,
                            focusNode: _passwordFocusNode,
                            obscureText: obscureText,
                            textInputAction: TextInputAction.next,
                            hintName: "Password",
                            keyboardType: TextInputType.visiblePassword,
                            iconData: IconlyLight.lock,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  obscureText = !obscureText;
                                });
                              },
                              icon: Icon(
                                obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                            onFieldSubmitted: (p0) async {
                              await _loginFct();
                            },
                            validator: (value) =>
                                MyValidators.passwordValidator(value),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          /////////////////////////////////////////// forgot password /////////////////////////////////////////////////
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, ForgotPasswordScreen.routeName);
                              },
                              child: const SubtitleTextWidget(
                                label: "Forgot password?",
                                textDecoration: TextDecoration.underline,
                                color: AppColors.goldenColor,
                                fontSize: 10,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          /////////////////////////////////////////// LOGIN ///////////////////////////////////////////////////////////
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                _loginFct();
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                backgroundColor: AppColors.goldenColor,
                              ),
                              child: const Text(
                                "Login",
                                style: TextStyle(fontSize: 15,color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          const SubtitleTextWidget(
                            label: "or",
                            fontSize: 15,
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          /////////////////////////////////////////  Guest /////////////////////////////////////////////////////////////
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 10,
                                backgroundColor:
                                    const Color.fromARGB(255, 245, 243, 243),
                                padding: const EdgeInsets.all(12.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    30.0,
                                  ),
                                ),
                              ),
                              child: const Text(
                                " Guest ?",
                                style: TextStyle(
                                    fontSize: 15, color: AppColors.goldenColor),
                              ),
                              onPressed: () async {
                                Navigator.pushNamed(
                                  context,
                                  RootScreen.routeName,
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SubtitleTextWidget(
                                label: "Don't have an account ?",
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 13,
                              ),
                              TextButton(
                                child: const SubtitleTextWidget(
                                  label: "Sign up",
                                  fontWeight: FontWeight.normal,
                                  color: AppColors.goldenColor,
                                  textDecoration: TextDecoration.underline,
                                  fontSize: 13,
                                ),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(RegisterScreen.routName);
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
