import 'package:flutter/material.dart';
import 'package:todo_app/data/hive_data_store.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/views/home/home_view.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter<Task>(TaskAdapter());

  var box = await Hive.openBox<Task>(HiveDataStore.boxName);

  box.values.forEach((task) {
    if (task.createdAtTime.day != DateTime.now().day) {
      task.delete();
    } else {
      //Do nothing for now
    }
  });
  runApp(const MyApp());
}

class BaseWidget extends InheritedWidget {
  BaseWidget({super.key, required this.child})
      : super(
          child: child,
        );

  final HiveDataStore dataStore = HiveDataStore();
  final Widget child;

  static BaseWidget of(BuildContext context) {
    final base = context.dependOnInheritedWidgetOfExactType<BaseWidget>();
    if (base != null) {
      return base;
    } else {
      throw StateError("Could not find ancestor widget of type BaseWidget");
    }
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return false;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Colors.black,
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
          displayMedium: TextStyle(
            color: Colors.white,
            fontSize: 21,
          ),
          displaySmall: TextStyle(
            color: Color.fromARGB(255, 234, 234, 234),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          headlineSmall: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
          headlineMedium: TextStyle(
            color: Colors.grey,
            fontSize: 17,
          ),
          titleSmall: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          titleLarge: TextStyle(
            fontSize: 40,
            color: Colors.black,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      home: const HomeView(),
    );
  }
}
