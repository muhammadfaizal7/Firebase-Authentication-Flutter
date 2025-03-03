import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:minimal_sosial_media/auth/auth.dart';
import 'package:minimal_sosial_media/firebase_options.dart';
import 'package:minimal_sosial_media/theme/dark_mode.dart';
import 'package:minimal_sosial_media/theme/light_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    print("FirebaseOptions: ${DefaultFirebaseOptions.currentPlatform}");
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("Firebase initialized successfully");
  } catch (e) {
    print("Firebase initialization failed: $e");
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
      theme: lightMode,
      darkTheme: darkMode,
    );
  }
}
