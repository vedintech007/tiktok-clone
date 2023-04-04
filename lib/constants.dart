import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/controller/auth_controller.dart';
import 'package:tiktok_clone/views/screens/home/add_video.dart';
import 'package:tiktok_clone/views/screens/video_screen.dart';

List pages = [
  const VideoScreen(),
  const Text("SearchScreen()"),
  const AddVideoScreen(),
  const Text('Messages Screen'),
  const Text("ProfileScreen(uid: authController.user.uid)"),
];

// COLORS
const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;

// FIREBASE
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firestore = FirebaseFirestore.instance;

// CONTROLLER
var authController = AuthController.instance;

SizedBox heightSpace(double value) => SizedBox(height: value);
SizedBox widthSpace(double value) => SizedBox(width: value);

Size size() => MediaQuery.of(Get.context!).size;

var profileImagePath =
    "https://images.unsplash.com/photo-1536148935331-408321065b18?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxMTgwOTN8MHwxfHNlYXJjaHwyfHxwcm9ncmFtbWVyfGVufDB8fHx8MTY3ODI5Mzk4Nw&ixlib=rb-4.0.3&q=80&w=1080";

// navigations

void pop() {
  Navigator.of(Get.context!).pop();
}
