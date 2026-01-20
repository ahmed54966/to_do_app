import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_app/model/task.dart';

class FirebaseUltiles {

  static CollectionReference<Task> getTsaksCollection (){
    return FirebaseFirestore.instance.collection(Task.collectionName).
withConverter<Task>(
  fromFirestore:(snapshot , options) =>Task.fromFireStore(snapshot.data()!) , 
  toFirestore: (task,option) => task.toFireStore()
  );
  }

static Future<void> addTaskToFireStore (Task task){
var taskCollection = getTsaksCollection();
DocumentReference<Task> taskDocRef = taskCollection.doc();
task.id = taskDocRef.id;
return taskDocRef.set(task);
}

}