
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../Helper/Colors.dart';
import '../Model/result_model.dart';


class CompletedScreen extends StatelessWidget {
  final Lottery lot;

  const CompletedScreen({super.key, required this.lot});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          //toolbarHeight: 60,
          centerTitle: true,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/images/CupIcon.png",
                scale: 2,
              ),
              const SizedBox(
                width: 7,
              ),
              const Text(
                "Winners",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 7,
              ),
              Image.asset(
                "assets/images/CupIcon.png",
                scale: 2,
              ),
            ],
          ),
          // const Text(
          //   "Winner",
          //   style: TextStyle(
          //       color: AppColors.whit, fontSize: 22,),
          // ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.chevron_left,
                color: Colors.white,
                size: 30,
              )),
          actions: [],
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height * .12,
              decoration: BoxDecoration(
                  color: AppColors.secondary1,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .3,
                    child: Text(
                      lot.gameName.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Entry Fees",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "₹${lot.ticketPrice.toString()}",
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),

                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              color: AppColors.bgColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .3,
                    child: Text(
                      "Rank",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .3,
                    child: Text(
                      "Coupon No.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .3,
                    child: Text(
                      "Winnings",
                      textAlign: TextAlign.end,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: lot.winningPositionHistory!.length,
                shrinkWrap: true,
                itemBuilder: (context, i) {
                  return InkWell(
                    // onTap: (){
                    //   showDialog(
                    //     context: context,
                    //     builder: (BuildContext context) {
                    //       return AlertDialog(
                    //         title: Text('Winner Details'),
                    //         content: Container(
                    //           height: 100,
                    //           child: Column(
                    //             //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //             children: [
                    //               Row(
                    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //                 children: [
                    //                   Text("User Name"),
                    //                   Text(lot.winners[i].userName ?? "",style: TextStyle(fontWeight: FontWeight.bold),),
                    //                 ],
                    //               ),
                    //               Row(
                    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //
                    //                 children: [
                    //                   Text("Mobile No."),
                    //                   Text(lot.winners[i].mobile ?? "",style: TextStyle(fontWeight: FontWeight.bold),),
                    //                 ],
                    //               ),
                    //               Row(
                    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //
                    //                 children: [
                    //                   Text("Rank"),
                    //                   Text(lot.winners[i].winPosition ?? "",style: TextStyle(fontWeight: FontWeight.bold),),
                    //                 ],
                    //               ),
                    //               Row(
                    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //
                    //                 children: [
                    //                   Text("Price"),
                    //                   Text(lot.winners[i].winnerPrice ?? "",style: TextStyle(fontWeight: FontWeight.bold),),
                    //                 ],
                    //               ), Row(
                    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //
                    //                 children: [
                    //                   Text("Coupon No"),
                    //                   Text(lot.winners[i].lotteryNumber ?? "",style: TextStyle(fontWeight: FontWeight.bold),),
                    //                 ],
                    //               ),
                    //
                    //             ],
                    //           ),
                    //         ),
                    //       );
                    //     },
                    //   );
                    // },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      color: i % 2 != 0 ? AppColors.bgColor : Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .3,
                            child: Text(
                              "${lot.winningPositionHistory![i].lotteryNo}",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .3,
                            child: Text(
                              "${lot.winningPositionHistory![i].winningPosition}",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Spacer(),
                          if (int.parse(lot.winningPositionHistory![i].lotteryNo
                                  .toString()) <=
                              3)
                            Image.asset(
                              "assets/icons/winner1.png",
                              scale: 1.2,
                            ),
                          SizedBox(width: 5),
                          Text(
                            '₹ ${lot.winningPositionHistory![i].winnerPrice}',
                            style: const TextStyle(
                              color: AppColors.fntClr,
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
