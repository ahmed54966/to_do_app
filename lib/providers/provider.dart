import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/firebase_utiles.dart';
import 'package:to_do_app/model/task.dart';

class ListProviders extends ChangeNotifier {
  
    List <Task> tasksList = [];
    DateTime selectDate = DateTime.now();

    void getAllTasksFromFireStore (String uId)async{
    QuerySnapshot<Task> querySnapshot = await FirebaseUltiles.getTsaksCollection(uId).get();
    //List<QueryDocumentSnapshot<Task>>
    tasksList = querySnapshot.docs.map((doc){
      return doc.data();
    }).toList();


    tasksList = tasksList.where((task) {
      if (selectDate.day == task.dateTime.day &&
      selectDate.month == task.dateTime.month &&
      selectDate.year == task.dateTime.year   ){
        return true;
      }
      return false;
    }).toList();


    tasksList.sort((Task task1 , Task task2){
      return task1.dateTime.compareTo(task2.dateTime);
    });









    notifyListeners();
  }
  void changeSelectedDate (DateTime newSelectDate , String uId){
    selectDate = newSelectDate;
    getAllTasksFromFireStore(uId);
  }
}