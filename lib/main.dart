import 'package:app2/app_string.dart';
import 'package:app2/models/task_model.dart';
import 'package:app2/models/user_model.dart';
import 'package:app2/taskati.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(TaskModelAdapter());
  await Hive.openBox<UserModel>(AppString.userBox);
  await Hive.openBox<TaskModel>(AppString.taskBox);
  runApp(Taskati(

  ));
}