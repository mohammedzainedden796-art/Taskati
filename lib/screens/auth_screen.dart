import 'dart:io';

import 'package:app2/app_string.dart';
import 'package:app2/models/user_model.dart';
import 'package:app2/widgets/costum_auth_elevated_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart' show Hive;
import 'package:image_picker/image_picker.dart';

import 'home_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final ImagePicker picker = ImagePicker();
  XFile? photo;
  openCamera()async{
    photo=await picker.pickImage(source:ImageSource.camera );
    setState(() {

    });

  }
  openGallery()async{
    photo=await picker.pickImage(source: ImageSource.gallery);
    setState(() {

    });
  }
  addUser() async{
    try{
      final box=Hive.box<UserModel>(AppString.userBox);
       await box.clear();
      await box.add(UserModel(image: photo?.path ?? " ", name: nameControler.text));
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), ((route) => false));


    }catch(e){
      showDialog(context: context, builder: (context)=>AlertDialog(
        title: Text("error"),
        content: Text("error save data"),
      ));

    }

  }
  TextEditingController nameControler=TextEditingController();
  final GlobalKey<FormState> formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Visibility(
                    visible: photo == null,
                    child: CircleAvatar(
                      child: Icon(Icons.person, color: Color(0xff4E5AE8), size: 150),
                      radius: 90,
                      backgroundColor: Color(0xff121212),
                    ),
                    replacement: CircleAvatar(
                      radius: 90,
                      backgroundColor: Color(0xff121212),
                      backgroundImage: Image.file(File(photo?.path ??" ")).image,

                    ),
                  ),
                  SizedBox(height: 15,),
                  CostumAuthElevatedButton(text: "Upload From Camera",onpressed: (){
                    openCamera();

                  },),
                  SizedBox(height: 15,),
                  CostumAuthElevatedButton(text: "Upload From Gallery",onpressed: (){
                    openGallery();

                  },),
                  SizedBox(height: 10,),
                  Divider(thickness: 3,),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: nameControler,
                    validator: (value){
                      if(value==null || value.isEmpty){
                        return "Please Enter Your Name";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Enter Your Name",


                      border: OutlineInputBorder(

                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Color(0xff4E5AE8)),

                      ),
                    ),
                  ),
                 SizedBox(height: 20,),
                  CostumAuthElevatedButton(text: "Done",onpressed: (){
                    if(photo==null){
                      showDialog(context: context, builder:(context)=>AlertDialog(
                        title: Text("error"),
                        content: Text("please choose photo"),
                      ) );
                      return ;
                    }
                    if(!formKey.currentState!.validate()){
                      return ;
                    }
                    addUser();
                  },),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
