import 'package:authentication_firebase/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        actions: [
          ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, foregroundColor: Colors.black),
              onPressed: () async {
                await FirebaseAuth.instance.signOut().then((value) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                });
              },
              icon: const Icon(Icons.logout),
              label: const Text("Logout"))
        ],
      ),
      body: Container(
        color: Colors.white,
        child: const Center(
          child: Text(
            "Home Page",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
