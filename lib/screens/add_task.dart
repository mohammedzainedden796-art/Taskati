

import 'package:app2/app_string.dart';
import 'package:app2/models/task_model.dart';
import 'package:app2/widgets/costum_add_task_field.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  List<Color> colors = [Color(0xff4E5AE8), Color(0xffFF8746), Color(0xffFF4667)];
  int activeSelectedIndex = -1;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController StartTimeController = TextEditingController();
  TextEditingController EndTimeController = TextEditingController();
  final GlobalKey<FormState> FormKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xff4E5AE8)),
        titleTextStyle: TextStyle(
          color: Color(0xff4E5AE8),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        title: Text("Add Task"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Form(
          key: FormKey,
          child: Column(
            children: [
              Text(
                "Title",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),

              CostumAddTaskField(
                hintText: "Enter title",
                readOnly: false,
                controller: titleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "title required!";
                  }
                },
              ),
              SizedBox(height: 10),
              Text(
                "Description",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              CostumAddTaskField(
                hintText: "Enter descriotion",
                readOnly: false,
                MaxLines: 3,
                controller: descriptionController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "description required!";
                  }
                },
              ),
              SizedBox(height: 10),
              Text(
                "Date",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              CostumAddTaskField(
                hintText: "2025-05-17",
                suffixIcon: InkWell(
                  onTap: () {
                    showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2028),
                      barrierDismissible: false,
                    ).then((value) {
                      if (value != null) {
                        dateController.text = DateFormat.yMMMd().format(value);
                      }
                    });
                  },
                  child: Icon(Icons.date_range),
                ),
                readOnly: true,
                controller: dateController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Date required!";
                  }
                },
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "Strat Time",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 10),
                        CostumAddTaskField(
                          hintText: "9:08 PM",
                          readOnly: true,
                          controller: StartTimeController,
                          suffixIcon: InkWell(
                            onTap: () {
                              showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                                barrierDismissible: false,
                              ).then((value) {
                                StartTimeController.text =
                                    value?.format(context).toString() ?? " ";
                              });
                            },
                            child: Icon(Icons.alarm),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "start time required ";
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "End time",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 10),
                        CostumAddTaskField(
                          hintText: "9:08 PM",
                          readOnly: true,
                          controller: EndTimeController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return " End time required ";
                            }
                          },
                          suffixIcon: InkWell(
                            onTap: () {
                              showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                                barrierDismissible: false,
                              ).then((value) {
                                EndTimeController.text =
                                    value?.format(context).toString() ?? " ";
                              });
                            },
                            child: Icon(Icons.alarm),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                "Color",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Row(
                children: List.generate(
                  colors.length,
                  (index) => Padding(
                    child: InkWell(
                      onTap: () {
                        activeSelectedIndex = index;
                        setState(() {});
                      },
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: colors[index],
                        child: activeSelectedIndex == index
                            ? Icon(Icons.check, color: Colors.white)
                            : null,
                      ),
                    ),
                    padding: EdgeInsets.all(8),
                  ),
                ),
              ),
              SizedBox(height: 25,),
             SizedBox(
               width: double.infinity,
               child: ElevatedButton(
                   style: ElevatedButton.styleFrom(
                     backgroundColor: Color(0xff4E5AE8),
                     foregroundColor: Colors.white,
                     padding: EdgeInsets.all(10),
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(12),

                       
                     ),
                   ),
                   onPressed: (){
                     if(FormKey.currentState?.validate()??false){
                       if(activeSelectedIndex==-1){
                         showDialog(context: context, builder: (context)=>AlertDialog(
                           title: Text("error"),
                           content: Text("Please choose color"),
                         ));
                         return ;
                       }
                      Hive.box<TaskModel>(AppString.taskBox).add(
                        TaskModel(taskTitle: titleController.text, description: descriptionController.text, date: dateController.text, startTime: StartTimeController.text, endTime: EndTimeController.text, status: "To DO", color: colors[activeSelectedIndex].toARGB32())
                      ).then((v){
                        Navigator.pop(context);
                      });
                     }

                   }, child: Text("Create Task",style: TextStyle(fontSize: 18),)),
             ),
            ],
          ),
        ),
      ),
    );
  }
}
