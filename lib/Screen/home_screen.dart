import 'package:drawmoneyadmin/Helper/Colors.dart';
import 'package:drawmoneyadmin/Screen/compaign_management.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_view.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: AppColors.whit,
        backgroundColor: AppColors.appbar,
        title:Text("Home",style: TextStyle(fontSize: 20),),
        leading:  InkWell(
            onTap: (){
              showDialog(
                context: context,
                builder: (context) {
                  String contentText = "";
                  return StatefulBuilder(
                    builder: (context, setState) {
                      return AlertDialog(
                        title: const Text("Are you sure you want to Logout"),
                        content: Text(contentText),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () async{
                              final SharedPreferences prefs = await SharedPreferences.getInstance();
                              await prefs.setString('userId', '');
                              await Future.delayed(const Duration(milliseconds: 500));
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
                              setState(()  {
                                //Get.toNamed(loginScreen);
                              });
                            },
                            child: const Text("Logout"),
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            },
            child: const Icon(Icons.logout,size: 25,color: Colors.white,)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          children: [
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CompaignManagement()));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.appbar)
                ),
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text("3"),
                      Container(
                        height: 40,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.appbar),
                        child: Center(child: Text("Total Compaign",style: TextStyle(color: AppColors.whit),)),
                      )

                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.appbar)
              ),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text("3"),
                    Container(
                      height: 40,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.appbar),
                      child: Center(child: Text("Result",style: TextStyle(color: AppColors.whit),)),
                    )

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
