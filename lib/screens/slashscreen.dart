import 'package:app2/screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
  class Slashscreen extends StatefulWidget {
  const Slashscreen({super.key});

  @override
  State<Slashscreen> createState() => _SlashscreenState();
}


class _SlashscreenState extends State<Slashscreen> {
    void initState(){
      super.initState();
      nextScreen();
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset("assest/images/Task_Done.json"),
          Text("Taskati",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          SizedBox(height: 10,),
          Text("its time to get organized",style: TextStyle(fontSize: 18,color: Color(0xffB4AAAA)),),

        ],
      ),
    ),

    );
  }
  void nextScreen(){
   Future.delayed(Duration(seconds: 3),(){
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AuthScreen()));
   });

  }
}
