import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/Core/Services/ExtractDate.dart';
import 'package:todo_app/Core/Utils/AppFirebase.dart';

class TaskModel {
  static String collectionName = "Tasks";
  String id;
  String title;
  String description;
  DateTime dateTime;
  bool isDone;
  String time;
String userId;
  TaskModel(
      {this.id ="",
      required this.title,
      required this.description,
      required this.dateTime,
      this.isDone = false,
      required this.time,
      this.userId =""})
  {userId=FirebaseAuth.instance.currentUser?.uid??"";}

  Map<String, dynamic> toFireStoreData() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "dateTime": extractDate(dateTime).millisecondsSinceEpoch,
      "isDone": isDone,
      "time": time ,
      "userId": userId,
    };
  }

  factory TaskModel.fromFireStoreData(Map<String, dynamic> data) {
    return TaskModel(
        id: data["id"] ?? "",
        title: data["title"],
        description: data["description"],
        dateTime: DateTime.fromMillisecondsSinceEpoch(data["dateTime"]),
        isDone: data["isDone"] ?? false,
        time: data["time"] ,
    userId: data["userId"] ?? "",);
  }
}
