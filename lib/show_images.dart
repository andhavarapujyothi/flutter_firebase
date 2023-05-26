import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/model/user_model.dart';

class ShowUploads extends StatefulWidget {
  String? userId;
  ShowUploads({Key? key, this.userId}) : super(key: key);

  @override
  State<ShowUploads> createState() => _ShowUploadsState();
}

class _ShowUploadsState extends State<ShowUploads> {
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
      appBar: AppBar(
        title: const Text('Your Images'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(widget.userId)
            .collection('images')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return (const Center(
              child: Text('no image uploaded'),
            ));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                String url = snapshot.data!.docs[index]['downloadURL'];
                return Image.network(
                  url,
                  height: 300,
                  fit: BoxFit.cover,
                );
              },
            );
          }
        },
      ),
    );
  }
}
