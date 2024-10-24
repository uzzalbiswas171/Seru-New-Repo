import 'package:flutter/material.dart';

import '../CustomHttpClass/custom_http_class.dart';

class ProfileController with ChangeNotifier{


  ///   Get All package ///
  dynamic getProfile;
  getProfileProvider(
      BuildContext context,
      )async{
    getProfile= await CustomHttp().getProfileFunction(context);
    notifyListeners();
  }


  ///   Mock Test ///
  dynamic MockTest;
  getMockTestProvider(
      BuildContext context,
      )async{
    MockTest= await CustomHttp().getAllMockTestFunction(context);
    notifyListeners();
  }


  ///   Mock Test ///
  dynamic MySubscription;
  getMySubscriptionProvider(
      BuildContext context,
      )async{
    MySubscription= await CustomHttp().getAllMySubscriptionFunction(context);
    notifyListeners();
  }
  ///   Mock id wise moc test question list get ///
  dynamic MOCID_WISE_QUESTION_LIST_GET;
  getMyMOCID_WISE_QUESTION_LIST_GETProvider(
      BuildContext context,String id
      )async{
    MOCID_WISE_QUESTION_LIST_GET= await CustomHttp().getAllMyMOCID_WISE_QUESTION_LIST_GETFunction(context,id);
    notifyListeners();
  }

  ///  All_MyMARK_RESULT_LIST_GET  ///
  dynamic All_MyMARK_RESULT_LIST_GET;
  getMygetAllMyMARKRESULTProvider(
      BuildContext context
      )async{
    All_MyMARK_RESULT_LIST_GET= await CustomHttp().get_AllMy_MARK_RESULT_function(context);
    notifyListeners();
  }

  ///  All_MyMARK_RESULT_LIST_GET_HISTORY  ///
  dynamic All_MyMARK_RESULT_LIST_HISTORY_GET;
  get_All_My_MARK_RESULT_HISTORYProvider(
      BuildContext context, String question_set
      )async{
    All_MyMARK_RESULT_LIST_HISTORY_GET= await CustomHttp().get_AllMy_MARK_RESULT_HISTORY_function(context,question_set);
    notifyListeners();
  }

  ///  getAll vdeo class lst  ///
  dynamic GETVDOECLASSlst;
  GETVDOECLASSlstProvder(
      BuildContext context
      )async{
    GETVDOECLASSlst= await CustomHttp().GETVDOECLASSlsthttpFuncton(context);
    notifyListeners();
  }



}