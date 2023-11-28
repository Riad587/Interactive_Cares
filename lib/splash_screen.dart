import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'dashboard.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});
  @override
  SplashScreen_State createState() => SplashScreen_State();
  }

  class SplashScreen_State extends State<SplashScreen>{

    @override
    void initState(){
      Timer(Duration(seconds: 3),(){
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      });
      super.initState();
      
    }
    Future<FirebaseApp> _initializeFirebase() async {
      FirebaseApp firebaseApp = await Firebase.initializeApp();

      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomeScreen(
              user: user,
            ),
          ),
        );
      }

      return firebaseApp;
    }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: Center(
        child: Container(
          child: SpinKitDoubleBounce(
            color: Colors.white,
            size: 80,
          ),
        ),
      ),
    );
  }
  }
