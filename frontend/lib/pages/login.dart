import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/user_controller.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final UserController userController = Get.put(UserController());
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 15,),
              Image.asset(
                'assets/logo_black.png',
                width: 300,
                height: 300,
              ),
              const SizedBox(height: 15,),
              Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(50.0),
                child: TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.purple[800]!,
                        width: 2,
                      ), // Border color when the TextField is not focused
                      borderRadius: BorderRadius.circular(50.0),
                      gapPadding: 5,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.purple[800]!,
                        width: 2
                      ), // Border color when the TextField is focused
                      borderRadius: BorderRadius.circular(50.0),
                      gapPadding: 5,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 17, vertical: 17),
                    labelText: 'Username',
                    labelStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.grey[500]
                    ),
                    floatingLabelStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.purple[800]
                    ),
                    hintText: 'Enter username...',
                    hintStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[400]
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14,),
              Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(50.0),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.purple[800]!,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(50.0),
                      gapPadding: 5,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.purple[800]!,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(50.0),
                      gapPadding: 5,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 17, vertical: 17),
                    labelText: 'Password',
                    labelStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.grey[500]
                    ),
                    floatingLabelStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.purple[800]
                    ),
                    hintText: 'Enter password...',
                    hintStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[400]
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12,),
              OutlinedButton.icon(
                icon: const Icon(Icons.login_outlined),
                label: const Text(
                  "LOG IN",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                  ),
                ),
                style: ButtonStyle(
                  iconSize: MaterialStateProperty.all(30),
                  elevation: MaterialStateProperty.all(10),
                  backgroundColor: MaterialStateProperty.all(Colors.purple[800]),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  shadowColor: MaterialStateProperty.all(Colors.grey[500]),
                  fixedSize: MaterialStateProperty.all(const Size(200, 50)),
                  side: MaterialStateProperty.all(BorderSide(width: 3, color: Colors.purple[800]!)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
                onPressed: () async {
                  bool loggedIn = await userController.login(
                    usernameController.text,
                    passwordController.text,
                  );

                  if (loggedIn) {
                    Get.toNamed('/home');
                  }
                },
              ),
              const SizedBox(height: 50,),
              Center(
                child: Text.rich(
                  TextSpan(
                    text: 'Do not have an account yet? ',
                    style: const TextStyle(fontSize: 14),
                    children: [
                      TextSpan(
                        text: 'Click here',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.purple[800],
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.toNamed('/register');
                          },
                      ),
                      const TextSpan(text: ' and create one!'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
