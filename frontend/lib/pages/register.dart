import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<bool> register(String username, String password) async {
    String apiUrl;
    if (Platform.isAndroid) {
      apiUrl = "http://10.0.2.2:8080/api/user";
    } else {
      apiUrl = "http://localhost:8080/api/user";
    }

    try {
      final response = await http.post(
        Uri.parse("$apiUrl/register"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "username": username,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        print("Registration Successful!");
        return true;
      } else {
        final errorMessage = jsonDecode(response.body)['message'] ?? 'Registration failed';
        Get.snackbar(
          "Registration Error",
          errorMessage,
          snackPosition: SnackPosition.TOP,
        );
        return false;
      }
    } catch (e) {
      print("Exception: $e");
      return false;
    }
  }

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
                width: 220,
                height: 220,
              ),
              const SizedBox(height: 25,),
              Text(
                'Create an account:',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 8,),
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
                icon: const Icon(Icons.how_to_reg_rounded),
                label: const Text(
                  "REGISTER",
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
                  bool registered = await register(
                    usernameController.text,
                    passwordController.text
                  );

                  if (registered) {
                    Get.toNamed('/login');
                  }
                },
              ),
              const SizedBox(height: 50,),
              Center(
                child: Text.rich(
                  TextSpan(
                    text: 'Already have an account? ',
                    style: const TextStyle(fontSize: 15),
                    children: [
                      TextSpan(
                        text: 'Log in',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.purple[800],
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.toNamed('/login');
                          },
                      ),
                      const TextSpan(text: '.'),
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