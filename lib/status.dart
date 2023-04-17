// ignore_for_file: deprecated_member_use, no_leading_underscores_for_local_identifiers, unused_local_variable, prefer_final_fields, unused_field, must_be_immutable, avoid_print, no_logic_in_create_state, avoid_function_literals_in_foreach_ca, avoid_function_literals_in_foreach_calls
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class Status extends StatelessWidget {
  int userid = 0;
  String name = '';
  Status(this.userid, this.name, {super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Statusful(userid, name),
    ));
  }
}

class Statusful extends StatefulWidget {
  int userid = 0;
  String name = '';
  Statusful(this.userid, this.name, {super.key});
  @override
  State<Statusful> createState() => _StatusState(userid, name);
}

class _StatusState extends State<Statusful> {
  TextEditingController _numbercontroller = TextEditingController();
  int userid = 0;
  String name = "";
  String text = "";
  _StatusState(this.userid, this.name);
  Future<void> numberStatus(
      {required String plate, required BuildContext context}) async {
    print(userid);
    try {
      text = '';
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('numberplate').get();
      final List<QueryDocumentSnapshot<Map<String, dynamic>>> docs =
          querySnapshot.docs;
      docs.forEach((doc) {
        print('${doc.data()['numberplate']}');
        if (doc.data()['id'] == userid && doc.data()['numberplate'] == plate) {
          setState(() {
            text = doc.data()['status'];
          });
        }
        if (text == '') {
          setState(() {
            text = 'Not found';
          });
        }
      });
    } catch (e) {
      print('Error reading data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(
            'Check the status',
          ),
          backgroundColor: const Color(
            0xFFFF9000,
          ),
        ),
        drawer: MyDrawer(userid, name),
        body: Column(children: [
          Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 75),
              child: const Text(
                'Status',
                style: TextStyle(
                  fontSize: 75,
                  fontFamily: AutofillHints.impp,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              )),
          Container(
            width: 350,
            margin: const EdgeInsets.only(top: 45),
            child: TextField(
              controller: _numbercontroller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Number plate',
                hintText: 'Number plate',
              ),
            ),
          ),
          Container(
            height: 50,
            margin: const EdgeInsets.only(top: 45),
            child: ElevatedButton(
              onPressed: () async {
                void ans = await numberStatus(
                    plate: _numbercontroller.text, context: context);
                print(text);
              },
              style: ElevatedButton.styleFrom(primary: const Color(0xFFFF9000)),
              child: const Text(
                'Check',
                style: TextStyle(
                  fontFamily: AutofillHints.impp,
                  color: Colors.black,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 75),
            child: Text(
              text,
              style: const TextStyle(
                  fontSize: 25,
                  fontFamily: AutofillHints.impp,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ]),
      ),
    );
  }
}
