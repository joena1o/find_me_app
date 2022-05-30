import 'package:flutter/material.dart';
import 'Screens/Auth/Auth.dart';
import 'Screens/DashBoard.dart';
import 'Screens/WelcomeScreem.dart';
import 'Utils/Prefs.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {

  int currIndex = 1;



  SwitchState(index){

    setState((){

      currIndex = index;

    });

  }


  void initState(){

    super.initState();





  }

  @override
  Widget build(BuildContext context) {

    return (currIndex==1)?WelcomeScreen(callback: SwitchState):((currIndex==2)?Auth(callback: SwitchState,):DashBoard());



  }
}
