import 'package:flutter/material.dart';
import 'package:massage_app/Screen/registration_screen.dart';

import '../widget/new_bottons.dart';
import 'Singin_screen.dart';

class Welcomescreen extends StatefulWidget {
  static const String screenRoute = "welcom_Screen";

  const Welcomescreen({super.key});

  @override
  State<Welcomescreen> createState() => _WelcomescreenState();
}

class _WelcomescreenState extends State<Welcomescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Container(
                  height: 180,
                  child: Image.asset("images/1.png"),
                ),
                Text(
                  "MassageMe",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      color: Color(0xff2e386b)),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            MyButton(
              title: "Sing in",
              Colorn: Colors.yellow[900]!,
              onparessed: () {
                Navigator.pushNamed(context, SinginScreen.screenRoute);
              },
            ),
            MyButton(
                Colorn: Colors.blue[800]!, title: "ergister", onparessed: () {
              Navigator.pushNamed(context, RegistrationScreen.screenRoute);
            })
          ],
        ),
      ),
    );
  }
}
