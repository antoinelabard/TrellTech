import 'package:flutter/material.dart';

class TitleComponent extends StatelessWidget {
  const TitleComponent({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.centerLeft,
      color: Colors.transparent,
      child: Text(
        text.toUpperCase(),
        textAlign: TextAlign.left,
        softWrap: true,
        maxLines: 3,
        style: TextStyle(
          fontFamily: 'Nutino',
          fontSize: 22,
          color: Color(0xff7f92e8),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}