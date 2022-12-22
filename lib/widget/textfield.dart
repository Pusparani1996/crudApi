import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String text;
  //final String txt;
  final Icon icon;
  const TextFieldWidget({
    Key? key,
    required this.text,
    required this.icon,
    // required this.txt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(0)),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: icon,
          hintText: text,

          //labelText: txt,
          // focusedBorder: const OutlineInputBorder(
          //     borderSide: BorderSide(
          //         width: 2, color: Color.fromARGB(255, 8, 140, 144))),
          // enabledBorder: const OutlineInputBorder(
          //     borderSide: BorderSide(
          //         width: 2, color: Color.fromARGB(255, 8, 140, 144))),
        ),
      ),
    );
  }
}
