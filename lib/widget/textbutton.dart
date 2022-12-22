import 'package:flutter/material.dart';

class TextButtonWidget extends StatelessWidget {
  final String text;

  final VoidCallback onpressed;
  const TextButtonWidget({
    Key? key,
    required this.text,
    required this.onpressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onpressed,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ));
  }
}
