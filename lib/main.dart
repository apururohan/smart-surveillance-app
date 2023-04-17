// ignore_for_file: unused_local_variable, avoid_print, avoid_function_literals_in_foreach_calls, unused_import,, unused_element, no_leading_underscores_for_local_identifiers, use_build_context_synchronously, deprecated_member_use, duplicate_ignore, unused_field, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/home.dart';
import 'package:project/passwordapp.dart';
import 'package:project/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  print('hello');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // final Future<FirebaseApp> _fApp = Firebase.initializeApp();
    return const MaterialApp(
        home: Scaffold(
      resizeToAvoidBottomInset: false,
      body: MyStatefulWidget(),
    ));
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _ps = false;
  int _userid = 0;
  String _name = "";
  Future<bool> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    bool flag = false;
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('login').get();

      final List<QueryDocumentSnapshot<Map<String, dynamic>>> docs =
          querySnapshot.docs;
      docs.forEach((doc) {
        print('User ID: ${doc.data()['id']}');
        print(doc.id);
        print('Email: ${doc.data()['password']}');
        if (doc.data()['name'] == email && doc.data()['password'] == password) {
          setState(() {
            _ps = true;
            _userid = doc.data()['id'];
            _name = doc.data()['name'];
            //print(_userid);
          });

          flag = true;
        }
      });
    } catch (e) {
      print('Error reading data: $e');
    }
    if (flag == true) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    final Future<FirebaseApp> _fApp = Firebase.initializeApp();

    return MaterialApp(
        home: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Text('Login Page'),
              backgroundColor: const Color(0xFFFF9000),
            ),
            body: FutureBuilder(
                future: _fApp,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Eroor');
                  } else {
                    return SingleChildScrollView(
                        child: Column(children: <Widget>[
                      Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 75),
                          child: const Text(
                            'LOGIN',
                            style: TextStyle(
                                fontSize: 75,
                                fontFamily: AutofillHints.impp,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          )),
                      Container(
                          width: 350,
                          margin: const EdgeInsets.only(top: 45),
                          child: TextField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Username',
                              hintText: 'Enter your username',
                            ),
                          )),
                      Container(
                          width: 350,
                          margin: const EdgeInsets.only(top: 20),
                          child: TextFormField(
                            obscureText: true,
                            controller: _passwordController,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Password',
                              errorText: _ps ? null : 'Wrong password',
                            ),
                          )),
                      Container(
                          margin: const EdgeInsets.only(top: 0),
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Forgot Password',
                              style: TextStyle(
                                  fontFamily: AutofillHints.impp,
                                  color: Colors.orange),
                              textAlign: TextAlign.center,
                            ),
                          )),
                      Container(
                          //width: 20,
                          height: 50,
                          margin: const EdgeInsets.only(top: 0),
                          child: ElevatedButton(
                            onPressed: () async {
                              bool user = await loginUsingEmailPassword(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  context: context);
                              print(_userid);
                              if (user == true) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        Home(_userid, _name)));
                              } else {}
                            },
                            // FirebaseFirestore.instance

                            //ignore: deprecated_member_use
                            style: ElevatedButton.styleFrom(
                                primary: Colors.orangeAccent),
                            child: const Text("Login",
                                style: TextStyle(
                                  fontSize: 30,
                                )),
                          )),
                      Container(
                          margin: const EdgeInsets.only(top: 125),
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const SignUp()));
                            },
                            child: const Text(
                              'New User? Create Account',
                              style: TextStyle(
                                fontFamily: AutofillHints.impp,
                                color: Colors.black,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )),
                    ]));
                  }
                })));
  }
}
