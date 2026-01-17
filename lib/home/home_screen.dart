import 'package:flutter/material.dart';


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
        title: Text("To Do List",
        style: Theme.of(context).textTheme.titleLarge,),
      ) ,

      bottomNavigationBar:BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 12,
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            selectedIndex = index ;
            setState(() {
              
            });
          },
          items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Task List"),
        
            BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings"),
        ]
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed:(){

      },
      child: Icon(Icons.add, size: 35,),
    ),
      floatingActionButtonLocation:FloatingActionButtonLocation.centerDocked,

      );
  }
}
