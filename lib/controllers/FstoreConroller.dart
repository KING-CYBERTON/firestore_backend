import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firestore_backend/Constraits/UserModel.dart';

class FireRepo extends GetxController {
  static FireRepo instance = Get.find();

  final _db = FirebaseFirestore.instance;
  //final uid = FirebaseAuth.instance.currentUser?.uid;

  createUser(UserData user) async {
    await _db
        .collection("Users")
        .add(user.toJson())
        .whenComplete(
          () => Get.snackbar('success', 'Info has been updated',
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.greenAccent.withOpacity(0.2),
              colorText: Colors.black87),
        )
        // ignore: body_might_complete_normally_catch_error
        .catchError((e) {
           Get.snackbar('Error', 'Something went wrong',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.redAccent.withOpacity(0.2),
          colorText: Colors.black);
    }).whenComplete(() => Get.toNamed('Profile'));
     
  }

  Future<UserData> getUserData(String email) async {
    if (email == null) {
      throw Exception('Email is null');
    }
    final snapshot =
        await _db.collection('Users').where('email', isEqualTo: email).get();
    final userdetails =
        snapshot.docs.map((e) => UserData.fromSnapshot(e)).single;

    return userdetails;
  }

  Future<List<UserData>> allUser() async {
    final snapshot = await _db.collection('Users').get();
    final userdetails =
        snapshot.docs.map((e) => UserData.fromSnapshot(e)).toList();
    return userdetails;
  }

  getUserDetais() {
    var email = FirebaseAuth.instance.currentUser?.email;
    if (email != null) {
      return FireRepo().getUserData(email);
    } else {
      Get.snackbar('error', 'login');
    }
  }
}
