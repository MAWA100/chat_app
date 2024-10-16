import 'package:chat_app/constant.dart';
import 'package:chat_app/helper/show_snakbar.dart';
import 'package:chat_app/screens/chat_page.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_form_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterPage extends StatefulWidget {
    const RegisterPage({super.key});
static String id='RegisterPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
String? email;

String? password;

GlobalKey<FormState>formKey=GlobalKey();

bool isLoading=false;

  @override
  Widget build(BuildContext context) {
    return  ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor:kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: [const SizedBox(height: 75,),
                Image.asset('assets/images/scholar.png',height: 100,),
                const Center(
                  child: Text('Scholar Chat',style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontFamily: 'pacifico'
                  ),),
                ),
               const SizedBox(height: 75,),
                const Row(
                  children: [
                    Text('REGISTER',style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                     
                    ),),
                  ],
                ),
                const SizedBox(height: 20,),
               CustomFormTextField(
                onChanged: (p0) {
                  email=p0;
                },
                
                text: 'Email'),
              const SizedBox(height: 10,),
               CustomFormTextField(
                obscureText: true,
                onChanged: (p0) => password=p0
                ,text: 'Password'),
              const SizedBox(height: 30,),
              CustomButton(
              onTap: ()async {
                if (formKey.currentState!.validate()) {
                  isLoading=true;
                  setState(() {
                    
                  });
        try {
                await registerUser();
                 Navigator.pushNamed(context, ChatPage.id,arguments: email);
              } on FirebaseAuthException   catch (e) {
                 if (e.code == 'weak-password'){
                showSnakBar(context,'The password provided is too weak.');
              }else if(e.code == 'email-already-in-use') {
              showSnakBar(context, 'The account already exists for that email.');
              }}catch(e){
                showSnakBar(context, 'there was error');
              }
              isLoading=false;
              setState(() {
                
              });
             
      }else {
        showSnakBar(context, 'error');
      }
            
              },
              text: 'REGISTER'),
             const SizedBox(height: 10,),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                const Text('have already an account ? ',style: TextStyle(
                  color: Colors.white
                ),),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Text('Login',style: TextStyle(
                    color: Color(0xffC7EDE6)
                  ),),
                ),
              ],
             )
            
              ],
            ),
          ),
        ),
      ),
    );
  }

  

  Future<void> registerUser() async {
    var auth =FirebaseAuth.instance;
    UserCredential user=await auth
    .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
