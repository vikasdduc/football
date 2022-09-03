
import 'package:flutter/material.dart';

class winnersOutside extends StatefulWidget {
  const winnersOutside({Key key}) : super(key: key);

  @override
  State<winnersOutside> createState() => _winnersOutsideState();
}

class _winnersOutsideState extends State<winnersOutside> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Container(
          child:  Image.asset(
            'assets/images/winnings.webp',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
