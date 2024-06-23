// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
import 'package:intl/intl.dart';

import 'package:todo_app/extensions/space_exs.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/utils/app_colors.dart';
import 'package:todo_app/utils/app_str.dart';
import 'package:todo_app/utils/constants.dart';
import 'package:todo_app/views/tasks/widget/date_time_selection_widget.dart';
import 'package:todo_app/views/tasks/widget/rep_text_field.dart';

class TaskView extends StatefulWidget {
  const TaskView({
    super.key,
    required this.titleTaskController,
    required this.descriptionTaskController,
    required this.task,
  });

  final TextEditingController? titleTaskController;
  final TextEditingController? descriptionTaskController;
  final Task? task;

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  var title;
  var subTitle;
  DateTime? time;
  DateTime? date;

  String showDate(DateTime? date) {
    if (widget.task?.createdAtDate == null) {
      if (date == null) {
        return DateFormat.yMMMEd().format(DateTime.now()).toString();
      } else {
        return DateFormat.yMMMEd().format(date).toString();
      }
    } else {
      return DateFormat.yMMMEd().format(widget.task!.createdAtDate).toString();
    }
  }

  String showTime(DateTime? time) {
    if (widget.task?.createdAtTime == null) {
      if (time == null) {
        return DateFormat('hh:mm a').format(DateTime.now()).toString();
      } else {
        return DateFormat('hh:mm a').format(time).toString();
      }
    } else {
      return DateFormat('hh:mm a')
          .format(widget.task!.createdAtTime)
          .toString();
    }
  }

  DateTime showDateAsDateTime(DateTime? date) {
    if (widget.task?.createdAtDate == null) {
      if (date == null) {
        return DateTime.now();
      } else {
        return date;
      }
    } else {
      return widget.task!.createdAtDate;
    }
  }

  bool isTaskAlreadyExist() {
    if (widget.titleTaskController?.text == null &&
        widget.descriptionTaskController?.text == null) {
      return true;
    } else {
      return false;
    }
  }

  dynamic isTaskAlreadyExistUpdatedOtherWiseCreate() {
    if (widget.titleTaskController?.text != null &&
        widget.descriptionTaskController?.text != null) {
      try {
        widget.titleTaskController?.text = title;
        widget.descriptionTaskController?.text = subTitle;

        widget.task?.save();
      } catch (e) {
        Navigator.pop(context);
        updateTaskWarning(context);
      }
    } else {
      if (title != null && subTitle != null) {
        var task = Task.create(
          title: title,
          subTitle: subTitle,
          createdAtDate: date,
          createdAtTime: time,
        );

        BaseWidget.of(context).dataStore.addTask(task: task);
        Navigator.pop(context);
      } else {
        emptyWarning(context);
      }
    }
  }

  dynamic deleteTask() {
    return widget.task?.delete();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
            ),
          ),
        ),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildTopSideText(textTheme),
                _buildMainTaskViewActivity(
                  textTheme,
                  context,
                ),
                _buildBottomSideButtons()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSideButtons() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: isTaskAlreadyExist()
            ? MainAxisAlignment.center
            : MainAxisAlignment.spaceEvenly,
        children: [
          isTaskAlreadyExist()
              ? Container()
              : MaterialButton(
                  onPressed: () {
                    deleteTask();
                    Navigator.pop(context);
                  },
                  minWidth: 150,
                  height: 55,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: Colors.white,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.close,
                        color: AppColors.primaryColor,
                      ),
                      5.w,
                      const Text(
                        AppString.deleteTask,
                        style: TextStyle(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
          MaterialButton(
            onPressed: () {
              isTaskAlreadyExistUpdatedOtherWiseCreate();
            },
            minWidth: 150,
            height: 55,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            color: AppColors.primaryColor,
            child: Text(
              isTaskAlreadyExist()
                  ? AppString.addTaskString
                  : AppString.updateTaskString,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMainTaskViewActivity(TextTheme textTheme, BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 530,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              AppString.titleOfTitleTextfield,
              style: textTheme.headlineMedium,
            ),
          ),
          RepTextField(
            controller: widget.titleTaskController,
            onChanged: (String inputTitle) {
              title = inputTitle;
            },
            onFieldSubmitted: (String inputTitle) {
              title = inputTitle;
            },
          ),
          10.h,
          RepTextField(
            controller: widget.descriptionTaskController,
            isForDescription: true,
            onChanged: (String inputSubtitle) {
              subTitle = inputSubtitle;
            },
            onFieldSubmitted: (String inputSubtitle) {
              subTitle = inputSubtitle;
            },
          ),
          DateTimeSelectionWidget(
            title: "Time",
            textTheme: textTheme,
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (_) => SizedBox(
                  height: 280,
                  child: TimePickerWidget(
                    initDateTime: showDateAsDateTime(time),
                    onChange: (_, __) {},
                    dateFormat: "HH:mm",
                    onConfirm: (dateTime, _) {
                      setState(() {
                        if (widget.task?.createdAtTime == null) {
                          time = dateTime;
                        } else {
                          widget.task?.createdAtTime = dateTime;
                        }
                      });
                    },
                  ),
                ),
              );
            },
            time: showTime(time),
          ),
          DateTimeSelectionWidget(
            title: AppString.dateString,
            textTheme: textTheme,
            onTap: () {
              DatePicker.showDatePicker(
                context,
                maxDateTime: DateTime(2030, 4, 5),
                minDateTime: DateTime.now(),
                initialDateTime: showDateAsDateTime(date),
                onConfirm: (dateTime, _) {
                  setState(() {
                    if (widget.task?.createdAtDate == null) {
                      date = dateTime;
                    } else {
                      widget.task?.createdAtDate = dateTime;
                    }
                  });
                },
              );
            },
            time: showDate(date),
            isTime: true,
          )
        ],
      ),
    );
  }

  Widget _buildTopSideText(TextTheme textTheme) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 70,
            child: Divider(
              thickness: 2,
            ),
          ),
          RichText(
            text: TextSpan(
              text: isTaskAlreadyExist()
                  ? AppString.addNewTask
                  : AppString.updateCurrentTask,
              style: textTheme.titleLarge,
              children: const [
                TextSpan(
                  text: AppString.taskString,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 70,
            child: Divider(
              thickness: 2,
            ),
          ),
        ],
      ),
    );
  }
}
