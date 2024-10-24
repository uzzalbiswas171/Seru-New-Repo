


import 'dart:convert';

import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:seru_test_project/View/Auth/Login/screens/login_screen.dart';
import 'package:seru_test_project/View/RegistrationForBuyScreen/stripe_payment.dart';
import 'package:seru_test_project/custom_const.dart';
import 'package:url_launcher/url_launcher.dart';

import '../CustomWidget/CustomText/custom_text.dart';
import '../Routes/routes.dart';
import '../View/BootomBar/bootombar.dart';

class CustomHttp{



  ///  Login ------------------------------------------
  loginCustomHttpRequest(String email,String pass,String phoneid,BuildContext context)async{

    var response = await http.post(
      Uri.parse("${BASEURL}${LOGIN}"),
      body: {
        'email': "$email",
        'password': "$pass",
        'phone_id': "$phoneid",
      },
    );
    print('Responsesssssssssssssssssssssssssssssss :${response.body}');
    if (response.statusCode == 200) {
      var r =  jsonDecode(response.body)["data"];
      GetStorage().write("Api_token",r["api_token"]);
      GetStorage().write("loginemail",r["email"]);
      Navigator.push(context, MaterialPageRoute(builder: (context) => BttotomBarScreen(index: 0,),));
      quickAlertsuccess(context, "Login Successful", "Thank you", 2);
    }else{
      quickAlertWrong(context, "Invalid User or Password", "Try again later", 2);
    }
  }


  ///  registrationCustomHttpRequest ------------------------------------------
  registrationCustomHttpRequest(
      String name,
      String surname,
      String email,
      String password,
      String address,
      String currentworking,
      String qualification,
      String qualification_other,
      String phone_id,
      BuildContext context

      )async{

    var response = await http.post(
      Uri.parse("${BASEURL}${REGISTRATION}"),
      body: {
        'name': "$name",
        'surname': "surname",
        'email': "$email",
        'password': "$password",
        'password_confirmation': "$password",
        'address': "address",
        'currentworking': "currentworking",
        'currentworking_other': "currentworking_other",
        'qualification': "qualification",
        'qualification_other': "qualification_other",
        'phone_id': "$phone_id",
      },
    );
    print('Responsesssssssssssssssssssssssssssssss :${response.body}');
    if (response.statusCode == 200) {
      var r =  jsonDecode(response.body)["data"];
   GetStorage().write("Api_token",r["api_token"]);
   Navigator.push(context, MaterialPageRoute(builder: (context) => BttotomBarScreen(index: 0,),));
      quickAlertsuccess(context, "Registration Successful", "Thanks for Registration", 2);
 //  Navigator.push(context, MaterialPageRoute(builder: (context) =>LoginScreen(),));
    }else{
      quickAlertWrong(context, "Your email is invalid", "Please correct email and try again later", 2);
    }
  }





 /// Custom Header  --------------------------------------------------
  Map<String, String> headers= <String,String>{
    "accept": "application/json",
 //   'Authorization': 'Bearer ${GetStorage().read("Api_token")}'
  };



  /// Get All Package-------------------------------
  ///Get All hub list
  List getAllPackageList=[];
  getAllPackageFunction(BuildContext context)async{
    String url="${BASEURL}${GETALLPACKAGRE}";

    try{
      Response response=await http.get(Uri.parse(url), );
      final data=jsonDecode(response.body);
      for(int i=0;i<data["data"].length;i++){
        if("${data["data"][i]["active_ststus"]}" == "Yes"){
          getAllPackageList.add(data["data"][i]);
        }
      }
   // getAllPackageList=data["data"];

    }catch(e){
      print("getAllPackageFunction catch error-----------------------------------------> $e");
    }
    return getAllPackageList;
  }


  ///Get Profile------------------------------------------------------------------------
  dynamic getProfile;
  getProfileFunction(BuildContext context)async{
    String url="${BASEURL}${PROFILE}?api_token=${GetStorage().read("Api_token")}";

    try{
      Response response=await http.get(Uri.parse(url), );
      final data=jsonDecode(response.body);
      getProfile=data["data"];

    }catch(e){
      print("getProfileFunction catch error-----------------------------------------> $e");
    }
    return getProfile;
  }



