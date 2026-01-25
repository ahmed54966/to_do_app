
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/providers/provider.dart';
import 'package:to_do_app/providers/user_provider.dart';
import 'package:to_do_app/task_list/task_list_item.dart';

// ignore: must_be_immutable
class TaskList extends StatefulWidget {


  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProviders>(context);
  var authProvider = Provider.of<AuthUserProvider>(context);
    if (listProvider.tasksList.isEmpty){
      listProvider.getAllTasksFromFireStore(authProvider.currentUser!.id!);
    }
    
    return Expanded(
      child: Column(
        children: [
          EasyDateTimeLine(
          initialDate: listProvider.selectDate,
          onDateChange: (selectedDate) {
            listProvider.changeSelectedDate(selectedDate , authProvider.currentUser!.id!);
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
                return TaskListItem(task: listProvider.tasksList[index],);
              },
              itemCount: listProvider.tasksList.length,
              ),
          )
        ],
      ),
    );
  }

  
}
