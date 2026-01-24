import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/app_colors.dart';
import 'package:to_do_app/auth/custom_text_form_field.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  TextEditingController nameControler = TextEditingController();
  TextEditingController emailControler = TextEditingController();
  TextEditingController passwordControler = TextEditingController();
    TextEditingController confirmPasswordControler = TextEditingController();

  LoginScreen({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        Container(
          color: AppColors.backGroudLightColor,
          child: Image.asset("assets/images/sign_in.png",
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.fill,),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            title:Text("login".tr(),
            style: Theme.of(context).textTheme.titleLarge,) ,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),


        body: Form(
          key: formKey,
          child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.3,),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("welcome_back".tr(),
                style:Theme.of(context).textTheme.titleMedium ,),
              ),
              
              CustomTextFormField(labelTextName: "email".tr(),controller:emailControler ,
              keyboardType:TextInputType.emailAddress ,
              validator: (text) {
                if (text == null || text.trim().isEmpty){
                  return "please enter Email .".tr();
                }
                final bool emailValid = 
                  RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(text);
                  if(!emailValid){
                    return "plaease enter valid email.".tr();
                  }
                return null ;
              },),
              CustomTextFormField(labelTextName: "password".tr(),controller:passwordControler ,
              keyboardType:TextInputType.phone ,
              showPassword: true,
              validator: (text) {
                if (text == null || text.trim().isEmpty){
                  return "please enter password.".tr();
                }
                if (text.length < 6){
                  return "password should be at least 6 chars.".tr();
                }
                return null ;
              },),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(onPressed: (){
                    register();
                },

                style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: AppColors.whiteColor),

                child: Text("login".tr(),
                style: Theme.of(context).textTheme.titleLarge,)),
              ),
              TextButton(onPressed: (){
                Navigator.pushNamed(context, '/RegisterScreen');
              },
              child: Text("or create account".tr(),
              style: Theme.of(context).textTheme.bodyMedium)
              )


            ],
          ),
        )),








        ),

      ],
    );
  }
  
  void register() {
    if (formKey.currentState?.validate() == true){

    }
  }
}
