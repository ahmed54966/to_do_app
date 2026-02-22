import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/app_colors.dart';
import 'package:to_do_app/auth/custom_text_form_field.dart';
import 'package:to_do_app/dialog_utilies.dart';
import 'package:to_do_app/firebase_utiles.dart';
import 'package:to_do_app/providers/user_provider.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();


  TextEditingController emailControler = TextEditingController();

  TextEditingController passwordControler = TextEditingController();


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
                    login();
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

  void login () async {
    if (formKey.currentState?.validate() == true){
      DialogUtiles.voidShowLoading(context : context , message: "loading".tr());
    try {
  final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: emailControler.text,
    password: passwordControler.text,

  );


  
  var user = await FirebaseUltiles.readUserFromFireStore(credential.user?.uid??"");
  if (user==null){
    return;
  }

  ///authprovider
  // ignore: use_build_context_synchronously
  var authProvider = Provider.of<AuthUserProvider>(context,listen: false);
  authProvider.updateUser(user);
  
  // ignore: use_build_context_synchronously
  DialogUtiles.hideDialog(context);

  // ignore: use_build_context_synchronously
  DialogUtiles.showMessage(context: context , message: "login successfull".tr(),
  title: 'Title'.tr(),
  posActionName: "ok".tr(),
  posAction: (){
      Navigator.pushReplacementNamed(context, '/homeScreen');}
      );

  print(credential.user?.uid??"");
} on FirebaseAuthException catch (e) {
  if (e.code == 'invalid-credential') {

    
  DialogUtiles.hideDialog(context);

  DialogUtiles.showMessage(context: context , message: "user not found".tr(),
  title: 'Title'.tr(),
  posActionName: "ok".tr());

    print('The password provided is too weak.');
  } else if (e.code == 'wrong-password') {
    
  DialogUtiles.hideDialog(context);

  DialogUtiles.showMessage(context: context , message: "wrong password".tr(), 
  title: 'Title'.tr(),
  posActionName: "ok".tr());

    print('wrong password');
  }
} catch (e) {
  
  DialogUtiles.hideDialog(context);

  DialogUtiles.showMessage(context: context , message: e.toString(), 
  title: 'Title'.tr(),
  posActionName: "ok".tr());

  print(e);
}
    }
  }
}
