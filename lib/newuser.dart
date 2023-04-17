import 'package:flutter/material.dart';

class Newuser extends StatelessWidget {
  const Newuser({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 125),
        child: TextButton(
          onPressed: () {},
          child: const Text(
            'New User?Create Account',
            style: TextStyle(
              fontFamily: AutofillHints.impp,
              color: Colors.black,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
        ));
  }
}
