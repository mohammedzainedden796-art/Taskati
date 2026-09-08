import 'package:flutter/material.dart';

class DateContainer extends StatelessWidget {
  const DateContainer({super.key, this.isActive = false, required this.text, required this.ontap});
  final bool isActive;
  final String text;
  final void Function()?ontap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: ontap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isActive ? Color(0xff4E5AE8) : Colors.grey,
          ),

          child: Center(
            child: Text(text, style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
