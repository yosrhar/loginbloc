import 'package:flutter/material.dart';

class PageHeading extends StatelessWidget {
  final String title;
  const PageHeading({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 25),
      child: Text(
        textAlign: TextAlign.center,
        title,
        style: const TextStyle(
          color: Color.fromRGBO(68, 62, 52, 1),
            fontSize: 34,
            fontWeight: FontWeight.bold,
            fontFamily: 'SF Pro Display'
        ),
      ),
    );
  }
}
