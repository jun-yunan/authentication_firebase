import 'package:authentication_firebase/contants.dart';
import 'package:authentication_firebase/home_screen.dart';
import 'package:authentication_firebase/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  static String id = "Register_screen";
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool showSpinner = false;
  String email = "";
  String password = "";
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 48,
            ),
            TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                email = value;
              },
              decoration:
                  kTextFieldDecoration.copyWith(hintText: "Enter your email"),
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
              decoration: kTextFieldDecoration.copyWith(
                  hintText: "Enter your password"),
            ),
            const SizedBox(
              height: 24,
            ),
            ElevatedButton(
                onPressed: () async {
                  setState(() {
                    showSpinner = false;
                  });
                  try {
                    await _auth
                        .createUserWithEmailAndPassword(
                            email: email, password: password)
                        .then((value) {
                      setState(() {
                        showSpinner = false;
                      });
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()));
                      print("Successfully created");
                    });
                  } catch (e) {
                    print(e);
                  }
                },
                child: const Text('Register')),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?"),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                    child: const Text("Login"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
