import 'dart:io';

import 'package:app2/app_string.dart';
import 'package:app2/models/user_model.dart';
import 'package:app2/widgets/costum_auth_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel ? userModel=Hive.box<UserModel>(AppString.userBox).getAt(0);
  final ImagePicker picker=ImagePicker();
  XFile? photo;
  TextEditingController name=TextEditingController();
  OpenCamera()async{
    photo=await picker.pickImage(source: ImageSource.camera);
    if(photo !=null){
      userModel!.image=photo!.path;
      await userModel!.save();

    }
    setState(() {
      Navigator.pop(context);
    });


  }
  OpenGallery()async{
    photo=await picker.pickImage(source: ImageSource.gallery);
    if(photo !=null){
      userModel!.image=photo!.path;
      await userModel!.save();

    }
    setState(() {
      Navigator.pop(context);
    });


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back,color: Color(0xff4E5AE8),)),

      ),
      body: Center(
        child: Padding(padding:
        EdgeInsets.all(10),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    backgroundColor: Color(0xffB4AAAA),
                    radius: 50,
                    backgroundImage: (userModel!=null && userModel!.image.isNotEmpty)?FileImage(File(userModel!.image)):null,


                  ),
                  InkWell(
                      onTap: (){
                        showModalBottomSheet(context: context, builder: (context)=>Padding(padding:
                        EdgeInsets.all(16),
                          child: Column(
                            children: [
                              InkWell(
                                onTap:(){
                            OpenCamera();
                            setState(() {

                            });
                          },
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius:BorderRadius.circular(10) ,
                                    color: Color(0xff4E5AE8),
                                  ),
                                  child: Text("Upload From Camera", style:  TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),),


                                ),
                              ),
                              SizedBox(height: 10,),
                              InkWell(
                                onTap:(){
                                  OpenGallery();
                                  setState(() {

                                  });
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius:BorderRadius.circular(10) ,
                                    color: Color(0xff4E5AE8),
                                  ),
                                  child: Text("Upload From Gallery", style:  TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),),


                                ),
                              ),

                            ],
                          ),

                        ));
                      },
                      child: Icon(Icons.camera_alt_rounded,color: Color(0xff4E5AE8),)),
                  


                ],
              ),
              SizedBox(height: 20,),
              Divider(thickness: 3,),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(userModel!.name,style: TextStyle(
                      color: Color(0xff4E5AE8),
                    fontSize: 20,
                    fontWeight: FontWeight.bold

                  ),),
                  InkWell(
                      onTap: (){
                        showModalBottomSheet(context: context, builder: (context)=>Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: name,
                                  decoration: InputDecoration(
                                    label: Text(userModel!.name),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: Color(0xff4E5AE8),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20,),
                                CostumAuthElevatedButton(text: "Update Your Name",onpressed: ()async{
                                  if(name.text.isEmpty){
                                    return ;
                                  }
                                  userModel!.name=name.text;
                                  await userModel!.save();
                                  setState(() {
                                    Navigator.pop(context);
                                  });

                                },),
                              ],
                            )
                        ));
                      },

                      child: Icon(Icons.update,color: Color(0xff4E5AE8),)),

                ],
              ),
            ],
          ),
        ),

      ),

    );
  }
}
