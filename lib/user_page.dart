import 'package:authentication_firebase/models/user.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final controllerName = TextEditingController();
  final controllerAge = TextEditingController();
  final controllerDate = TextEditingController();

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add User"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          TextField(
            controller: controllerName,
            decoration: const InputDecoration(
                labelText: "Name", border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: 24,
          ),
          TextField(
            controller: controllerAge,
            keyboardType: TextInputType.datetime,
            decoration: const InputDecoration(
                labelText: "Age", border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: 24,
          ),
          // DatePickerDialog(
          //     initialDate: DateTime.now(),
          //     firstDate: DateTime(1900),
          //     lastDate: DateTime(2100)),
          Text(
              "${selectedDate.year} - ${selectedDate.month} - ${selectedDate.day}"),
          ElevatedButton(
              onPressed: () async {
                final DateTime? dateTime = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(1900),
                    lastDate: DateTime(3000));

                if (dateTime != null) {
                  setState(() {
                    selectedDate = dateTime;
                  });
                }
              },
              child: const Text("Chose Birth Day")),
          const SizedBox(
            height: 24,
          ),
          ElevatedButton(
              onPressed: () {
                final user = User(
                    name: controllerName.text,
                    age: int.parse(controllerAge.text),
                    birthday: DateTime.parse(selectedDate.toIso8601String()));
                createUser(user).then((value) => Navigator.pop(context));
                // Navigator.pop(context);
              },
              child: const Text('Create'))
        ],
      ),
    );
  }

  Future createUser(User user) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc();
    user.id = docUser.id;
    final json = user.toJson();
    await docUser.set(json);
  }
}
