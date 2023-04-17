// ignore: file_names
import 'package:flutter/material.dart';

class Email extends StatelessWidget {
  const Email({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 350,
        margin: EdgeInsets.only(top: 45),
        child: const TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Username',
            hintText: 'Enter your username',
          ),
        ));
  }
}
