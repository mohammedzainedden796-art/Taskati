import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateAddtask extends StatelessWidget {
  const DateAddtask({super.key, required this.onpressed});
  final void Function() onpressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
           DateFormat('MMMM d, y').format(DateTime.now()),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        Spacer(),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xff4E5AE8),
            foregroundColor: Colors.white,
            padding: EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed:onpressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.add),
              SizedBox(width: 10),
              Text("Add Task", style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ],
    );
  }
}