  /// Get MOCK TEST-------------------------------
  List getAllMockTestList=[];
  getAllMockTestFunction(BuildContext context)async{
    String url="${BASEURL}${MOCKTEST}?api_token=${GetStorage().read("Api_token")}";
    try{
      Response response=await http.get(Uri.parse(url), );
      final data=jsonDecode(response.body);
      getAllMockTestList=data["data"];

    }catch(e){
      print("getAllMockTestFunction catch error--- > $e");
    }
    return getAllMockTestList;
  }



  /// MY SUBSCRIPTION-------------------------------
  List getAllMySubscriptionList=[];
  getAllMySubscriptionFunction(BuildContext context)async{
    String url="${BASEURL}${MYSUBSCRIPTION}?api_token=${GetStorage().read("Api_token")}";
    try{
      Response response=await http.get(Uri.parse(url), );
      final data=jsonDecode(response.body);
      getAllMySubscriptionList=data["data"];
    //  print("My subscription----------------------------------------------- $getAllMySubscriptionList");
    }catch(e){
      print("getAllMySubscriptionList catch error > $e");
    }
    return getAllMySubscriptionList;
  }



  ///   Mock id wise moc test question list get-------------------------------
  List getAllMyMOCID_WISE_QUESTION_LIST_GET=[];
  getAllMyMOCID_WISE_QUESTION_LIST_GETFunction(BuildContext context, String id)async{
    String url="${BASEURL}${MOCID_WISE_QUESTION_LIST_GET}$id?api_token=${GetStorage().read("Api_token")}";
    try{
      Response response=await http.get(Uri.parse(url), );
      final data=jsonDecode(response.body);
      getAllMyMOCID_WISE_QUESTION_LIST_GET=data["data"];

    }catch(e){
      print("getAllMyMOCID_WISE_QUESTION_LIST_GET catch error > $e");
    }
    return getAllMyMOCID_WISE_QUESTION_LIST_GET;
  }
  ///  All_MyMARK_RESULT_LIST_GET list get-------------------------------
  List getAllMy_MARKRESULTList=[];
  get_AllMy_MARK_RESULT_function(BuildContext context )async{

    print( "nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn${GetStorage().read("Api_token")}");


    String url="${BASEURL}${MARKRESULT}?api_token=${GetStorage().read("Api_token")}";
    try{
      Response response=await http.get(Uri.parse(url), headers: headers);
      final data=jsonDecode(response.body);
      getAllMy_MARKRESULTList=data["data"];

    }catch(e){
      print("getAllMy_MARKRESULTList catch error > $e");
    }
    return getAllMy_MARKRESULTList;
  }

  ///  All_MyMARK_RESULT_LIST_GET list History  get-------------------------------
  List getAllMy_MARKRESULT_HistoryList=[];
  get_AllMy_MARK_RESULT_HISTORY_function(BuildContext context,String question_set)async{
    String url="${BASEURL}${MARKRESULT_HISTORY}/$question_set?api_token=${GetStorage().read("Api_token")}";
    try{
      Response response=await http.get(Uri.parse(url), headers: headers);
      final data=jsonDecode(response.body);
      getAllMy_MARKRESULT_HistoryList=data["data"];

    }catch(e){
      print("getAllMy_MARKRESULT_HistoryList catch error > $e");
    }
    return getAllMy_MARKRESULT_HistoryList;
  }


  ///  Answer Submit Provider CustomHtt pRequest list History  get-------------------------------
  List AnswerSubmitProviderCustomHttpRequestList=[];
  AnswerSubmitProviderCustomHttpRequest(
      BuildContext context, String mocktest_id, String mocktest_question_id, String answer, String question_set,
      )async{
    try{
      var response = await http.post(
        Uri.parse("https://www.tflserutest.co.uk/api/protected/answer?api_token=${GetStorage().read("Api_token")}"),
        body: {
          'mocktest_id': "$mocktest_id",
          'mocktest_question_id': "$mocktest_question_id",
          'answer': "$answer",
          'question_set': "$question_set",
        },
      );
      final data=jsonDecode(response.body);
     print(data);
    }catch(e){
      print("Answer Submit Provider Custom Http Request List catch error > $e");
    }
    return AnswerSubmitProviderCustomHttpRequestList;
  }


