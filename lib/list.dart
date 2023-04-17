// ignore_for_file: must_be_immutable, unused_local_variable, unused_import, avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ListRegister extends StatelessWidget {
  int userid = 0;
  String name = "";
  ListRegister(this.userid, this.name, {super.key});

  List<dynamic> l = [];
  Future<void> rohan() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    l = (await getData())!;
  }

  Future<List<dynamic>?> getData() async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('user').get();

    final List<QueryDocumentSnapshot<Map<String, dynamic>>> docs =
        querySnapshot.docs;
    List<dynamic> l = <String>[];
    docs.forEach((doc) {
      print(doc.data()['id']);
      if (doc.data()['id'] == userid) {
        print(doc.data()['numberplates']);
        l = doc.data()['numberplates'];
      }
    });
    return l;
  }

  //final Stream<QuerySnapshot> user =
  //  FirebaseFirestore.instance.collection('user').snapshots();

  @override
  Widget build(BuildContext context) {
    rohan();
    //getData();
    //print(l);
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Registered vehicles'),
            ),
            body: SingleChildScrollView(
              child: Column(children: <Widget>[
                Container(
                  width: 350,
                  margin: const EdgeInsets.only(left: 30, top: 30),
                  child: const Text(
                    'Registered vehicles',
                    style: TextStyle(
                        fontSize: 50,
                        fontFamily: AutofillHints.impp,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Column(
                  children: [
                    for (var i in l)
                      Container(
                        width: 200,
                        margin: const EdgeInsets.only(top: 20),
                        child: Text(
                          i,
                          style: const TextStyle(
                            fontSize: 30,
                            fontFamily: AutofillHints.impp,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      )
                  ],
                )
              ]),
            )));
  }
}
