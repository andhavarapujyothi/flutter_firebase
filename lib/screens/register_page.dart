import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/model/user_model.dart';
import 'package:flutter_firebase/screens/profile_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formkey = GlobalKey<FormState>();
  final _firstnamecontroller = TextEditingController();
  final _secondnamecontroller = TextEditingController();
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final _confirmpasswordcontroller = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.blue,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Register Page'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(25.0),
            child: Form(
              key: _formkey,
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
                  //first name field
                  TextFormField(
                    controller: _firstnamecontroller,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ('Please enter your firstname');
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _firstnamecontroller.text = newValue!;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person),
                      hintText: 'Enter First Name',
                      labelText: 'First Name',
                      contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  //second name field
                  TextFormField(
                    controller: _secondnamecontroller,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ('Please enter your secondname');
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _secondnamecontroller.text = newValue!;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person),
                      hintText: 'Enter Second Name',
                      labelText: 'Second Name',
                      contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  //Email field
                  TextFormField(
                    controller: _emailcontroller,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ('Please enter your email');
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _emailcontroller.text = newValue!;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.mail),
                      hintText: 'Enter Email',
                      labelText: 'Email',
                      contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  //password field
                  TextFormField(
                    controller: _passwordcontroller,
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ('please enter password');
                      } else if (_passwordcontroller.text.length < 6) {
                        return ('Please enter minimum 6 characters');
                      } else {
                        return null;
                      }
                    },
                    onSaved: (newValue) {
                      _passwordcontroller.text = newValue!;
                    },
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.vpn_key),
                        hintText: 'Enter Password',
                        labelText: 'Password',
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 15, 20, 15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  //confirm password field
                  TextFormField(
                    controller: _confirmpasswordcontroller,
                    obscureText: true,
                    validator: (value) {
                      if (_confirmpasswordcontroller.text !=
                          _passwordcontroller.text) {
                        return ("Password is not matching");
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _confirmpasswordcontroller.text = newValue!;
                    },
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.vpn_key),
                        hintText: 'Enter Confirm Password',
                        labelText: 'Confirm Password',
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 15, 20, 15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Material(
                    elevation: 5.0,
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(30),
                    child: MaterialButton(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      minWidth: MediaQuery.of(context).size.width,
                      onPressed: () {
                        signUp(_emailcontroller.text, _passwordcontroller.text);
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signUp(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirebase()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDetailsToFirebase() async {
    //calling our firestore
    //calling our usermodel
    //sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    //writing all the valuues
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstname = _firstnamecontroller.text;
    userModel.secondname = _secondnamecontroller.text;

    await firebaseFirestore
        .collection('users')
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: 'Account created successfully');
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const ProfilePage()),
        (route) => false);
  }
}
