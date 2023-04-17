import 'package:flutter/material.dart';

class Name extends StatelessWidget {
  const Name({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 75),
        child: const Text(
          'LOGIN',
          style: TextStyle(
              fontSize: 75,
              fontFamily: AutofillHints.impp,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ));
  }
}
