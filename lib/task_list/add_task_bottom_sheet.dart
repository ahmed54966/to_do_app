import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:to_do_app/firebase_utiles.dart';
import 'package:to_do_app/model/task.dart';
import 'package:to_do_app/providers/provider.dart';
import 'package:to_do_app/providers/user_provider.dart';

// ignore: must_be_immutable
class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var formKey = GlobalKey<FormState>();
  var selectedDate = DateTime.now();
  String title = "";
  String description = "";
  late ListProviders listProviders;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    listProviders = Provider.of<ListProviders>(context);
    return Container(
      margin: EdgeInsets.all(12),
      child: Column(
        children: [
          Text("Add new Task".tr(),
          style: Theme.of(context).textTheme.titleMedium,
          ),

          Form(
            key: formKey,
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                validator: (text){
                  if(text ==null || text.isEmpty){
                    return"Please Enter Task Title".tr();
                  }
                  return null ;
                } ,
                onChanged: (text){
                  title = text;
                },
                decoration: InputDecoration(
                  hintText: "Enter Task Title".tr(),
                ),
              ),

              SizedBox(height: 10,),

              TextFormField(
                validator: (text){
                  if(text ==null || text.isEmpty){
                    return"Please Enter Task Description".tr();
                  }
                  return null ;
                } ,
                onChanged: (text) {
                  description = text ;
                },
                decoration: InputDecoration(
                  hintText: "Enter Task Description".tr(),
                ),
                maxLines: 4,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Select Date".tr(),
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyLarge,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () {
                    showCalendar();
                  },
                  child:Text("${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                  textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium),
                ),
              ),

              ElevatedButton(onPressed: (){
                addTask();
              },
              style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: AppColors.whiteColor
              ),
              child: Text("Add".tr(),
              style:  Theme.of(context).textTheme.titleLarge,
              )
              )

            ],
          ))
        ],
      ),
    );
  }

  void addTask() {
    if (formKey.currentState?.validate() == true){
      Task task = Task(title: title, description: description, dateTime: selectedDate);
        var authProvider = Provider.of<AuthUserProvider>(context , listen: false);
      FirebaseUltiles.addTaskToFireStore(task , authProvider.currentUser!.id!).then((onValue){
        print("task added sucessfully");
        listProviders.getAllTasksFromFireStore(authProvider.currentUser!.id!);
        Navigator.pop(context);
      })
      .timeout(Duration(seconds: 1),
      onTimeout: () {
        print("task added sucessfully");
        listProviders.getAllTasksFromFireStore(authProvider.currentUser!.id!);
        Navigator.pop(context);
      },);
    }
  }

  void showCalendar()async {
    var chosenDate = await showDatePicker(
      context: context,
      initialDate:DateTime.now() ,
      firstDate: DateTime.now(), 
      lastDate: DateTime.now().add(Duration(days : 365))
      );
        selectedDate = chosenDate ?? selectedDate;
        setState(() {
          
        });
      

      
  }
}
