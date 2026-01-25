import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_app/model/my_user.dart';
import 'package:to_do_app/model/task.dart';

class FirebaseUltiles {

  static CollectionReference<Task> getTsaksCollection (String uId){
    return getUsersCollection().doc(uId).
    collection(Task.collectionName).
withConverter<Task>(
  fromFirestore:(snapshot , options) =>Task.fromFireStore(snapshot.data()!) , 
  toFirestore: (task,options) => task.toFireStore()
  );
  }

static Future<void> addTaskToFireStore (Task task , String uId){
var taskCollection = getTsaksCollection(uId);
DocumentReference<Task> taskDocRef = taskCollection.doc();
task.id = taskDocRef.id;
return taskDocRef.set(task);
}

static Future<void> deleteTaskFromFireStore (Task task , String uId){
  return getTsaksCollection(uId).doc(task.id).delete();
}

static CollectionReference<MyUser> getUsersCollection(){
  return FirebaseFirestore.instance.collection(MyUser.collectionName).
withConverter<MyUser>(
  fromFirestore:(snapshot , options) =>MyUser.fromFireStore(snapshot.data()!) , 
  toFirestore: (MyUser,options) => MyUser.toFireStore()
  );
}

static Future<void> addUserToFireStore (MyUser myUser){
var userCollection = getUsersCollection();
DocumentReference<MyUser> userDocRef = userCollection.doc();
myUser.id = userDocRef.id;
return userDocRef.set(myUser);
}

static Future<MyUser?> readUserFromFireStore (String uId)async{
  var querySnapshot = await getUsersCollection().doc(uId).get();
  return querySnapshot.data();
}

}

