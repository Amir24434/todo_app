import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app/extensions/space_exs.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/utils/app_colors.dart';
import 'package:todo_app/utils/app_str.dart';
import 'package:todo_app/utils/constants.dart';
import 'package:todo_app/views/home/components/fab.dart';
import 'package:todo_app/views/home/components/home_app_bar.dart';
import 'package:todo_app/views/home/components/slider_drawer.dart';
import 'package:todo_app/views/home/widget/task_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<int> testing = [];
  final GlobalKey<SliderDrawerState> drawerKey = GlobalKey<SliderDrawerState>();
  dynamic valueOfIndicator(List<Task> task) {
    if (task.isNotEmpty) {
      return task.length;
    } else {
      return 3;
    }
  }

  int checkDoneTask(List<Task> tasks) {
    int i = 0;
    for (Task doneTask in tasks) {
      if (doneTask.isCompleted) {
        i++;
      }
    }
    return i;
  }

  @override
  Widget build(BuildContext context) {
    final base = BaseWidget.of(context);
    var textTheme = Theme.of(context).textTheme;
    return ValueListenableBuilder(
        valueListenable: base.dataStore.listenToTask(),
        builder: (ctx, Box<Task> box, Widget? child) {
          var tasks = box.values.toList();

          tasks.sort((a, b) => a.createdAtDate.compareTo(b.createdAtDate));
          return Scaffold(
            backgroundColor: Colors.white,
            floatingActionButton: const Fab(),
            body: SliderDrawer(
              key: drawerKey,
              isDraggable: false,
              animationDuration: 1000,
              appBar: HomeAppbar(drawerKey: drawerKey),
              slider: CustomDrawer(),
              child: _buildHomeBody(textTheme, base, tasks),
            ),
          );
        });
  }

  SizedBox _buildHomeBody(
      TextTheme textTheme, BaseWidget base, List<Task> tasks) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 15),
            width: double.infinity,
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 25,
                  height: 25,
                  child: CircularProgressIndicator(
                    value: checkDoneTask(tasks) / valueOfIndicator(tasks),
                    backgroundColor: Colors.grey,
                    valueColor: const AlwaysStoppedAnimation(
                      AppColors.primaryColor,
                    ),
                  ),
                ),
                25.w,
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppString.mainTitle,
                      style: textTheme.displayLarge,
                    ),
                    3.h,
                    Text(
                      "${checkDoneTask(tasks)} of ${tasks.length} task",
                      style: textTheme.titleMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Divider(
              thickness: 2,
              indent: 100,
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 400,
            child: tasks.isNotEmpty
                ? ListView.builder(
                    itemCount: tasks.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: ((context, index) {
                      var task = tasks[index];
                      return Dismissible(
                        direction: DismissDirection.horizontal,
                        onDismissed: (_) {
                          base.dataStore.deleteTask(task: task);
                        },
                        background: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.delete_outline,
                              color: Colors.grey,
                            ),
                            8.w,
                            const Text(
                              AppString.deletedTask,
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                        key: Key(
                          task.id,
                        ),
                        child: TaskWidget(task: task),
                      );
                    }),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FadeIn(
                        child: SizedBox(
                            width: 400,
                            height: 300,
                            child: Lottie.asset(
                              lottieURL,
                              animate: tasks.isNotEmpty ? false : true,
                            )),
                      ),
                      FadeInUp(
                        from: 30,
                        child: const Text(
                          AppString.doneAllTask,
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
