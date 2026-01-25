import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/app_colors.dart';
import 'package:to_do_app/firebase_utiles.dart';
import 'package:to_do_app/model/task.dart';
import 'package:to_do_app/providers/provider.dart';
import 'package:to_do_app/providers/user_provider.dart';
// ignore: must_be_immutable
class TaskListItem extends StatelessWidget {
  Task task ;
  TaskListItem({required this.task});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var listProviders = Provider.of<ListProviders>(context);
    var authProvider = Provider.of<AuthUserProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.all(12),
      child: Slidable(
        
        // The start action pane is the one at the left or the top side.
        startActionPane: ActionPane(
      extentRatio: 0.25,
      // A motion is a widget used to control how the pane animates.
      motion: const ScrollMotion(),
      
      
      // All actions are defined in the children parameter.
      children:  [
        // A SlidableAction can have an icon and/or a label.
        SlidableAction(
          borderRadius: BorderRadius.circular(15),
          onPressed: (context){
            FirebaseUltiles.deleteTaskFromFireStore(task , authProvider.currentUser!.id!).then((Value){
              print("task deleted sucessfully");
              listProviders.getAllTasksFromFireStore(authProvider.currentUser!.id!);
            })
            .timeout(Duration(seconds: 1),
            onTimeout: (){
              print("task deleted sucessfully");
              listProviders.getAllTasksFromFireStore(authProvider.currentUser!.id!);
            });
          },
          backgroundColor:AppColors.redColor,
          foregroundColor: AppColors.whiteColor,
          icon: Icons.delete,
          label: 'delete'.tr(),
        ),
        
      ],
        ),
      
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(18)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.all(12),
                color: AppColors.primaryColor,
              height: height*0.09,
              width: width*0.005,),
        
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(task.title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.primaryColor,
                    ),),
                  Text(task.description,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.blackLightColor,
                    fontWeight: FontWeight.w500))
                ],
              )),
        
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: height*0.01,
                  horizontal:width*0.05,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.primaryColor
                ),
                child: Icon(Icons.check,color: AppColors.whiteColor,size: 35,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}