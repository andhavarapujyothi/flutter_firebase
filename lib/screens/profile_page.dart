import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/image_upload.dart';
import 'package:flutter_firebase/model/user_model.dart';
import 'package:flutter_firebase/show_images.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedinuser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedinuser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Welcome'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                logout();
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
              child: Image.asset(
                'assets/blue.jpg',
                fit: BoxFit.contain,
              ),
            ),
            const Text(
              'Welcome Back',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '${loggedinuser.firstname}${loggedinuser.secondname}',
              style: const TextStyle(
                  fontWeight: FontWeight.w500, color: Colors.black54),
            ),
            Text(
              '${loggedinuser.email}',
              style: const TextStyle(
                  fontWeight: FontWeight.w500, color: Colors.black54),
            ),
            Text(
              '${loggedinuser.uid}',
              style: const TextStyle(
                  fontWeight: FontWeight.w500, color: Colors.black54),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ImageUpload(userId: loggedinuser.uid),
                      ));
                },
                child: const Text('Upload Image')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ShowUploads(userId: loggedinuser.uid),
                      ));
                },
                child: const Text('Show Uploads')),
          ],
        ),
      )),
    );
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/');
  }
}
