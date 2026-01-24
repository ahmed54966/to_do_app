
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/firebase_utiles.dart';
import 'package:to_do_app/model/task.dart';
import 'package:to_do_app/providers/provider.dart';
import 'package:to_do_app/task_list/task_list_item.dart';

// ignore: must_be_immutable
class TaskList extends StatefulWidget {


  TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var ListProvider = Provider.of<ListProviders>(context);

    if (ListProvider.tasksList.isEmpty){
      ListProvider.getAllTasksFromFireStore();
    }
    
    return Expanded(
      child: Column(
        children: [
          EasyDateTimeLine(
          initialDate: ListProvider.selectDate,
          onDateChange: (selectedDate) {
            ListProvider.changeSelectedDate(selectedDate);
          },
          headerProps: const EasyHeaderProps(
            monthPickerType: MonthPickerType.switcher,
            dateFormatter: DateFormatter.fullDateMonthAsStrDY(),
          ),
          dayProps: const EasyDayProps(
            dayStructure: DayStructure.dayStrDayNum,
            activeDayStyle: DayStyle(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xff3371FF), Color(0xff123080)],
                ),
              )
            )
          )
          ),
      
          Expanded(
            child: ListView.builder(
              itemBuilder: (context,index){
                return TaskListItem(task: ListProvider.tasksList[index],);
              },
              itemCount: ListProvider.tasksList.length,
              ),
          )
        ],
      ),
    );
  }

  
}
