import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

import '../Api services/api_services/apiConstants.dart';
import '../Api services/api_services/apiStrings.dart';
import '../Helper/Colors.dart';
import 'compaign_management.dart';
class AddCompaign extends StatefulWidget {
  const AddCompaign({Key? key}) : super(key: key);

  @override
  State<AddCompaign> createState() => _Add_CompaignState();
}

class _Add_CompaignState extends State<AddCompaign> {

  TextEditingController compaignNameController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController resultDateController = TextEditingController();
  TextEditingController ticketCountController  = TextEditingController();
  TextEditingController maxCountController  = TextEditingController();
  TextEditingController prizeNameController  = TextEditingController();
  TextEditingController startNumberController  = TextEditingController();
  TextEditingController ticketPriceController  = TextEditingController();


  TimeOfDay _openTime = TimeOfDay.now();
  TimeOfDay _closeTime = TimeOfDay.now();
  TimeOfDay _resultTime = TimeOfDay.now();

  List<String> winningPosition = ['']; // List to store selected dropdown values for each row
  List<String> winnerPrice = ['']; //


  bool isOpen(TimeOfDay openTime, TimeOfDay closeTime) {
    // Convert TimeOfDay to minutes for easier comparison
    int openMinutes = openTime.hour * 60 + openTime.minute;
    int closeMinutes = closeTime.hour * 60 + closeTime.minute;

    print('open=${openMinutes}');
    print('close=${closeMinutes}');
    // If open time is less than close time, return true, otherwise false
    return openMinutes < closeMinutes;
  }

