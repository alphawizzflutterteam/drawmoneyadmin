import 'dart:convert';

import 'package:drawmoneyadmin/Helper/Colors.dart';
import 'package:drawmoneyadmin/Screen/compaign_management.dart';
import 'package:drawmoneyadmin/Screen/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../Api services/api_services/apiStrings.dart';
import 'login_view.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCampaignAndResultCounts();
  }
  @override

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
                     // Text('${campaignCount}'),
                      Container(
                        height: 40,
                        width: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.appbar),
                        child: Center(child: Text("Campaign Management",style: TextStyle(color: AppColors.whit),)),
                      )

                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),

            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ResultScreen()));

              },
              child:   Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.appbar)
                ),
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                     // Text("$resultCount"),
                      Container(
                        height: 40,
                        width: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.appbar),
                        child: Center(child: Text("Result Management",style: TextStyle(color: AppColors.whit),)),
                      )

                    ],
                  ),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }


  String campaignCount="0";
  String resultCount="0";
  getCampaignAndResultCounts() async {
    var headers = {
      'Cookie': 'ci_session=23fba2d0e4c13d65dfd536d5109167afccfdf003'
    };
    var request = http.Request('GET', getCampaignAndResult);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result=await response.stream.bytesToString();
      var finalResult = jsonDecode(result);
      // print('data----------${finalResult}');
      // setSnackbar(context, finalResult['msg']) ;
      //  print(await response.stream.bytesToString());
      if(finalResult['status'])
      {
        campaignCount=finalResult['count_campaign'].toString();
        resultCount=finalResult['count_result'];
        setState(() {
        });
      }
    }
    else {
      print(response.reasonPhrase);
    }

  }
}
