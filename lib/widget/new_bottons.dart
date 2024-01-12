import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  MyButton(
      {required this.Colorn, required this.title, required this.onparessed});

  final Color Colorn;
  final String title;
  final VoidCallback onparessed;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Material(
        elevation: 5,
        color: Colorn,
        borderRadius: BorderRadius.circular(10),
        child: MaterialButton(
          onPressed:  onparessed,
          minWidth: 200,
          height: 42,
          child: Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
