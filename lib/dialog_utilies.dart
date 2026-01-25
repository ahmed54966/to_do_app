

import 'package:flutter/material.dart';

class DialogUtiles {
  static voidShowLoading({required BuildContext context , required String message}){
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context){
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(message,
                style: Theme.of(context).textTheme.titleMedium,),
              )
            ],
          ),
        );
      }
      );
  }

  static void hideDialog(BuildContext context){
    Navigator.pop(context);
  } 

  static void showMessage ({required BuildContext context ,
  required String message ,
    required String title ,
    String? posActionName,
    Function? posAction,
    String? negActionName,
    Function? negAction
    }){

    List <Widget> actions = [];
    
    if (posActionName != null){
      actions.add(TextButton(onPressed: (){
        Navigator.pop(context);
        posAction?.call();
      },
      child: Text(posActionName)));
    }

    if (negActionName != null){
      actions.add(TextButton(onPressed: (){
        Navigator.pop(context);
        posAction?.call();
      },
      child: Text(negActionName)));
    }    


    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          content: 
                Text(message,
                style: Theme.of(context).textTheme.titleMedium,),
                title: Text(title,
                style: Theme.of(context).textTheme.titleMedium ,),
                actions: actions,
              );
      }
        );
      }
  }
