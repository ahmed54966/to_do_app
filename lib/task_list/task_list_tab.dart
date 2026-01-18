import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/task_list/task_list_item.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EasyDateTimeLine(
        initialDate: DateTime.now(),
        onDateChange: (selectedDate) {
          
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
              return TaskListItem();
            },
            itemCount: 30,
            ),
        )
      ],
    );
  }
}
