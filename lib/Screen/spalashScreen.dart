import 'package:drawmoneyadmin/Screen/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpalashLogo extends StatefulWidget {
  const SpalashLogo({Key? key}) : super(key: key);

  @override
  State<SpalashLogo> createState() => _SpalashLogoState();
}

class _SpalashLogoState extends State<SpalashLogo> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sessionmanage();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body:  Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/splashscreen.png"),
            fit: BoxFit.fill,
          ),
        ),

      )

    );
  }
var userId;
  void sessionmanage(){

    Future.delayed(Duration(seconds: 3),() async {

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      userId=prefs.getString('userId');
      print(userId);
      print(userId.runtimeType);

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));

      // if(userId==null) {
      //   // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
      // }
      // else{
      //   // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dashboard(),));
      // }

    },);



  }


}