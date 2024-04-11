import 'dart:convert';

import 'package:drawmoneyadmin/Helper/Colors.dart';
import 'package:drawmoneyadmin/Screen/add_compaign.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../Api services/api_services/apiStrings.dart';
import '../Model/campaign_list_model.dart';

class CompaignManagement extends StatefulWidget {
  const CompaignManagement({Key? key}) : super(key: key);

  @override
  State<CompaignManagement> createState() => _CompaignManagementState();
}

class _CompaignManagementState extends State<CompaignManagement> {
  CampainListModel? campaignListModel;
  getCampaignList() async {
    var request = http.Request('GET', campaignListApi);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      var finalResult = jsonDecode(finalResponse);
      setState(() {
        campaignListModel = CampainListModel.fromJson(finalResult);
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
              'Add Campaign+',
              style: TextStyle(color: AppColors.whit),
            ),
          ),
        ),
      ),
      body: campaignListModel == null
          ? Center(child: CircularProgressIndicator())
          : campaignListModel?.data?.length == 0 ? Text("No data Found!!"):ListView.builder(
              itemCount: campaignListModel?.data?.length,
              itemBuilder: (context, index) {
                return Padding(
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
                                campaignListModel!.data?[index].gameName ?? "",
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
                                        'Result: ${DateFormat("dd-MM-yyyy").format(DateTime.parse(campaignListModel!.data[index].resultDate.toString()))} ${campaignListModel!.data[index].resultTime ?? ""}'),
                                  ))
                            ],
                          ),
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: AppColors.buttonColor),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 6,
                                            right: 6,
                                            top: 2,
                                            bottom: 2),
                                        child: Text(
                                          'Start:${campaignListModel!.data[index].openTime ?? ""}',
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      )),
                                  SizedBox(height: 10),
                                  Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: AppColors.buttonColor),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 6,
                                            right: 6,
                                            top: 2,
                                            bottom: 2),
                                        child: Text(
                                          'Start:${DateFormat("dd-MM-yyyy").format(DateTime.parse(campaignListModel!.data[index].date.toString())) ?? ""}',
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      )),
                                ],
                              ),
                              //Spacer(),
                              Column(
                                children: [
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
                                        padding: const EdgeInsets.only(
                                            left: 6,
                                            right: 6,
                                            top: 2,
                                            bottom: 2),
                                        child: Text(
                                          'Entry Fees:${campaignListModel!.data?[index].ticketPrice ?? ""}',
                                          style: TextStyle(
                                              color: AppColors.whit,
                                              fontSize: 12),
                                        ),
                                      )),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                              //    Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: AppColors.buttonColor),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 6, right: 6, top: 2, bottom: 2),
                                      child: Text(
                                        'End:${campaignListModel!.data?[index].closeTime ?? ""}',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: AppColors.buttonColor),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 6, right: 6, top: 2, bottom: 2),
                                      child: Text(
                                        'End:${DateFormat('dd-MM-yyyy').format(DateTime.parse(campaignListModel!.data[index].endDate.toString())) ?? ""}',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ],
                              )
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
                                        '${campaignListModel!.data[index].prizeName} ₹${campaignListModel!.data[index].ticketPrice}'),
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
                                        'Max Coupon:${campaignListModel!.data[index].ticketMaxCount}'),
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
