import 'dart:io';

import 'package:app2/app_string.dart';
import 'package:app2/models/user_model.dart';
import 'package:app2/screens/auth_screen.dart';
import 'package:app2/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';


import 'package:flutter/foundation.dart' show kIsWeb;

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key, this.user});
  final UserModel?user;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Column(
          children: [
            Text(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              "hello , ${user?.name ?? " "}",style: TextStyle(
              color: Color(0xff4E5AE8),
              fontSize: 22,

            ),),
            Text("Have A Nice Day.",style: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),),
            
          ],
        )),
        InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen()));
              },
          child: CircleAvatar(
            radius: 30,
    backgroundImage: (user != null && user!.image.isNotEmpty && !kIsWeb)
    ? FileImage(File(user!.image)) as ImageProvider
        : null,
            backgroundColor: Color(0xff121212),


          ),
        ),
        IconButton(onPressed: (){
          Hive.box<UserModel>(AppString.userBox).clear();
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>AuthScreen()), (r)=>false);
        }, icon: Icon(Icons.logout,color: Colors.red,)),

      ],

    ) ;
  }
}
