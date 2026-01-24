
import 'package:flutter/material.dart';
import 'package:to_do_app/app_colors.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {
  String labelTextName;
  String? Function(String?) validator;
  TextInputType keyboardType;
  TextEditingController controller;
  bool showPassword;
  CustomTextFormField({required this.labelTextName,
  required this.validator,
  required this.controller,
  this.keyboardType = TextInputType.text,
  this.showPassword = false
  });
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: AppColors.primaryColor,
                        width: 2,
                      )
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: AppColors.primaryColor,
                        width: 2, ),
                    ),
                    errorBorder:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: AppColors.redColor,
                        width: 2, ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: AppColors.redColor,
                        width: 2, ),
                        ),
                    
                    labelText: labelTextName,
                    labelStyle: Theme.of(context).textTheme.titleMedium,
                  ),
                  validator:validator,
                  keyboardType: keyboardType,
                  controller:controller ,
                  obscureText: showPassword,
                ),
    );
  }
}
