import 'package:app2/app_string.dart';
import 'package:app2/models/task_model.dart';
import 'package:app2/models/user_model.dart';
import 'package:app2/widgets/date_addtask.dart';
import 'package:app2/widgets/date_container.dart';
import 'package:app2/widgets/home_app_bar.dart';
import 'package:app2/widgets/task_item.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';

import '../taskati.dart';
import 'add_task.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserModel? userModel = Hive.box<UserModel>(AppString.userBox).isNotEmpty
      ? Hive.box<UserModel>(AppString.userBox).getAt(0)
      : null;
  List<String> StatusList = ["All", "Complete", "To DO"];
  int SelectedIndex = 0;
  List<TaskModel> tasks = [];

  @override
  void initState() {
    super.initState();
    loadTask();
  }

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              themeNotifier.value = themeNotifier.value == ThemeMode.light
                  ? ThemeMode.dark
                  : ThemeMode.light;
            },
            icon: Icon(
              themeNotifier.value == ThemeMode.light
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              HomeAppBar(user: userModel),
              SizedBox(height: 20),
              DateAddtask(
                onpressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddTask()),
                  );
                  setState(() {
                     loadTask();
                  });
                },
              ),
              SizedBox(height: 20),
              Row(
                children: List.generate(
                  StatusList.length,
                  ((index) => DateContainer(
                    text: StatusList[index],
                    isActive: SelectedIndex == index,
                    ontap: () {
                      SelectedIndex = index;
                      setState(() {
                        loadTask();
                      });
                    },
                  )),
                ),
              ),
              SizedBox(height: 20),
              Visibility(
                visible: tasks.isEmpty,

                child: Lottie.asset("assest/empty.json"),
                replacement: ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return TaskItem(
                      key: ValueKey(task.key),
                      taskModel: task,
                      onDismissed: (direction) {
                        if (direction == DismissDirection.startToEnd) {
                          deleteTask(task);
                        } else {
                          updateTask(task);
                        }
                      },
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 10),
                  itemCount: tasks.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final mybox = Hive.box<TaskModel>(AppString.taskBox);
  void loadTask()  {
    if (SelectedIndex == 0) {

      tasks = Hive.box<TaskModel>(AppString.taskBox).values.toList();
    } else if (SelectedIndex == 1) {

      tasks = Hive.box<TaskModel>(
        AppString.taskBox,
      ).values.toList().where((e) => e.status == "Complete").toList();
    } else if (SelectedIndex == 2) {
      tasks = Hive.box<TaskModel>(
        AppString.taskBox,
      ).values.toList().where((e) => e.status == "To DO").toList();
    }
  }

  deleteTask(TaskModel? task) {
    task?.delete();
    tasks.remove(task);
    setState(() {});
  }

  updateTask(TaskModel? task) {
    task?.status = "Complete";
    task?.save();
    tasks.remove(task);
    setState(() {});
  }
}
