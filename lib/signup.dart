// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_local_variable, prefer_const_constructors, use_build_context_synchronously, deprecated_member_use, duplicate_ignore, avoid_print, avoid_function_literals_in_foreach_calls

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project/home.dart';
import 'package:project/login.dart';
import 'package:project/passwordapp.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: SignStateful(),
      ),
    );
  }
}

class SignStateful extends StatefulWidget {
  const SignStateful({super.key});
  @override
  State<SignStateful> createState() => _SignStatefulState();
}

class _SignStatefulState extends State<SignStateful> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repasswordController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  bool _rep = true;
  bool _us = false;
  Future<bool> signUp(
      {required String name,
      required String password,
      required String repassword,
      required String number,
      required BuildContext context}) async {
    bool flag = true;
    int userid = 0;
    final CollectionReference users =
        FirebaseFirestore.instance.collection('login');
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('login').get();
      final List<QueryDocumentSnapshot<Map<String, dynamic>>> docs =
          querySnapshot.docs;
      docs.forEach((doc) {
        if (doc.data()['name'] == name && flag == true) {
          flag = false;
          setState(() {
            _us = true;
          });
        } else {
          userid = max(userid, doc.data()['id']);
        }
      });
      if (password != repassword) {
        flag = false;
        setState(() {
          _rep = false;
        });
      }
      if (flag == true) {
        await users.add({
          'id': userid + 1,
          'name': name,
          'password': password,
          'phonenumber': int.parse(number),
          'username': name,
        });
      }
    } catch (e) {
      print('Error reading data: $e');
    }
    return flag;
  }

  @override
  Widget build(BuildContext context) {
    // ignore: todo
    TextEditingController _nameController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _repasswordController = TextEditingController();
    TextEditingController _numberController = TextEditingController();
    final Future<FirebaseApp> _fApp = Firebase.initializeApp();
    // TODO: implement build
    return MaterialApp(
        home: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Text('Sign Up'),
              backgroundColor: const Color(0xFFFF9000),
            ),
            body: FutureBuilder(
                future: _fApp,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Eroor');
                  } else {
                    return SingleChildScrollView(
                        child: Column(
                      children: [
                        Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 45),
                            child: const Text(
                              "SIGN UP",
                              style: TextStyle(
                                fontSize: 75,
                                fontFamily: AutofillHints.impp,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            )),
                        Container(
                          width: 350,
                          margin: const EdgeInsets.only(top: 20),
                          child: TextField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Name',
                              hintText: 'Name',
                              errorText: _us ? 'Name already taken' : null,
                            ),
                          ),
                        ),
                        Container(
                          width: 350,
                          margin: const EdgeInsets.only(top: 20),
                          child: TextField(
                            controller: _numberController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Phone number',
                              hintText: 'Phone number',
                            ),
                          ),
                        ),
                        Container(
                            width: 350,
                            margin: const EdgeInsets.only(top: 20),
                            child: TextField(
                              obscureText: true,
                              controller: _passwordController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Set password',
                                hintText: 'Password',
                              ),
                            )),
                        Container(
                            width: 350,
                            margin: const EdgeInsets.only(top: 20),
                            child: TextField(
                              obscureText: true,
                              controller: _repasswordController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Confirm password',
                                hintText: 'Re-enter Password',
                                errorText:
                                    _rep ? null : 'Passwords donot match',
                              ),
                            )),
                        Container(
                            //width: 20,
                            height: 50,
                            margin: const EdgeInsets.only(top: 20),
                            child: ElevatedButton(
                              onPressed: () async {
                                bool user = await (signUp(
                                  name: _nameController.text,
                                  password: _passwordController.text,
                                  repassword: _repasswordController.text,
                                  number: _numberController.text,
                                  context: context,
                                ));
                                if (user == true) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => Login()),
                                  );
                                }
                              },
                              // ignore: deprecated_member_use
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.orangeAccent),
                              child: const Text("Next",
                                  style: TextStyle(
                                    fontSize: 30,
                                  )),
                            ))
                      ],
                    ));
                  }
                })));
  }
}
