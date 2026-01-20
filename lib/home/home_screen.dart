import 'package:flutter/material.dart';
import 'package:to_do_app/settings/settings_tab.dart';
import 'package:to_do_app/task_list/add_task_bottom_sheet.dart';
import 'package:to_do_app/task_list/task_list_tab.dart';
import 'package:easy_localization/easy_localization.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int selectedIndex = 0;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        toolbarHeight:MediaQuery.of(context).size.height*0.2 ,
        title: Text("To Do List".tr(),
        style: Theme.of(context).textTheme.titleLarge,),
      ) ,
      bottomNavigationBar: BottomNavigationBar(
        
        currentIndex: selectedIndex,
        onTap: (index){
          setState(() {
            selectedIndex = index ;
          });
        },
        items: [
          BottomNavigationBarItem(
        icon: Icon(Icons.list),
        label: "Task List".tr()),
      
      BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "settings".tr()),

      
      
      
          ]
        ),

        floatingActionButton: FloatingActionButton(onPressed:(){
        addTaskBottomSheet();
        
      },
      
      child: Icon(Icons.add, size: 35,),
      
    ),
      floatingActionButtonLocation:FloatingActionButtonLocation.centerDocked,


      
    body:
        tabs[selectedIndex]
    );
      
  }
  List <Widget> tabs =[TaskList(),SettingsTab()];
  
  void addTaskBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context)=>AddTaskBottomSheet());
  }
}
