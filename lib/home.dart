// ignore_for_file: deprecated_member_use, avoid_print, prefer_const_constructors_in_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:project/list.dart';
import 'package:project/main.dart';
import 'package:project/register.dart';
//import 'package:project/name.dart';
import 'package:project/status.dart';
import 'package:google_fonts/google_fonts.dart';

//import 'package:flutter/widgets.dart';

// void main() {
//   runApp(Home());
// }

class Home extends StatelessWidget {
  int userid = 0;
  String name = "";
  Home(this.userid, this.name, {super.key}) {
    super.key;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: const Color.fromARGB(255, 236, 233, 230),
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
                title: const Text('SSS'),
                backgroundColor: const Color(
                  0xFFFF9000,
                )),
            drawer: MyDrawer(userid, name),
            body: SingleChildScrollView(
                child: Column(children: <Widget>[
              Row(children: [
                Container(
                    width: 150,
                    height: 150,
                    margin: const EdgeInsets.only(top: 120, left: 35),
                    child: ElevatedButton(
                      onPressed: () {
                        print('hi');
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Status(userid, name)));
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          primary: const Color(
                            0xFFFF9000,
                          )),
                      child: const Text(
                        'Status of the vehicle',
                        style: TextStyle(
                          fontFamily: AutofillHints.impp,
                          color: Colors.black,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )),
                Container(
                    width: 150,
                    height: 150,
                    margin: const EdgeInsets.only(top: 120, left: 35),
                    child: ElevatedButton(
                      onPressed: () {
                        print('hi');
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Register(userid, name)));
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          primary: const Color(0xFFFF9000)),
                      child: const Text(
                        'Register a new number plate',
                        style: TextStyle(
                          fontFamily: AutofillHints.impp,
                          color: Colors.black,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ))
              ]),
              Row(children: [
                Container(
                    width: 150,
                    height: 150,
                    margin: const EdgeInsets.only(top: 50, left: 35),
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  ListRegister(userid, name))),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          primary: const Color(0xFFFF9000)),
                      child: const Text(
                        'Vehicles registered',
                        style: TextStyle(
                          fontFamily: AutofillHints.impp,
                          color: Colors.black,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )),
                Container(
                    width: 150,
                    height: 150,
                    margin: const EdgeInsets.only(top: 50, left: 35),
                    child: ElevatedButton(
                      onPressed: () => {},
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          primary: const Color(0xFFFF9000)),
                      child: const Text(
                        'Register a new number plate',
                        style: TextStyle(
                          fontFamily: AutofillHints.impp,
                          color: Colors.black,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ))
              ]),
            ]))));
  }
}

class MyDrawer extends StatelessWidget {
  int userid = 0;
  String name = '';
  MyDrawer(this.userid, this.name, {super.key});

  @override
  Widget build(BuildContext context) {
    //String _hi = '';
    //_hi = 'hi' + name;
    String hi = 'Hi';
    String space = ' ';
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFFFF9000),
            ),
            child: Text(hi + space + name,
                style: GoogleFonts.arvo(
                    textStyle: const TextStyle(
                        color: Colors.white,
                        letterSpacing: 2,
                        fontSize: 40,
                        fontStyle: FontStyle.italic))
                //textAlign: TextAlign.center,
                ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              // Navigate to home screen
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Home(userid, name)));
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              // Navigate to settings screen
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => const MyApp()));
            },
          ),
        ],
      ),
    );
  }
}
