import 'package:flutter/material.dart';

const kSendButtonTextStyle = TextStyle(
    color: Colors.lightBlueAccent, fontWeight: FontWeight.bold, fontSize: 18);

const kMessageTextFieldDecoration = InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    hintText: "Type your message here...",
    border: InputBorder.none);

const kMessageContainerDecoration = BoxDecoration(
    border: Border(top: BorderSide(color: Colors.lightBlueAccent, width: 2)));

const kTextFieldDecoration = InputDecoration(
    hintText: "x",
    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    border:
        OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(32))),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(32))),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(32))));
