import 'package:flutter/material.dart';

class Forgot extends StatelessWidget {
  const Forgot({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 0),
        child: TextButton(
          onPressed: () {},
          child: const Text(
            'Forgot Password',
            style:
                TextStyle(fontFamily: AutofillHints.impp, color: Colors.orange),
            textAlign: TextAlign.center,
          ),
        ));
  }
}
