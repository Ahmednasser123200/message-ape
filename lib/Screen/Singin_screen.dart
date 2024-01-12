import 'package:flutter/material.dart';

import '../widget/new_bottons.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Shat_Screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SinginScreen extends StatefulWidget {
  static const String screenRoute = "singin_screen";

  const SinginScreen({super.key});

  @override
  State<SinginScreen> createState() => _SinginScreenState();
}

class _SinginScreenState extends State<SinginScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool showSpinner=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 180,
                child: Image.asset("images/1.png"),
              ),
              SizedBox(
                height: 50,
              ),
              TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (Value) {
                    email = Value;
                  },
                  decoration: InputDecoration(
                      hintText: 'Inter your Email',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10))))),
              SizedBox(
                height: 8,
              ),
              TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (Value) {
                    password = Value;
                  },
                  decoration: InputDecoration(
                      hintText: 'Inter your password',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10))))),
              SizedBox(
                height: 10,
              ),
              MyButton(
                  Colorn: Colors.yellow[900]!,
                  title: "Sing in",
                  onparessed: ()async {
                    setState(() {
                      showSpinner=true;
                    });


                    try{ final user =await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if (user!= null){
                      Navigator.pushNamed(context,ChatScreen.screenRoute );
                      setState(() {
                        showSpinner=false;
                      });

                    }}catch(e){
                      print(e);
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}