import 'package:firestore_backend/Views/Splash.dart';
import 'package:firestore_backend/Views/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firestore_backend/Views/Login.dart';
import 'package:firestore_backend/Views/Profile.dart';
import 'package:firestore_backend/Views/SignUp.dart';
import 'package:firestore_backend/controllers/AuthController.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await GoogleSignIn().signInSilently();
    await Firebase.initializeApp(
      options: const FirebaseOptions(
           apiKey: "AIzaSyAmOB_-8DIEIwJEOvrM2a8C6RE-KbvSDDc",
          projectId: "educative-9",
          storageBucket: "educative-9.appspot.com",
          messagingSenderId: "14205101883",
           appId: "1:14205101883:web:49043452fcfe80de10791e",
          ),
    ).then((value) => Get.put(GetAuth()));
    runApp(const MyApp());
  } else {
    await GoogleSignIn().signInSilently();
    await Firebase.initializeApp().then((value) => Get.put(GetAuth()));
    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Tree Life',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      getPages: [
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(name: '/login', page: () => const LoginInPage()),
        GetPage(name: '/signup', page: () => const SignUpPage()),
        GetPage(name: '/Profile', page: () => UserProfileScreen()),
        GetPage(name: '/Welcome', page: () => WelcomePage()),
      ],
      initialRoute: '/',
    );
  }
}
