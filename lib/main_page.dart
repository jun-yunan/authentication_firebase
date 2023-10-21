import 'package:authentication_firebase/models/user.dart';
import 'package:authentication_firebase/upload_image.dart';
import 'package:authentication_firebase/user_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Users"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const UserPage()));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      floatingActionButton: FloatingActionButton.large(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const UploadImage()));
          },
          child: Text("Upload")),
      body: StreamBuilder<List<User>>(
        stream: readUsers(),
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return Text("Something went wrong! ${snapshot.error}");
          } else if (snapshot.hasData) {
            final users = snapshot.data!;
            return ListView(
              children: users.map(buildUser).toList(),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
    );
  }

  Widget buildUser(User user) => ListTile(
        leading: CircleAvatar(
          child: Text("${user.age}"),
        ),
        title: Text(user.name),
        subtitle: Text(user.birthday.toIso8601String()),
      );

  Stream<List<User>> readUsers() => FirebaseFirestore.instance
          .collection('users')
          .snapshots()
          .map((snapshot) {
        // print(snapshot.docs[0]);
        return snapshot.docs.map((doc) {
          print(
              "user info: ${User.fromJson(doc.data()).age} - type: ${User.fromJson(doc.data()).birthday.toIso8601String().runtimeType}");
          return User.fromJson(doc.data());
        }).toList();
      });

  // Future createUser({required String name}) async {
  //   final docUser = FirebaseFirestore.instance.collection('users').doc();
  //   // final json = {"name": name, "age": 21, "birthday": DateTime(2003, 7, 28)};
  //   final user = User(
  //       id: docUser.id, name: name, age: 21, birthday: DateTime(2003, 7, 28));
  //   final json = user.toJson();
  //   await docUser.set(json);
  // }
}
