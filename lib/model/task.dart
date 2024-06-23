// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'task.g.dart';

class Task extends HiveObject {
  Task({
    required this.id,
    required this.titile,
    required this.subTitle,
    required this.createdAtTime,
    required this.createdAtDate,
    required this.isCompleted,
  });

  @HiveField(0) // Id
  final String id;
  @HiveField(1) //Title
  String titile;
  @HiveField(2) //subTitle
  String subTitle;
  @HiveField(3) // createdAtTime
  DateTime createdAtTime;
  @HiveField(4) //createdAtDate
  DateTime createdAtDate;
  @HiveField(5) // isCompleted
  bool isCompleted;

  //create new Task
  factory Task.create({
    required String? title,
    required String? subTitle,
    DateTime? createdAtTime,
    DateTime? createdAtDate,
  }) =>
      Task(
        id: const Uuid().v1(),
        titile: title ?? "",
        subTitle: subTitle ?? "",
        createdAtTime: createdAtTime ?? DateTime.now(),
        createdAtDate: createdAtDate ?? DateTime.now(),
        isCompleted: false,
      );
}
