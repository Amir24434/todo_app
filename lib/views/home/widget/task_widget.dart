// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:todo_app/model/task.dart';
import 'package:todo_app/utils/app_colors.dart';
import 'package:todo_app/views/tasks/task_view.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({
    super.key,
    required this.task,
  });
  final Task task;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  TextEditingController textEditingControllerForTitle = TextEditingController();
  TextEditingController textEditingControllerForsubTitle =
      TextEditingController();

  @override
  void initState() {
    textEditingControllerForTitle.text = widget.task.titile;
    textEditingControllerForsubTitle.text = widget.task.subTitle;
    super.initState();
  }

  @override
  void dispose() {
    textEditingControllerForTitle.dispose();
    textEditingControllerForsubTitle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => TaskView(
              titleTaskController: textEditingControllerForTitle,
              descriptionTaskController: textEditingControllerForsubTitle,
              task: widget.task,
            ),
          ),
        );
      },
      child: AnimatedContainer(
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: widget.task.isCompleted
              ? const Color.fromARGB(154, 119, 144, 229)
              : Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              offset: const Offset(0, 4),
              blurRadius: 10,
            ),
          ],
        ),
        duration: const Duration(milliseconds: 600),
        child: ListTile(
          leading: GestureDetector(
            onTap: () {
              widget.task.isCompleted = !widget.task.isCompleted;
              widget.task.save();
            },
            child: AnimatedContainer(
              duration: const Duration(
                milliseconds: 600,
              ),
              decoration: BoxDecoration(
                color: widget.task.isCompleted
                    ? AppColors.primaryColor
                    : Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.grey,
                  width: .8,
                ),
              ),
              child: const Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5, top: 3),
            child: Text(
              textEditingControllerForTitle.text,
              style: TextStyle(
                color: widget.task.isCompleted
                    ? AppColors.primaryColor
                    : Colors.black,
                fontWeight: FontWeight.w500,
                decoration:
                    widget.task.isCompleted ? TextDecoration.lineThrough : null,
              ),
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                textEditingControllerForsubTitle.text,
                style: TextStyle(
                  color: widget.task.isCompleted
                      ? AppColors.primaryColor
                      : Colors.black,
                  fontWeight: FontWeight.w300,
                  decoration: widget.task.isCompleted
                      ? TextDecoration.lineThrough
                      : null,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10,
                    top: 10,
                  ),
                  child: Column(
                    children: [
                      Text(
                        DateFormat('hh:mm a').format(widget.task.createdAtTime),
                        style: TextStyle(
                          fontSize: 14,
                          color: widget.task.isCompleted
                              ? Colors.white
                              : Colors.grey,
                        ),
                      ),
                      Text(
                        DateFormat.yMMMEd().format(widget.task.createdAtDate),
                        style: TextStyle(
                          fontSize: 12,
                          color: widget.task.isCompleted
                              ? Colors.white
                              : Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
