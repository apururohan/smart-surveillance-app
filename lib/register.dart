// ignore_for_file: no_logic_in_create_state, deprecated_member_use, must_be_immutable, prefer_final_fields, unused_field, unused_local_variable, avoid_print, avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project/home.dart';

class Register extends StatelessWidget {
  int userid = 0;
  String name = "";

  Register(this.userid, this.name, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Registerful(userid, name),
    ));
  }
}

class Registerful extends StatefulWidget {
  int userid = 0;
  String name = '';

  Registerful(this.userid, this.name, {super.key});
  @override
  State<Registerful> createState() => _Registerstate(userid, name);
}

class _Registerstate extends State<Registerful> {
  TextEditingController _number = TextEditingController();
  int userid = 0;
  String name = '';
  _Registerstate(this.userid, this.name);
  final Future<FirebaseApp> _fApp = Firebase.initializeApp();
  bool _found = false;
  Future<bool> register(
      {required String numberplate,
      required int userid,
      required BuildContext context}) async {
    bool found = false;
    final CollectionReference users =
        FirebaseFirestore.instance.collection('login');
    List<dynamic> arr = <dynamic>[];
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('user').get();
      final List<QueryDocumentSnapshot<Map<String, dynamic>>> docs =
          querySnapshot.docs;
      final CollectionReference collectionRef =
          FirebaseFirestore.instance.collection('user');
      bool duplicate = false;
      docs.forEach((doc) {
        if (doc.data()['id'] == userid) {
          duplicate = false;
          found = true;
          arr = doc.data()['numberplates'];
          int i = 0;
          for (i = 0; i < arr.length; i++) {
            if (arr[i] == numberplate) {
              setState(() {
                _found = true;
              });
              duplicate = true;
            }
          }
          if (duplicate == false) {
            arr.add(numberplate);
            collectionRef.doc(doc.id).update({'numberplates': arr});
          }
        }
      });
      if (found == false) {
        arr.add(numberplate);
        await collectionRef.add({
          'id': userid,
          'numberplate': arr,
        });
      }
      if (duplicate == false) {
        final CollectionReference num =
            FirebaseFirestore.instance.collection('numberplate');
        await num.add({
          'id': userid,
          'intime': '',
          'numberplate': numberplate,
          'outtime': '',
          'status': 'inside',
        });
      }
    } catch (e) {
      print(e);
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Register a new vehicle'),
          backgroundColor: const Color(0xFFFF9000),
        ),
        drawer: MyDrawer(userid, name),
        body: FutureBuilder(
          future: _fApp,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Error');
            } else {
              return SingleChildScrollView(
                  child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 45),
                    child: const Text(
                      "Register a new vehicle",
                      style: TextStyle(
                        fontSize: 60,
                        fontFamily: AutofillHints.impp,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    width: 350,
                    margin: const EdgeInsets.only(top: 20),
                    child: TextField(
                      controller: _number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Vehicle number plate',
                        hintText: 'Number plate',
                        //errorText: _found ? 'Already registered' : null,
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    margin: const EdgeInsets.only(top: 40),
                    child: ElevatedButton(
                      onPressed: () async {
                        bool ans = await (register(
                            numberplate: _number.text,
                            userid: userid,
                            context: context));
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.orangeAccent),
                      child: const Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ));
            }
          },
        ),
      ),
    );
  }
}
