import 'dart:convert';

import 'package:drawmoneyadmin/Helper/Colors.dart';
import 'package:drawmoneyadmin/Model/result_model.dart';
import 'package:drawmoneyadmin/Screen/add_compaign.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../Api services/api_services/apiStrings.dart';
import '../Model/campaign_list_model.dart';
import 'completedScreen.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  // CampainListModel? campaignListModel;
  ResultModel? resultModel;
  getResults() async {

    var headers = {
      'Content-Type': 'application/json',
      'Cookie': 'ci_session=a79ba699fd22a6277212abb4bc7acedff7076007'
    };
    var request = http.Request('GET',getresult);
    request.body = json.encode({
      "type": 3,
      "user_id": "0"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      var finalResult = jsonDecode(finalResponse);
      setState(() {
        resultModel = ResultModel.fromJson(finalResult);
      });
    }
    else {
      print(response.reasonPhrase);
    }

    // var request = http.Request('GET', campaignListApi);
    // http.StreamedResponse response = await request.send();
    // if (response.statusCode == 200) {
    //   var finalResponse = await response.stream.bytesToString();
    //   var finalResult = jsonDecode(finalResponse);
    //   setState(() {
    //     campaignListModel = CampainListModel.fromJson(finalResult);
    //   });
    // } else {
    //   print(response.reasonPhrase);
    // }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getResults();
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
          "Result",
          style: TextStyle(fontSize: 20),
        ),
      ),
      // floatingActionButton: InkWell(
      //   onTap: () {
      //     Navigator.push(
      //         context, MaterialPageRoute(builder: (context) => AddCompaign()));
      //   },
      //   child: Container(
      //     height: 40,
      //     width: 140,
      //     decoration: BoxDecoration(
      //         borderRadius: BorderRadius.circular(10), color: AppColors.appbar),
      //     child: Center(
      //       child: Text(
      //         'Add Compaign+',
      //         style: TextStyle(color: AppColors.whit),
      //       ),
      //     ),
      //   ),
      // ),
      body: resultModel == null
          ? Center(child: CircularProgressIndicator())
      : resultModel?.data?.lotteries.length==0 ? Center(
        child: Text(
          'No Data Found!!',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      )
          : ListView.builder(
        itemCount: resultModel?.data?.lotteries.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: (){
              if(resultModel?.data?.lotteries[index].resultStatus=='1')
                {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CompletedScreen(lot: resultModel!.data!.lotteries[index])));
                }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.whit,
                    borderRadius: BorderRadius.circular(10)),
                // height: 100,
                child: Column(
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.only(left: 8, right: 8, top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            resultModel?.data?.lotteries[index].gameName ?? "",
                            style: TextStyle(color: AppColors.appbar),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: AppColors.secondary1),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, top: 2, bottom: 2),
                                child: Text(
                                    'Result: ${DateFormat("dd-MM-yyyy").format(DateTime.parse(resultModel?.data!.lotteries[index].resultDate.toString() ?? ""))} ${resultModel?.data!.lotteries[index].resultTime ?? ""}'),
                              ))
                        ],
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 10,),
                          Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: AppColors.appbar,
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.buttonColor.withOpacity(.9),
                                    AppColors.buttonColor.withOpacity(.6),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 6,
                                    right: 6,
                                    top: 2,
                                    bottom: 2),
                                child: Text(
                                  'Complete',
                                  style: TextStyle(
                                      color: AppColors.blackTemp,
                                      fontSize: 12),
                                ),
                              )),
                          SizedBox(height: 10,),

                          // Column(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     Container(
                          //         decoration: BoxDecoration(
                          //             borderRadius:
                          //             BorderRadius.circular(5),
                          //             color: AppColors.buttonColor),
                          //         child: Padding(
                          //           padding: const EdgeInsets.only(
                          //               left: 6,
                          //               right: 6,
                          //               top: 2,
                          //               bottom: 2),
                          //           child: Text(
                          //             'Start:${resultModel?.data!.lotteries[index].openTime ?? ""}',
                          //             style: const TextStyle(
                          //                 fontSize: 12,
                          //                 fontWeight: FontWeight.w500),
                          //           ),
                          //         )),
                          //     SizedBox(height: 10),
                          //     Container(
                          //         decoration: BoxDecoration(
                          //             borderRadius:
                          //             BorderRadius.circular(5),
                          //             color: AppColors.buttonColor),
                          //         child: Padding(
                          //           padding: const EdgeInsets.only(
                          //               left: 6,
                          //               right: 6,
                          //               top: 2,
                          //               bottom: 2),
                          //           child: Text(
                          //             'Start:${DateFormat("dd-MM-yyyy").format(DateTime.parse(resultModel?.data!.lotteries[index].date.toString() ?? ""))}',
                          //             style: const TextStyle(
                          //                 fontSize: 12,
                          //                 fontWeight: FontWeight.w500),
                          //           ),
                          //         )),
                          //   ],
                          // ),
                          //Spacer(),
                          // Column(
                          //   children: [
                          //     Container(
                          //         decoration: BoxDecoration(
                          //           borderRadius: BorderRadius.circular(5),
                          //           color: AppColors.appbar,
                          //           gradient: LinearGradient(
                          //             colors: [
                          //               AppColors.primary.withOpacity(.9),
                          //               AppColors.primary.withOpacity(.6),
                          //             ],
                          //             begin: Alignment.topLeft,
                          //             end: Alignment.bottomRight,
                          //           ),
                          //         ),
                          //         child: Padding(
                          //           padding: const EdgeInsets.only(
                          //               left: 6,
                          //               right: 6,
                          //               top: 2,
                          //               bottom: 2),
                          //           child: Text(
                          //             'Complete',
                          //             style: TextStyle(
                          //                 color: AppColors.whit,
                          //                 fontSize: 12),
                          //           ),
                          //         )),
                          //     SizedBox(
                          //       height: 20,
                          //     ),
                          //   ],
                          // ),
                          //    Spacer(),
                          // Column(
                          //   crossAxisAlignment: CrossAxisAlignment.end,
                          //   children: [
                          //     Container(
                          //       decoration: BoxDecoration(
                          //           borderRadius: BorderRadius.circular(5),
                          //           color: AppColors.buttonColor),
                          //       child: Padding(
                          //         padding: const EdgeInsets.only(
                          //             left: 6, right: 6, top: 2, bottom: 2),
                          //         child: Text(
                          //           'End:${resultModel?.data!.lotteries[index].closeTime ?? ""}',
                          //           style: TextStyle(
                          //               fontSize: 12,
                          //               fontWeight: FontWeight.w500),
                          //         ),
                          //       ),
                          //     ),
                          //     SizedBox(height: 5),
                          //     Container(
                          //       decoration: BoxDecoration(
                          //           borderRadius: BorderRadius.circular(5),
                          //           color: AppColors.buttonColor),
                          //       child: Padding(
                          //         padding: const EdgeInsets.only(
                          //             left: 6, right: 6, top: 2, bottom: 2),
                          //         child: Text(
                          //           'End:${DateFormat('dd-MM-yyyy').format(DateTime.parse(resultModel?.data!.lotteries[index].endDate.toString() ?? "")) }',
                          //           style: TextStyle(
                          //               fontSize: 12,
                          //               fontWeight: FontWeight.w500),
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 30,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.note1.withOpacity(.5),
                              AppColors.note1.withOpacity(.9),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10))),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/icons/winner1.png'),
                                      )),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                    '${resultModel?.data!.lotteries[index].prizeName} ₹${resultModel?.data!.lotteries[index].ticketPrice}'),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/icons/teamIcon.png'),
                                      )),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                // Image(image: AssetImage('assets/icons/teamIcon.png')),
                                Text(
                                    'Max Coupon:${resultModel?.data!.lotteries[index].ticketMaxCount}'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
