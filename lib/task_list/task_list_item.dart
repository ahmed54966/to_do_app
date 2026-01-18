import 'package:flutter/material.dart';
import 'package:to_do_app/app_colors.dart';

class TaskListItem extends StatelessWidget {
  const TaskListItem({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.all(12),
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
              Text("Title",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.primaryColor,
                ),),
              Text("Description",
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
    );
  }
}