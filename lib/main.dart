import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/image_upload.dart';
import 'package:flutter_firebase/screens/login_page.dart';
import 'package:flutter_firebase/screens/profile_page.dart';
import 'package:flutter_firebase/screens/register_page.dart';
import 'package:flutter_firebase/show_images.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/RegisterPage': (context) => const RegisterPage(),
        '/ProfilePage': (context) => const ProfilePage(),
        '/ImageUpload': (context) => ImageUpload(),
        '/ShowUploads': (context) => ShowUploads(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
