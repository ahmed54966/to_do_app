import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/app_colors.dart';
import 'package:to_do_app/auth/custom_text_form_field.dart';
import 'package:to_do_app/dialog_utilies.dart';
import 'package:to_do_app/firebase_utiles.dart';
import 'package:to_do_app/model/my_user.dart';
import 'package:to_do_app/providers/user_provider.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatefulWidget {

  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formKey = GlobalKey<FormState>();

  TextEditingController nameControler = TextEditingController();

  TextEditingController emailControler = TextEditingController();

  TextEditingController passwordControler = TextEditingController();

    TextEditingController confirmPasswordControler = TextEditingController();

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
            title:Text("create_accout".tr(),
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
              CustomTextFormField(labelTextName: "user_name".tr(),controller:nameControler ,validator: (text) {
                if (text == null || text.trim().isEmpty){
                  return "please enter user name .".tr();
                }
                return null ;
              },),
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
              CustomTextFormField(labelTextName: "confirm_password".tr(),controller:confirmPasswordControler ,
              keyboardType:TextInputType.phone ,
              showPassword: true,
              validator: (text) {
                if (text == null || text.trim().isEmpty){
                  return "please enter confirm password .".tr();
                }
                if (text != passwordControler.text){
                  return "confirm password does not match password.".tr();
                }

                return null ;
              },
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(onPressed: (){
                    register();
                },

                style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: AppColors.whiteColor),

                child: Text("create_account".tr(),
                style: Theme.of(context).textTheme.titleLarge,)),
              )


            ],
          ),
        )),








        ),

      ],
    );
  }

  void register () async {
    if (formKey.currentState?.validate() == true){
      DialogUtiles.voidShowLoading(context : context , message: "loading".tr());
    try {
  final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: emailControler.text,
    password: passwordControler.text,
  );



///added to firestore
  MyUser myUser = MyUser(id:credential.user?.uid ??"" ,
  email: emailControler.text,
  name: nameControler.text);
  await FirebaseUltiles.addUserToFireStore(myUser);

///authprovider
  var authProvider = Provider.of<AuthUserProvider>(context,listen: false);
  authProvider.updateUser(myUser);
///hide dialog
  DialogUtiles.hideDialog(context);

///show message in dialog
  DialogUtiles.showMessage(context: context , message: "register successfull".tr(), 
  title: 'Title'.tr(),
  posActionName: "ok".tr(),
  posAction: (){
      Navigator.pushReplacementNamed(context, '/homeScreen');
      
  }
  );



  print(credential.user?.uid??"");
} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    
  DialogUtiles.hideDialog(context);

  DialogUtiles.showMessage(context: context , message: "The password provided is too weak.".tr(), 
  title: 'Title'.tr(),
  posActionName: "ok".tr());

    print('The password provided is too weak.');
  } else if (e.code == 'email-already-in-use') {
    
  DialogUtiles.hideDialog(context);

  DialogUtiles.showMessage(context: context , message: "The account already exists for that email.".tr(),
  title: 'Title'.tr(),
  posActionName: "ok".tr());

    print('The account already exists for that email.');
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
