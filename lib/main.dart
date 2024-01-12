import 'package:flutter/material.dart';
import 'Screen/Shat_Screen.dart';
import 'Screen/Singin_screen.dart';
import 'Screen/Welcome_screen.dart';
import 'Screen/registration_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  final _auth = FirebaseAuth.instance;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Massagme App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home: ChatScreen(),
      initialRoute: _auth.currentUser!=null?ChatScreen.screenRoute:Welcomescreen.screenRoute ,
      routes: {
        Welcomescreen.screenRoute: (context) => Welcomescreen(),
        SinginScreen.screenRoute: (context) => SinginScreen(),
        RegistrationScreen.screenRoute: (context) => RegistrationScreen(),
        ChatScreen.screenRoute: (context) => ChatScreen(),
      },
    );
  }
}
