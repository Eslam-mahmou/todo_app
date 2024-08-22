import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:todo_app/Core/Services/ExtractDate.dart';
import 'package:todo_app/Core/Services/showSnakBar.dart';

import '../../Feature/layoutView.dart';
import '../../Models/TaskModel.dart';

class AppFirebase {
  String? id;

  Future<void> signUp(
      String email, String password, BuildContext context) async {
    try {
      EasyLoading.show();
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      id = credential.user?.uid ?? "";
      EasyLoading.dismiss();
         SnackBarService.showSuccessMessage("Registration successful!");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        SnackBarService.showErrorMessage("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        SnackBarService.showErrorMessage( "Wrong password provided for that user.");
      } else if (e.code == 'invalid-email') {
        SnackBarService.showErrorMessage( "The email address is not valid.");
      } else if (e.code == 'user-disabled') {
        SnackBarService.showErrorMessage(
        "The user corresponding to the given email has been disabled.");
      } else if (e.code == 'too-many-requests') {
        SnackBarService.showErrorMessage(  "Too many attempts to sign in as this user.");
      } else if (e.code == "The supplied auth credential is incorrect") {
        SnackBarService.showErrorMessage(  "The supplied auth credential is incorrect.");
      } else if (e.code == "network-request-failed" ||
          e.code == "network-error") {
        SnackBarService.showErrorMessage(
        "network connection error. Please check your internet connection.");
      } else {
        SnackBarService.showErrorMessage(e.toString());
      }
    } catch (e) {
      SnackBarService.showErrorMessage(  e.toString());
    }
    EasyLoading.dismiss();
  }

  static Future<void> signIn(
      String email, String password, BuildContext context) async {
    try {
      EasyLoading.show();
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      EasyLoading.dismiss();
      SnackBarService.showSuccessMessage("Sign in successful!");
      Navigator.pushReplacementNamed(context, HomeView.routeName);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        SnackBarService.showErrorMessage("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        SnackBarService.showErrorMessage( "Wrong password provided for that user.");
      } else if (e.code == 'invalid-credential') {
        SnackBarService.showErrorMessage( "Email or password is not valid.");
      } else if (e.code == 'user-disabled') {
        SnackBarService.showErrorMessage(
            "The user corresponding to the given email has been disabled.");
      } else if (e.code == 'too-many-requests') {
        SnackBarService.showErrorMessage(
             "Too many attempts to sign in as this user.");
      } else if (e.code == "Wrong password provided for that user.") {
        SnackBarService.showErrorMessage(
             "The supplied auth credential is incorrect.");
      } else if (e.code == "network-request-failed" ||
          e.code == "network-error") {
       SnackBarService.showErrorMessage(
            "network connection error. Please check your internet connection.");
      } else {
        SnackBarService.showErrorMessage(e.toString());
      }
    } catch (e) {
      SnackBarService.showErrorMessage(e.toString());
    }
    EasyLoading.dismiss();
  }

  static Future<void> resetPassword(String email, BuildContext context) async {
    try {
      EasyLoading.show();
      final credential =
          await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      EasyLoading.dismiss();
     SnackBarService.showSuccessMessage("Password reset email sent.");
    } on Exception catch (e) {
      SnackBarService.showErrorMessage(  e.toString());
      print(e.toString());
    } catch (e) {
      SnackBarService.showErrorMessage( e.toString());
      print(e.toString());
    }
    EasyLoading.dismiss();
  }

  static CollectionReference<TaskModel> getCollectionRef() {
    return FirebaseFirestore.instance
        .collection(TaskModel.collectionName)
        .withConverter<TaskModel>(
          fromFirestore: (snapshot, _) =>
              TaskModel.fromFireStoreData(snapshot.data()!),
          toFirestore: (taskModel, _) => taskModel.toFireStoreData(),
        );
  }

  static Future<void> addTaskToFireStore(TaskModel taskModel) async {
    var collectionRef = getCollectionRef();
    var docRef = collectionRef.doc();
    taskModel.id = docRef.id;
    return docRef.set(taskModel);
  }

  static Stream<QuerySnapshot<TaskModel>> getTasksFromFireStore(
      DateTime selectedDate) {
    var collectionRef = getCollectionRef().where(
      "dateTime",
      isEqualTo: extractDate(selectedDate).millisecondsSinceEpoch,
    );
    return collectionRef.snapshots();
  }

static deleteTask(String id){
    var collectionRef = getCollectionRef();
    return collectionRef.doc(id).delete();
}
static saveTask(String id){
    var collectionRef = getCollectionRef();
    return collectionRef.doc(id).update(
      {
        "isDone":true
      }
    );
}
static Future<void> updateTask(TaskModel taskModel)async{
    var collectionRef =await getCollectionRef();
   return collectionRef.doc(taskModel.id).update(
       taskModel.toFireStoreData()
    );
}
static Future<void> signOut()async{
  try {
    await FirebaseAuth.instance.signOut();
    SnackBarService.showSuccessMessage("User signed out.");
  } catch (e) {
   SnackBarService.showErrorMessage(e.toString());
  }
}
}