  ///  Buy Package Without Voucher-------------------------------
  dynamic buyPackageWithoutVouche;
  buyPackageWithoutVoucherHttpFunction(
      BuildContext context,
      int package_id,
      int subscription_structure_id,
      String voucher_gift,
      String friend_relative_email,
      String name,
      String surname,
      String address,
      String address_2,
      String city,
      String country,
      String postal_code,
      String personal_email,
      String date_for_physical,
      )async{
    try{
      var response = await http.post(
        Uri.parse("https://www.tflserutest.co.uk/api/protected/buy-package?api_token=${GetStorage().read("Api_token")}"),
        body: { 
      "subscription_structure_id":"$subscription_structure_id",
      "voucher_gift":"${voucher_gift}",
      "friend_relative_email":"$friend_relative_email",
      "name":"$name",
      "surname" : "$surname",
      "address":"$address",
      "address_2":"$address_2",
      "city"	:"$city",
      "country":"$country",
      "postal_code":"${postal_code}",
      "email"	:"${personal_email}",
      "date_for_physical"	:"${date_for_physical}"



      // "package_id" : int.parse("$package_id"),
      // "subscription_structure_id":int.parse("$subscription_structure_id"),
      // "voucher_gift":"${voucher_gift}",
      // "friend_relative_email":"$friend_relative_email",
      // "name":"$name",
      // "surname":"$surname",
      // "address":"$address",
      // "address_2":"$address_2",
      // "city":"$city",
      // date_for_physical:

        },
      );
      var data=jsonDecode(response.body);
      print("bhyyyyyyyyyyyyyyyyyyyyyyyeeeeeeeeeeeeeeeeeee ${response.body}");
      buyPackageWithoutVouche=data;
         print("pppppppppppppppppppppppppppppppppppppppppppp buyyyyyyyyyyyyyyyyyyyyyyy apiiiiiiiiiiiiiii  ${data.toString().replaceAll("}","").split("pay_url: ")[1]}");
       Navigator.push(context, MaterialPageRoute(builder: (context) => StripePaymentScreen(
          pay_url: "${data.toString().replaceAll("}","").split("pay_url: ")[1]}",
       ),));
   //   _launchURL("${data.toString().replaceAll("}","").split("pay_url: ")[1]}");
   
    }catch(e){
      print("Pacage buy screen catch error > $e");
    }
    showDialog(context: context, builder: (context) {
      Future.delayed(Duration(seconds: 2),() {
        Navigator.pop(context);
      },);
   return   AlertDialog(
        content: Container(
          height: 200,
          width: 200,
          child:Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("assets/Gif/carmoving.gif",height: 100,width: 100,),
                CustomText(text: "Loading...", fontSize: 22, fontWeight: FontWeight.w700,fontStyle:FontStyle.italic ,)
              ],
            ),
          ),
        ),
      );
    },);
  }
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }}


  ///   Voucher- apply ------------------------------
  dynamic VoucheApply;
  VoucheApplyHttpFunction(
      BuildContext context,
      String voucher_code_id,
      String date_for_physical,
      )async{
    try{
      var response = await http.post(
        Uri.parse("https://www.tflserutest.co.uk/api/protected/buy-package?api_token=${GetStorage().read("Api_token")}"),
        body: {
          "voucher_code_id":"$voucher_code_id",
          "date_for_physical"	:"${date_for_physical}"
        },
      );
      var data=jsonDecode(response.body);
      ElegantNotification(
        borderRadius: BorderRadius.circular(11),
        width: 380,
        iconSize: 25,
        background: Colors.green,
        progressIndicatorBackground: Colors.green,
        progressIndicatorColor: Colors.red,
        // position: Alignment.center,
        title:   CustomText(fontSize: 16, fontWeight: FontWeight.w500, text: "Invalid Code",  ),
        description:  CustomText(fontSize: 14, fontWeight: FontWeight.w400, text: "Please Enter Right Code",     ),
        onDismiss: () {
          print('Message when the notification is dismissed');
        }, icon: Icon(Icons.info_outlined,color:Colors.black,),
      ).show(context);
      VoucheApply=data;
      print(" pppppppppppppppppppppp   $VoucheApply");


    }catch(e){
      print("Pacage buy screen catch error > $e");
    }
  }


  /// get all vdeo
  List GETVDOECLASSlst = [];
  GETVDOECLASSlsthttpFuncton(BuildContext context )async{
    String url="${BASEURL}${GETVDOECLASS}";
    try{
      Response response=await http.get(Uri.parse(url), headers: headers);
      final data=jsonDecode(response.body);
      GETVDOECLASSlst=data;

    }catch(e){
      print("GET VDOE CLASS lst catch error > $e");
    }
    return GETVDOECLASSlst;
  }



}

