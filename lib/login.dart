import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        //width: 20,
        height: 50,
        margin: const EdgeInsets.only(top: 0),
        child: ElevatedButton(
          onPressed: () {},
          // ignore: deprecated_member_use
          style: ElevatedButton.styleFrom(primary: Colors.orangeAccent),
          child: const Text("Login",
              style: TextStyle(
                fontSize: 30,
              )),
        ));
  }
}
