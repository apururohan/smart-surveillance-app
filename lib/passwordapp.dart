// ignore_for_file: deprecated_member_use, duplicate_ignore

import 'package:flutter/material.dart';

class PasswordApp extends StatelessWidget {
  const PasswordApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: PasswordAppstateful(),
      ),
    );
  }
}

class PasswordAppstateful extends StatefulWidget {
  const PasswordAppstateful({super.key});
  @override
  State<PasswordAppstateful> createState() => _PasswordAppState();
}

class _PasswordAppState extends State<PasswordAppstateful> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Text('Sign Up'),
              backgroundColor: const Color(0xFFFF9000),
            ),
            body: SingleChildScrollView(
                child: Column(
              children: [
                Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 75),
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
                    margin: const EdgeInsets.only(top: 50),
                    child: TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    )),
                Container(
                    width: 350,
                    margin: const EdgeInsets.only(top: 20),
                    child: TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Confirm Password',
                      ),
                    )),
                Container(
                    //width: 20,
                    height: 50,
                    margin: const EdgeInsets.only(top: 40),
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const PasswordApp()),
                      ),
                      // ignore: deprecated_member_use
                      style: ElevatedButton.styleFrom(
                          primary: Colors.orangeAccent),
                      child: const Text("Sign up",
                          style: TextStyle(
                            fontSize: 30,
                          )),
                    ))
              ],
            ))));
  }
}
