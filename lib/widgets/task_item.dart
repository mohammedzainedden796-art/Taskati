import 'package:app2/models/task_model.dart';
import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, this.taskModel, this.onDismissed});
  final TaskModel? taskModel;
  final void Function(DismissDirection)? onDismissed;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: onDismissed,

      key: ValueKey(taskModel?.key),
      background: Container(
        height: 100,
        color: Colors.green,
        child: Icon(Icons.incomplete_circle),
      ),
      secondaryBackground: Container(
        height: 100,
        color: Colors.red,
        child: Icon(Icons.delete),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Color(taskModel!.color),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  spacing: 5,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      taskModel?.taskTitle ?? " ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      "${taskModel?.startTime}-${taskModel?.endTime}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      taskModel?.description ?? " ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20),
              Container(height: 50, width: 2, color: Colors.white),
              RotatedBox(
                quarterTurns: 3,
                child: Text(
                  taskModel?.status ?? "To Do",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
