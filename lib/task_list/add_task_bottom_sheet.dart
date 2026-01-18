import 'package:flutter/material.dart';
import 'package:to_do_app/app_colors.dart';

// ignore: must_be_immutable
class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var formKey = GlobalKey<FormState>();
  var selectedDate = DateTime.now();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12),
      child: Column(
        children: [
          Text("Add new Task",
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
                    return"Please Enter Task Title";
                  }
                  return null ;
                } ,
                decoration: InputDecoration(
                  hintText: "Enter Task Title",
                ),
              ),

              SizedBox(height: 10,),

              TextFormField(
                validator: (text){
                  if(text ==null || text.isEmpty){
                    return"Please Enter Task Description";
                  }
                  return null ;
                } ,
                decoration: InputDecoration(
                  hintText: "Enter Task Description",
                ),
                maxLines: 4,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Select Date",
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
              child: Text("Add",
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
