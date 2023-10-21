import 'package:authentication_firebase/home_screen.dart';
import 'package:authentication_firebase/main_page.dart';
import 'package:authentication_firebase/models/user.dart';
import 'package:authentication_firebase/register_screen.dart';
import 'package:authentication_firebase/user_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'contants.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  String email = "";
  String password = "";
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text("Login"),
        // ),
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            textAlign: TextAlign.center,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {
              email = value;
            },
            decoration:
                kTextFieldDecoration.copyWith(hintText: 'Enter your email '),
          ),
          const SizedBox(
            height: 8,
          ),
          TextField(
            textAlign: TextAlign.center,
            obscureText: true,
            onChanged: (value) {
              password = value;
            },
            decoration:
                kTextFieldDecoration.copyWith(hintText: "Enter your password"),
          ),
          const SizedBox(
            height: 24,
          ),
          ElevatedButton(
              onPressed: () async {
                setState(() {
                  showSpinner = true;
                });
                try {
                  await _auth
                      .signInWithEmailAndPassword(
                          email: email, password: password)
                      .then((value) {
                    setState(() {
                      showSpinner = false;
                    });
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            // builder: (context) => const HomeScreen())
                            builder: (context) => const MainPage())
                        // builder: (context) => const UserPage())
                        );
                  });
                } catch (e) {
                  print(e);
                }
              },
              child: const Text('Login')),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Do not have an account?"),
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterScreen()));
                  },
                  child: const Text("Register"))
            ],
          )
        ],
      ),
    ));
  }
}
