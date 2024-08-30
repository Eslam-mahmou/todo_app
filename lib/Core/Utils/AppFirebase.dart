import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:todo_app/Core/Services/DilogUtils.dart';
import 'package:todo_app/Core/Services/ExtractDate.dart';
import 'package:todo_app/Core/Services/showSnakBar.dart';
import 'package:todo_app/Core/Utils/AppColors.dart';

import '../../Feature/layoutView.dart';
import '../../Models/TaskModel.dart';
import '../../Models/UserModel.dart';

class AppFirebase {
  UserCredential? credential;

  Future<void> signUp(
      String email, String password, BuildContext context, String name) async {
    try {
      DialogUtils.showLoading(context: context, message: "Loading...");
      credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      credential!.user!.emailVerified;
      credential!.user!.updateDisplayName(name);
      await addUser(
          UserModel(id: credential?.user?.uid ?? "", name: name, email: email));
      DialogUtils.hideLoading(context);
      DialogUtils.showMessage(
          context: context,
          message: "Register Successfully.",
          title: "Success",
          postActionName: "Ok",
          postAction: () {
            Navigator.pushReplacementNamed(context, HomeView.routeName);
          },
          negativeActionName: "Cancel");
      Navigator.of(context).pushNamed(HomeView.routeName);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(
          context: context,
          message: "No user found that for email .",
          title: "Error",
          postActionName: "ok",
        );
      } else if (e.code == 'wrong-password') {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(
          context: context,
          message: "Wrong password provided for that user.",
          title: "Error",
          postActionName: "ok",
        );
      } else if (e.code == 'invalid-email') {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(
          context: context,
          message: "The email address is not valid.",
          title: "Error",
          postActionName: "ok",
        );
      } else if (e.code == 'user-disabled') {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(
          context: context,
          message:
              "The user corresponding to the given email has been disabled.",
          title: "Error",
          postActionName: "ok",
        );
      } else if (e.code == 'too-many-requests') {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(
          context: context,
          message: "Too many attempts to sign in as this user.",
          title: "Error",
          postActionName: "ok",
        );
      } else if (e.code == "The supplied auth credential is incorrect") {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(
          context: context,
          message: "The supplied auth credential is incorrect.",
          title: "Error",
          postActionName: "ok",
        );
      } else if (e.code == "network-request-failed" ||
          e.code == "network-error") {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(
          context: context,
          message:
              "network connection error. Please check your internet connection.",
          title: "Error",
          postActionName: "ok",
        );
      } else {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(
          context: context,
          message: e.toString(),
          title: "Error",
          postActionName: "ok",
        );
      }
    } catch (e) {
      DialogUtils.hideLoading(context);
      DialogUtils.showMessage(
        context: context,
        message: e.toString(),
        title: "Error",
        postActionName: "ok",
      );
    }
  }

  Future<void> signIn(
      String email, String password, BuildContext context) async {
    try {
      DialogUtils.showLoading(context: context, message: "Loading...");
      credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (credential?.user != null) {
        await readUserFromFireStore(credential?.user?.uid ?? "");
      }
      DialogUtils.hideLoading(context);
      DialogUtils.showMessage(
          context: context,
          message: "Login Successfully.",
          title: "Success",
          postActionName: "ok",
          postAction: () {
            Navigator.pushReplacementNamed(context, HomeView.routeName);
          },
          negativeActionName: "Cancel");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(
          context: context,
          message: "No user found for that email.",
          title: "Error",
          postActionName: "ok",
        );
      } else if (e.code == 'wrong-password') {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(
          context: context,
          message: "Wrong password provided for that user.",
          title: "Error",
          postActionName: "ok",
        );
      } else if (e.code == 'invalid-credential') {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(
          context: context,
          message: "Email or password is not valid.",
          title: "Error",
          postActionName: "ok",
        );
      } else if (e.code == 'user-disabled') {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(
          context: context,
          message:
              "The user corresponding to the given email has been disabled.",
          title: "Error",
          postActionName: "ok",
        );
      } else if (e.code == 'too-many-requests') {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(
          context: context,
          message: "Too many attempts to sign in as this user.",
          title: "Error",
          postActionName: "ok",
        );
      } else if (e.code == "Wrong password provided for that user.") {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(
          context: context,
          message: "The supplied auth credential is incorrect.",
          title: "Error",
          postActionName: "ok",
        );
      } else if (e.code == "network-request-failed" ||
          e.code == "network-error") {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(
          context: context,
          message:
              "network connection error. Please check your internet connection.",
          title: "Error",
          postActionName: "ok",
        );
      } else {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(
          context: context,
          message: e.toString(),
          title: "Error",
          postActionName: "ok",
        );
      }
    } catch (e) {
      DialogUtils.hideLoading(context);
      DialogUtils.showMessage(
        context: context,
        message: e.toString(),
        title: "Error",
        postActionName: "ok",
      );
    }
  }

  static Future<void> resetPassword(String email, BuildContext context) async {
    try {
      DialogUtils.showLoading(context: context, message: "Loading...");
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      DialogUtils.hideLoading(context);
      DialogUtils.showMessage(
        context: context,
        message: "Password reset email sent.",
        title: "Success",
        postActionName: "ok",
      );
    } on Exception catch (e) {
      DialogUtils.hideLoading(context);
      DialogUtils.showMessage(
        context: context,
        message: e.toString(),
        title: "Error",
        postActionName: "ok",
      );
    } catch (e) {
      DialogUtils.hideLoading(context);
      DialogUtils.showMessage(
        context: context,
        message: e.toString(),
        title: "Error",
        postActionName: "ok",
      );
    }
  }

  static CollectionReference<TaskModel> getCollectionRef() {
    var collectionRef = FirebaseFirestore.instance
        .collection(TaskModel.collectionName)
        .withConverter<TaskModel>(
          fromFirestore: (snapshot, _) =>
              TaskModel.fromFireStoreData(snapshot.data()!),
          toFirestore: (taskModel, _) => taskModel.toFireStoreData(),
        );
    return collectionRef;
  }

  static Future<void> addTaskToFireStore(TaskModel taskModel) async {
    var collectionRef = getCollectionRef();
    var docRef = collectionRef.doc();
    taskModel.id = docRef.id;
    return docRef.set(taskModel);
  }

  static Stream<QuerySnapshot<TaskModel>> getTasksFromFireStore(
      DateTime selectedDate) {
    var collectionRef = getCollectionRef()
        .where(
          "dateTime",
          isEqualTo: extractDate(selectedDate).millisecondsSinceEpoch,
        )
        .where(
          "userId",
          isEqualTo: FirebaseAuth.instance.currentUser?.uid,
        );
    return collectionRef.snapshots();
  }

  static deleteTask(String id) {
    var collectionRef = getCollectionRef();
    return collectionRef.doc(id).delete();
  }

  static saveTask(String id) {
    var collectionRef = getCollectionRef();
    return collectionRef.doc(id).update({"isDone": true});
  }

  static Future<void> updateTask(TaskModel taskModel) async {
    var collectionRef = getCollectionRef();
    return collectionRef.doc(taskModel.id).update(taskModel.toFireStoreData());
  }

  static Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      SnackBarService.showSuccessMessage("User signed out.");
    } catch (e) {
      SnackBarService.showErrorMessage(e.toString());
    }
  }

  static CollectionReference<UserModel> getCollectionUsers() {
    return FirebaseFirestore.instance
        .collection(UserModel.collectionName)
        .withConverter(
      fromFirestore: (snapshot, _) {
        return UserModel.fromUsersFireStore(snapshot.data()!);
      },
      toFirestore: (userModel, _) {
        return userModel.toUsersFireStore();
      },
    );
  }

  static Future<void> addUser(UserModel userModel) {
    var collectionRef = getCollectionUsers();
    return collectionRef.doc(userModel.id).set(userModel);
  }

  static Future<UserModel> readUserFromFireStore(String id) async {
    var collectionRef = await getCollectionUsers().doc(id).get();
    return collectionRef.data()!;
  }
}
