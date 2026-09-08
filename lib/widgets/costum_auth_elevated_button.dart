import 'package:flutter/material.dart';

class CostumAuthElevatedButton extends StatelessWidget {
  const CostumAuthElevatedButton({super.key, required this.text, this.onpressed});
  final String text;
  final void Function()? onpressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xff4E5AE8),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius:BorderRadius.circular(12),

        ),
      ),
        onPressed: onpressed, child: Text(text,style: TextStyle(fontSize: 20),));
  }
}
