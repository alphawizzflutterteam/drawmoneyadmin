import 'dart:convert';

import 'package:drawmoneyadmin/Helper/Colors.dart';
import 'package:drawmoneyadmin/Screen/add_compaign.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Api services/api_services/apiStrings.dart';
import '../Model/campaign_list_model.dart';

class CompaignManagement extends StatefulWidget {
  const CompaignManagement({Key? key}) : super(key: key);

  @override
  State<CompaignManagement> createState() => _CompaignManagementState();
}

class _CompaignManagementState extends State<CompaignManagement> {
  CampaignListModel? campaignListModel;
  getCampaignList() async {
    var headers = {
      'Cookie': 'ci_session=88e68207d1d27f6c41830022f5b541e0b08ff339'
    };
    var request = http.Request('GET', campaignListApi);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      var finalResult = jsonDecode(finalResponse);
      setState(() {
        campaignListModel = CampaignListModel.fromJson(finalResult);
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCampaignList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.textFieldClr,
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: AppColors.whit,
        backgroundColor: AppColors.appbar,
        title: Text(
          "Campaign Management",
          style: TextStyle(fontSize: 20),
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddCompaign()));
        },
        child: Container(
          height: 40,
          width: 140,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: AppColors.appbar),
          child: Center(
            child: Text(
              'Add Compaign+',
              style: TextStyle(color: AppColors.whit),
            ),
          ),
        ),
      ),
      body: campaignListModel== null ? Center(child: Text('No Data Found!!',style: TextStyle(fontWeight: FontWeight.bold),),) :ListView.builder(
        itemCount: campaignListModel?.data?.length ,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.whit,
                borderRadius: BorderRadius.circular(10)
              ),
             // height: 100,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8,right: 8,top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                       Text( campaignListModel!.data?[index].gameName ?? "",style: TextStyle(color: AppColors.appbar),),
                       Container(
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(5),
                             color: AppColors.secondary1
                           ),
                           child: Padding(
                             padding: const EdgeInsets.only(left: 8,right: 8,top: 2,bottom: 2),
                             child: Text( 'Result: ${campaignListModel!.data?[index].resultDate ?? ""} ${campaignListModel!.data?[index].resultTime ?? ""}'),
                           ))
                      ],
                    ),
                  ),
                  Divider(),

                  Padding(
                    padding: const EdgeInsets.only(left: 8,right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text('300\nSlot',style: TextStyle(fontWeight: FontWeight.bold),),
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: AppColors.buttonColor
                                ),

                                child: Padding(
                                  padding: const EdgeInsets.only(left: 6,right: 6,top: 2,bottom: 2),
                                  child: Text('Start:${campaignListModel!.data?[index].date ?? ""}',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                                )),
                          ],
                        ),
                        //Spacer(),
                        Column(
                          children: [
                            Text('02 h: 55m',style: TextStyle(color: AppColors.appbar),),
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: AppColors.appbar,
                                  gradient: LinearGradient(
                                    colors: [
                                      AppColors.primary.withOpacity(.9),
                                      AppColors.primary.withOpacity(.6),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),

                                ),

                                child: Padding(
                                  padding: const EdgeInsets.only(left: 6,right: 6,top: 2,bottom: 2),
                                  child: Text('Entry Fees:${campaignListModel!.data?[index].ticketPrice ?? ""}',style: TextStyle(color: AppColors.whit,fontSize: 12),),
                                )),
                            SizedBox(height: 20,),
                          ],
                        ),
                    //    Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('   300\nSlot Left',style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.appbar),),
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: AppColors.buttonColor
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 6,right: 6,top: 2,bottom: 2),
                                  child: Text('End:${campaignListModel!.data?[index].endDate ?? ""}',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 8,right: 8,top: 5),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Container(
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(10),
                  //           color: AppColors.buttonColor
                  //         ),
                  //
                  //           child: Padding(
                  //             padding: const EdgeInsets.only(left: 6,right: 6,top: 2,bottom: 2),
                  //             child: Text('Start:${campaignListModel!.data?[index].date ?? ""}',style: TextStyle(fontSize: 12),),
                  //           )),
                  //       Container(
                  //           decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.circular(10),
                  //               color: AppColors.buttonColor
                  //           ),
                  //           child: Padding(
                  //             padding: const EdgeInsets.only(left: 6,right: 6,top: 2,bottom: 2),
                  //             child: Text('End:${campaignListModel!.data?[index].endDate ?? ""}',style: TextStyle(fontSize: 12),),
                  //           ))
                  //     ],
                  //   ),
                  // ),
                  SizedBox(height: 10,),
                  Container(height: 30,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                        AppColors.note1.withOpacity(.5),
                          AppColors.note1.withOpacity(.9),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),

                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10))
                  ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8,right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(

                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(

                                image: DecorationImage(image: AssetImage('assets/icons/winner1.png'),

                                )
                            ),
                          ),
                          SizedBox(width: 5,),
                          Text('Mega ₹1000'),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(

                              image: DecorationImage(image: AssetImage('assets/icons/teamIcon.png'),

                              )
                            ),
                          ),
                          SizedBox(width: 5,),
                          // Image(image: AssetImage('assets/icons/teamIcon.png')),
                          Text('Max Ticket:20'),
                        ],
                      ),
                    ],
                  ),
                ),
                  )
                ],
              ),
            ),
          );

        },
      ),
    );
  }
}
