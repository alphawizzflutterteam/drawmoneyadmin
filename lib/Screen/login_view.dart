import 'dart:convert';

import 'package:drawmoneyadmin/Screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Api services/api_services/apiStrings.dart';
import '../Helper/Colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool seePassword=false;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  // final TextEditingController _mobile = TextEditingController();
  // final TextEditingController _ref = TextEditingController();
  bool isEighteenPlus = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Form(
            key: _formkey,
            child: Container(
                height: MediaQuery.of(context).size.height,
                // color: AppColors.bgColor,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/background.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 24, top: 16),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Image.asset(
                            "assets/images/splashlogo1.png",
                            scale: 5,
                          ),
                        ),
                      ),
                      Image.asset(
                        "assets/images/login.png",
                        scale: 2,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color(0XFF430103),
                              borderRadius: BorderRadius.circular(16)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Login",
                                style: TextStyle(
                                    color: AppColors.whit,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25),
                              ),
                              //("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic",style: TextStyle(color: AppColors.subTxtClr,fontWeight: FontWeight.normal,fontSize: 15),),
                              const SizedBox(
                                height: 40,
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                width: double.maxFinite,
                                height: 50,
                                decoration:BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.whit
                                ),
                                   // CustomBoxDecoration.myCustomDecoration(),
                                child: TextFormField(
                                //  maxLength: 10,
                                 // keyboardType: TextInputType.number,
                                  controller: _email,
                                  decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.only(top: 17),
                                      counterText: "",
                                      hintText: "Email",
                                      prefixIcon: Icon(Icons.email),
                                      // contentPadding: EdgeInsets.all(10),
                                      //  prefixIcon: Icon(Icons.call),
                                      border: InputBorder.none),
                                  style: const TextStyle(fontSize: 14),

                                  validator: (val) {

                                    if (val!.isEmpty) {
                                      return "Please Enter Email Address";
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                width: double.maxFinite,
                                height: 50,
                                decoration:BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.whit
                                ),
                                   //CustomBoxDecoration.myCustomDecoration(),
                                child: TextFormField(
                                  obscureText:seePassword ,
                               //   maxLength: 10,
                                //  keyboardType: TextInputType.number,
                                  controller: _password,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "Please Enter Password";
                                    }
                                  },
                                  decoration:  InputDecoration(

                                     suffixIcon: IconButton(  icon:  Icon(
                                       seePassword
                                           ? Icons.visibility_off
                                           : Icons.visibility,
                                       color: AppColors.primary,
                                       size: 16,
                                     ),
                                       onPressed: () {
                                         setState(() {
                                           seePassword = !seePassword;
                                         });
                                       },
                                     ),
                                      contentPadding: EdgeInsets.only(top: 17),
                                      counterText: "",
                                      hintText: "Password",
                                      prefixIcon: Icon(Icons.lock),
                                      // contentPadding: EdgeInsets.all(10),
                                      //  prefixIcon: Icon(Icons.call),
                                      border: InputBorder.none),
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                              // const SizedBox(
                              //   height: 5,
                              // ),
                              // Row(
                              //   children: [
                              //     Checkbox(
                              //       value: isEighteenPlus,
                              //       onChanged: (val) {
                              //         if (val != null) {
                              //           isEighteenPlus = val;
                              //           setState(() {});
                              //         }
                              //       },
                              //       checkColor: AppColors.primary,
                              //       activeColor: AppColors.whit,
                              //       hoverColor: AppColors.whit,
                              //       side: const BorderSide(
                              //         color: AppColors
                              //             .whit, //your desire colour here
                              //         width: 1.5,
                              //       ),
                              //     ),
                              //     const Text(
                              //       "I confirm that I am 18+ year in age",
                              //       style: TextStyle(
                              //           color: AppColors.whit, fontSize: 12),
                              //     )
                              //   ],
                              // ),

                              const SizedBox(
                                height: 32,
                              ),

                              InkWell(
                                onTap: (){
                         if (_formkey.currentState!.validate()) {
                           loginApi();
                         }
                                },
                                child: Container(
                                  height: 30,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.buttonColor

                                  ),
                                  child: Center(child: Text("Login",style: TextStyle(color: AppColors.whit),)),
                                ),
                              )
                              // Padding(
                              //   padding:
                              //       const EdgeInsets.symmetric(horizontal: 20),
                              //   child: AppButton(
                              //       title: controller.isLoading == true
                              //           ? 'please wait...'
                              //           : 'Send OTP',
                              //       onTap: () {
                              //         if (_mobile.text.isEmpty) {
                              //           Fluttertoast.showToast(
                              //               msg: "Please enter mobile number");
                              //         } else if (_mobile.text.length < 10) {
                              //           Fluttertoast.showToast(
                              //               msg:
                              //                   "Please enter correct mobile number");
                              //         } else if (!isEighteenPlus) {
                              //           Fluttertoast.showToast(
                              //               msg:
                              //                   "Please confirm that you are 18+");
                              //         } else {
                              //           // controller.sendOtp(
                              //           //     mobile: _mobile.text,
                              //           //     referral_code: _ref.text);
                              //         }
                              //       }),
                              // ),
                             ,  SizedBox(
                                height: 32,
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Padding(
                      //   padding: const EdgeInsets.only(right: 20, left: 20),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     mainAxisSize: MainAxisSize.min,
                      //     children: [
                      //
                      //       const SizedBox(
                      //         height: 60,
                      //       ),
                      //       Row(
                      //         mainAxisAlignment:
                      //         MainAxisAlignment.center,
                      //         children: [
                      //           const Text(
                      //             "Don't have an account?",
                      //             style: TextStyle(
                      //                 fontSize: 15,
                      //                 fontWeight: FontWeight.w500,
                      //                 color: AppColors.fntClr),
                      //           ),
                      //           TextButton(
                      //               onPressed: () {
                      //                 Get.toNamed(signupScreen);
                      //               },
                      //               child: const Text(
                      //                 'Sign Up',
                      //                 style: TextStyle(
                      //                     color: AppColors.secondary,
                      //                     fontSize: 15,
                      //                     fontWeight: FontWeight.bold
                      //                 ),
                      //               ))
                      //         ],
                      //       )
                      //     ],
                      //   ),
                      // )
                    ],
                  ),
                )),
          ),
    ));


  }

  loginApi()
  async {
    var headers = {
      'Cookie': 'ci_session=2561bfcd54475a7d13fa3c4e322965dc451a5033'
    };
    var request = http.MultipartRequest('POST', Uri.parse('$loginurlNew'));
    request.fields.addAll({
      'username': _email.text,
      'password': _password.text
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);

      Fluttertoast.showToast(msg: finalResult['msg']);
      print(finalResult);
      // print(await response.stream.bytesToString());
      if(finalResult['status']==true)
      {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userId', '${finalResult['data'][0]['id']}');
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
    }
    else {
      print(response.reasonPhrase);
    }

  }
}}