  //String _selectedTimeString ='${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}';
  Future<void> _selectTime(BuildContext context,int i) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _openTime,

    );
    if (picked != null && picked != _openTime && i==1) {
      setState(() {
       // _selectedTimeString = '${picked.hour}:${picked.minute.toString().padLeft(2, '0')}';
        _openTime = picked;
      });
    }
    else if (picked != null && picked != _closeTime && i==2) {
      setState(() {
       // _selectedTimeString = '${picked.hour}:${picked.minute.toString().padLeft(2, '0')}';
        _closeTime = picked;
      });
    }
    else if (picked != null && picked != _resultTime && i==3) {
      setState(() {
       // _selectedTimeString = '${picked.hour}:${picked.minute.toString().padLeft(2, '0')}';
        _resultTime = picked;
      });
    }
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 60))
    );

    if (picked != null && picked != controller.text) {
      setState(() {
        controller.text = picked.toLocal().toString().split(' ')[0];
      });
    }
  }
  
  Future<void> _selectDate1(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(startDateController.text),
      firstDate:DateTime.parse(startDateController.text),
      lastDate: DateTime.now().add(Duration(days: 60))
    );

    if (picked != null && picked != controller.text) {
      setState(() {
        controller.text = picked.toLocal().toString().split(' ')[0];
      });
    }
  }
  Future<void> _selectDate2(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(endDateController.text),
      firstDate:  DateTime.parse(endDateController.text),
      lastDate: DateTime.now().add(Duration(days: 60))
    );

    if (picked != null && picked != controller.text) {
      setState(() {
        controller.text = picked.toLocal().toString().split(' ')[0];
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: (){
            if(compaignNameController.text=='') {
              Fluttertoast.showToast(msg: 'Enter Campaign Name');
              //return;
            }
           else if(_image==null) {
              Fluttertoast.showToast(msg: 'Upload Image');
              //return;
            }
           else if(startDateController.text=='') {
              Fluttertoast.showToast(msg: 'Enter Start Date');
              //return;
            }
           else if(endDateController.text=='') {
              Fluttertoast.showToast(msg: 'Enter End Date');
              //return;
            }
           else if(!isOpen(_openTime,_closeTime)){
             Fluttertoast.showToast(msg: 'Please Select Correct Close Time ');
            }
           else if(resultDateController.text=='') {
              Fluttertoast.showToast(msg: 'Enter Result Date');
              //return;
            }
            else if(!isOpen(_closeTime,_resultTime)){
              Fluttertoast.showToast(msg: 'Please Select Correct Result Time ');
            }
           else if(ticketCountController.text=='') {
              Fluttertoast.showToast(msg: 'Enter Ticket Count');
              //return;
            }
           else if(maxCountController.text=='') {
              Fluttertoast.showToast(msg: 'Enter Max Count');
              //return;
            }
           else if(int.parse(maxCountController.text.toString()) > int.parse(ticketCountController.text.toString())){
              Fluttertoast.showToast(msg: 'Enter Correct Max Count');
            }
           else if(prizeNameController.text=='') {
              Fluttertoast.showToast(msg: 'Enter Prize Name');
              //return;
            }
           else if(startNumberController.text=='') {
              Fluttertoast.showToast(msg: 'Enter Start Number');
              //return;
            }
           else if(int.parse(startNumberController.text.toString()) <= int.parse(ticketCountController.text.toString()))
          {
            Fluttertoast.showToast(msg: 'Start number should be greater than ticket count');
          }
           else if(ticketPriceController.text=='') {
              Fluttertoast.showToast(msg: 'Enter Ticket Price');
              //return;
            }
           else  if(winningPosition.any((amount) => amount.isEmpty))
            {
              Fluttertoast.showToast(msg: "Enter Winning Position");

            }
           else  if(winnerPrice.any((amount) => amount.isEmpty))
            {
              Fluttertoast.showToast(msg: "Enter Winner Price");

            }
           else if( int.parse(ticketCountController.text.toString() ) < winningPosition.length){
              Fluttertoast.showToast(msg: "Your winning positions Should be less than or equal to Ticket Count ");
           }
           else{

              addCampaign();
            }
          },
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.appbar,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Center(child: Text('Add Campaign',style: TextStyle(color: AppColors.whit),)),
          ),
        ),
      ),
      backgroundColor: AppColors.textFieldClr,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: AppColors.whit,
            onPressed: (){
            setState(() {
              winningPosition.add(''); // Add a new row with default city 'Indore'
              winnerPrice.add(''); // Add a
            });
          },
        child: Icon(Icons.add,size: 25,color: Colors.black,),
          ) ,
          SizedBox(width: 10,),
          FloatingActionButton(
            backgroundColor: AppColors.whit,
            onPressed: (){
            setState(() {
              winningPosition.removeLast(); // Add a new row with default city 'Indore'
              winnerPrice.removeLast(); // Add a
            });
          },
        child: Icon(Icons.remove,size: 25,color: Colors.black,),
          )
        ],
      ),
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: AppColors.whit,
        backgroundColor: AppColors.appbar,
        title:Text("Add Campaign",style: TextStyle(fontSize: 20),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Text("Campaign Name",style: TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
          
              Container(
                decoration: BoxDecoration(
                  color: AppColors.whit,
                 // border: Border.all(color: colors.black12, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  controller: compaignNameController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 10, top: 0),
                    //   prefixIcon: Icon(Icons.person),
                    hintText: 'Enter Campaign Name',
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return 'Please enter Order Number';
                  //   }
                  //   return null; // Return null if the input is valid
                  // },
                ),
              ),
              SizedBox(height: 10,),
          
              Text("Image",style: TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              InkWell(
                onTap: (){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Select Option'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              child: Container(
                                padding: EdgeInsets.all(16),
                                child: Text("Gallery"),
                              ),
                              onTap: () {
                                // Navigator.of(context).pop(); // Close the AlertDialog
                                getImageFromGallery();
                              },
                            ),
                            InkWell(
                              child: Container(
                                padding: EdgeInsets.all(16),
                                child: Text("Camera"),
                              ),
                              onTap: () {
                                //  Navigator.of(context).pop(); // Close the AlertDialog
                                getImageFromCamera();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  height: _image == null?  50 : 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.whit,
                    // border: Border.all(color: colors.black12, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _image == null ? Center(child: Text('Upload',style: TextStyle(fontSize: 18),)) : Image.file(
                    _image!,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,)
                ),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Start Date ",style: TextStyle(fontWeight: FontWeight.bold),),
                  Text("End Date",style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox()
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width/2.3,
                   // width: 200,
                    decoration: BoxDecoration(
                      color: AppColors.whit,
                     // border: Border.all(color: colors.black12, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      onTap: () {
                        _selectDate(context, startDateController);
                      },
                      controller: startDateController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10, top: 15),
                        hintText: "Enter Date",
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            _selectDate(context, startDateController);
                          },
                          child: Icon(Icons.calendar_today,color: AppColors.appbar,),
                        ),
                      ),
                      readOnly: true,
                    ),
                  ),
          
                  Container(
                    width: MediaQuery.sizeOf(context).width/2.3,
          
                    decoration: BoxDecoration(
                      color: AppColors.whit,
                     // border: Border.all(color: colors.black12, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      onTap: () {
                        if(startDateController.text=='')
                        {
                          Fluttertoast.showToast(msg: 'Please Select Start Date');
                        }
                        else{
                          _selectDate1(context, endDateController);
                        }
                      },
                      controller: endDateController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10, top: 15),
                        hintText: "Enter Date",
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            if(startDateController.text=='')
                            {
                              Fluttertoast.showToast(msg: 'Please Select Start Date');
                            }
                            else{
                              _selectDate1(context, endDateController);
                            }

                          },
                          child: Icon(Icons.calendar_today,color: AppColors.appbar,),
                        ),
                      ),
                      readOnly: true,
                    ),
                  ),
          
          
                ],
              ),
          
          
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Open Time  ",style: TextStyle(fontWeight: FontWeight.bold),),
                  Text("Close Time",style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox()
                ],
              ),
          
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){
                      _selectTime(context,1);
                    },
                    child: Container(
                     // height: 40,
                      width: MediaQuery.sizeOf(context).width/2.3,
                      decoration: BoxDecoration(
                        color: AppColors.whit,
          
                        //  border: Border.all(color: AppColors.primary),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                            _openTime.format(context).toString()=='' ? 'open Time' : '${_openTime.format(context)}',
                              style: TextStyle(fontSize: 18),
                            ),
          
                            Icon(
                              Icons.access_time,
                              size: 22, color: AppColors.appbar
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      _selectTime(context,2);
                    },
                    child: Container(
                     // height: 40,
                      width: MediaQuery.sizeOf(context).width/2.3,
                      decoration: BoxDecoration(
                        color: AppColors.whit,
          
                        //  border: Border.all(color: AppColors.primary),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                            _closeTime.format(context).toString()=='' ? 'Close Time' : '${_closeTime.format(context)}',
                              style: TextStyle(fontSize: 18),
                            ),
          
                            Icon(
                              Icons.access_time,
                              size: 22, color: AppColors.appbar
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          
                  // Container(
                  //   width: MediaQuery.sizeOf(context).width/2.3,
                  //
                  //   decoration: BoxDecoration(
                  //     color: AppColors.whit,
                  //     // border: Border.all(color: colors.black12, width: 2),
                  //     borderRadius: BorderRadius.circular(10),
                  //   ),
                  //   child: TextFormField(
                  //     onTap: () {
                  //       _selectDate(context, endDateController);
                  //     },
                  //     controller: endDateController,
                  //     decoration: InputDecoration(
                  //       contentPadding: EdgeInsets.only(left: 10, top: 10),
                  //       hintText: "Close Time",
                  //       focusedBorder: InputBorder.none,
                  //       errorBorder: InputBorder.none,
                  //       enabledBorder: InputBorder.none,
                  //       suffixIcon: GestureDetector(
                  //         onTap: () {
                  //           _selectDate(context, endDateController);
                  //         },
                  //         child: Icon(Icons.watch_later_outlined,color: AppColors.appbar,),
                  //       ),
                  //     ),
                  //     readOnly: true,
                  //   ),
                  // ),
          
          
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Result Date  ",style: TextStyle(fontWeight: FontWeight.bold),),
                  Text("Result Time",style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox()
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width/2.3,

                    decoration: BoxDecoration(
                      color: AppColors.whit,
                      // border: Border.all(color: colors.black12, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      onTap: () {
                        print("bbbbbbbbbbbbbb");
                        if(endDateController.text=='')
                        {
                          Fluttertoast.showToast(msg: 'Please Select End Date');
                        }
                        else{
                          _selectDate2(context, resultDateController);
                        }
                      },
                      controller: resultDateController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10, top: 10),
                        hintText: "Enter Date",
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            print("bbbbbbbbbbbbbb");
                            if(endDateController.text=='')
                            {
                              Fluttertoast.showToast(msg: 'Please Select End Date');
                            }
                            else{
                              _selectDate2(context, resultDateController);
                            }
                          },
                          child: Icon(Icons.calendar_today,color: AppColors.appbar,),
                        ),
                      ),
                      readOnly: true,
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      _selectTime(context,3);
                    },
                    child: Container(
                       height: 48,
                      width: MediaQuery.sizeOf(context).width/2.3,
                      decoration: BoxDecoration(
                        color: AppColors.whit,
          
                        //  border: Border.all(color: AppColors.primary),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _resultTime.format(context).toString()=='' ? 'Enter Result Time' : '${_resultTime.format(context)}',
                              style: TextStyle(fontSize: 18),
                            ),
          
                            Icon(
                                Icons.access_time,
                                size: 22, color: AppColors.appbar
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          
                  // Container(
                  //   width: MediaQuery.sizeOf(context).width/2.3,
                  //
                  //   decoration: BoxDecoration(
                  //     color: AppColors.whit,
                  //     // border: Border.all(color: colors.black12, width: 2),
                  //     borderRadius: BorderRadius.circular(10),
                  //   ),
                  //   child: TextFormField(
                  //     onTap: () {
                  //       _selectDate(context, endDateController);
                  //     },
                  //     controller: endDateController,
                  //     decoration: InputDecoration(
                  //       contentPadding: EdgeInsets.only(left: 10, top: 10),
                  //       hintText: "Close Time",
                  //       focusedBorder: InputBorder.none,
                  //       errorBorder: InputBorder.none,
                  //       enabledBorder: InputBorder.none,
                  //       suffixIcon: GestureDetector(
                  //         onTap: () {
                  //           _selectDate(context, endDateController);
                  //         },
                  //         child: Icon(Icons.watch_later_outlined,color: AppColors.appbar,),
                  //       ),
                  //     ),
                  //     readOnly: true,
                  //   ),
                  // ),
          
          
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Ticket Count",style: TextStyle(fontWeight: FontWeight.bold),),
                  Text("Max Count",style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox()
                ],
              ),
          
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
          
                children: [
                  // SizedBox(height: 10,),
          
                  Container(
                    width: MediaQuery.sizeOf(context).width / 2.3,
                    decoration: BoxDecoration(
                      color: AppColors.whit,
                      // border: Border.all(color: colors.black12, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: ticketCountController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10, top: 0),
                        //   prefixIcon: Icon(Icons.person),
                        hintText: 'Enter Ticket Count',
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                      // validator: (value) {
                      //   if (value!.isEmpty) {
                      //     return 'Please enter Order Number';
                      //   }
                      //   return null; // Return null if the input is valid
                      // },
                    ),
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width / 2.3,
                    decoration: BoxDecoration(
                      color: AppColors.whit,
                      // border: Border.all(color: colors.black12, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: maxCountController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10, top: 0),
                        //   prefixIcon: Icon(Icons.person),
                        hintText: 'Enter Max Count',
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                      // validator: (value) {
                      //   if (value!.isEmpty) {
                      //     return 'Please enter Order Number';
                      //   }
                      //   return null; // Return null if the input is valid
                      // },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Prize Name      ",style: TextStyle(fontWeight: FontWeight.bold),),
                  Text("Start Number",style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox()
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
          
                children: [
                  // SizedBox(height: 10,),
          
                  Container(
                    width: MediaQuery.sizeOf(context).width / 2.3,
                    decoration: BoxDecoration(
                      color: AppColors.whit,
                      // border: Border.all(color: colors.black12, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: prizeNameController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10, top: 0),
                        //   prefixIcon: Icon(Icons.person),
                        hintText: 'Enter Prize Name',
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                      // validator: (value) {
                      //   if (value!.isEmpty) {
                      //     return 'Please enter Order Number';
                      //   }
                      //   return null; // Return null if the input is valid
                      // },
                    ),
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width / 2.3,
                    decoration: BoxDecoration(
                      color: AppColors.whit,
                      // border: Border.all(color: colors.black12, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: startNumberController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10, top: 0),
                        //   prefixIcon: Icon(Icons.person),
                        hintText: 'Enter Start Number',
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                      // validator: (value) {
                      //   if (value!.isEmpty) {
                      //     return 'Please enter Order Number';
                      //   }
                      //   return null; // Return null if the input is valid
                      // },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Text("Ticket Price",style: TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
          
              Container(
                decoration: BoxDecoration(
                  color: AppColors.whit,
                  // border: Border.all(color: colors.black12, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: ticketPriceController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 10, top: 0),
                    //   prefixIcon: Icon(Icons.person),
                    hintText: 'Ticket Price',
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return 'Please enter Order Number';
                  //   }
                  //   return null; // Return null if the input is valid
                  // },
                ),
              ),
              SizedBox(width: 10),
              ListView.builder(
                // scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: winningPosition.length,
                physics: NeverScrollableScrollPhysics(),
                // clipBehavior: Clip.none,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildRow(index),
                  );
                },
              ),
              SizedBox(height: 50,)
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildRow(int index) {
    return Column(
      children: [
       SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Winning Position",style: TextStyle(fontWeight: FontWeight.bold),),
            Text("Winner Price",style: TextStyle(fontWeight: FontWeight.bold),),
            SizedBox()
          ],
        ),
        SizedBox(height: 10,),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.whit,
                //  border: Border.all(color: AppColors.primary),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  initialValue: winningPosition[index],
                  onChanged: (value) {
                    setState(() {
                      winningPosition[index] = value; // Store the entered amount for the specific index
                    });
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 10, bottom: 8),
                    border: InputBorder.none,
                    hintText: 'Winner Position',
                    hintStyle:   TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              flex: 3,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.whit,
                 // border: Border.all(color: AppColors.primary),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  initialValue: winnerPrice[index],
                  onChanged: (value) {
                    setState(() {
                      winnerPrice[index] = value; // Store the entered amount for the specific index
                    });
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 10, bottom: 8),
                    border: InputBorder.none,
                    hintText: 'Winner Price',
                    hintStyle:   TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
  File? _image;

  final picker = ImagePicker();

  Future getImageFromGallery() async {
    XFile? image= await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _image= File(image.path);

      setState(() {
        Navigator.pop(context);
      });
    }
  }

  Future getImageFromCamera() async {
    XFile? image= await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      _image = File(image.path);
      setState(() {
       Navigator.pop(context);
      });
    }
  }

 Future<void> addCampaign() async {

   var headers = {
     'Cookie': 'ci_session=15b63e83479f0b815ac032d66e353bf5e7052074'
   };
   var param = {
   'game_id':'',
   'game_name':compaignNameController.text,
   'date':startDateController.text,
   'end_date':endDateController.text,
   'close_time':'${_closeTime.hour}:${_closeTime.minute.toString().padLeft(2, '0')}',
   'open_time':'${_openTime.hour}:${_openTime.minute.toString().padLeft(2, '0')}',
   'result_date':resultDateController.text,
   'result_time':'${_resultTime.hour}:${_resultTime.minute.toString().padLeft(2, '0')}',
   'ticket_price':ticketPriceController.text,
   'ticket_count':ticketCountController.text,
   'ticket_max_count':maxCountController.text,
   'prize_name':prizeNameController.text,
   'start_number':startNumberController.text,
   };
   List<Map<String, String>> productList = [];
   for (int i = 0; i < winningPosition.length; i++) {
     Map<String, String> productData = {
       'lottery_no[$i]': winningPosition[i].toString(),
     };
     productList.add(productData);
   }
   // int k = 0;
   for (int i = 0; i < winnerPrice.length; i++) {
     Map<String, String> guestData = {
       'winner_price[$i]': winnerPrice[i].toString(),
     };
     productList.add(guestData);
     // k++;
   }
   Map<String,String> data = addMapListToData(param, productList);


   var request = http.MultipartRequest('POST',addCampaignApi);
  // request.fields.addAll({data});

   data.forEach((key, value) {
     print('${key}:${value}');
     request.fields[key] = value;
   });

   request.files.add(await http.MultipartFile.fromPath('file',_image?.path.toString() ?? ""));

print(request.fields);
print(request.files);

   // final response = await post(Uri.parse(' https://admin.drawmoney.in/Apicontroller/addgame'), body: data.isNotEmpty ? data : [])
   //     .timeout(const Duration(seconds: timeOut));

   request.headers.addAll(headers);

   http.StreamedResponse response = await request.send();

   if(response.statusCode==200)
   {
     var result = await response.stream.bytesToString();
     var finalResult = jsonDecode(result);
     Fluttertoast.showToast(msg: "${finalResult['msg']}");
     if(finalResult['status']=='success')
       {
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>CompaignManagement()));
       }
     // var result=jsonDecode(response.body);
     // Fluttertoast.showToast(msg: "${result['message']}");
     // if(result['status']==true)
     //   {
     //
     //   }
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
   }

 }
  Map<String, String> addMapListToData(
      Map<String, String> data, List<Map<String, dynamic>> mapList) {
    for (var map in mapList) {
      map.forEach((key, value) {
        data[key] = value;
      });
    }
    return data;
  }
}
