import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:seru_test_project/Controller/profile_controller.dart';
import 'package:seru_test_project/CustomWidget/CustomText/custom_text.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../CustomWidget/CustomAppbar/custom_individual_appbar.dart';
import '../../../../CustomWidget/CustomImageScetion/custom_image_section.dart';
import '../../../../custom_const.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  bool  is_cliced=false;
  bool  is_cliced_for_own=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(75), child: CustomIndividualAppbar(onPress: () {
        Navigator.pop(context);
      }, title: "My Subscription")),
      body: Consumer<ProfileController>(
        builder: (context, value, child) {
          print("ffffffffffffffffffffffffff ${value.MySubscription}");
          return "${value.MySubscription}"=="null" ?
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("assets/Gif/carmoving.gif",height: 100,width: 100,),
                CustomText(text: "Loading...", fontSize: 22, fontWeight: FontWeight.w700,fontStyle:FontStyle.italic ,)
              ],
            ),
          )
              :"${value.MySubscription}"=="[]" ?
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("assets/Gif/carmoving.gif",height: 100,width: 100,),
                CustomText(text: "You don't have subscription", fontSize: 22, fontWeight: FontWeight.w700,fontStyle:FontStyle.italic ,)
              ],
            ),
          )
          :
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: customBackground()
            ),
            child:  Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: value.MySubscription.length,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      mainAxisExtent: 190
                  ), itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {

                    },
                    child: Card(
                      elevation: 2,
                      child: Container(
                        height: 100,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.white.withOpacity(0.5),
                          //     spreadRadius: 5,
                          //     blurRadius: 7,
                          //     offset: Offset(0, 3), // changes position of shadow
                          //   ),
                          // ],
                          borderRadius: BorderRadius.circular(10)
                          // ,color: Main_Theme_Color,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child:  Container(
                                height: 30,
                                width: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Main_Theme_blac.withOpacity(0.8)
                                ),
                                alignment: Alignment.center,
                                child: CustomText(text: "\£ ${value.MySubscription[index]["amount"]}",text_color: main_text_white_color ,fontSize: 17, fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(height: 5,),
                            CustomText(text: "Voucher Code", fontSize: 14, fontWeight: FontWeight.w500)
                            ,
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Divider(height:10 ,),
                            ),
                            CustomText(text: "${value.MySubscription[index]["voucher_code_id"]}", fontSize: 16, fontWeight: FontWeight.w500)
                            ,
                            SizedBox(height: 5,),
                        Center(
                          child: Container(
                              width: 230,
                              height: 40,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(45),
                                  border: Border.all(color: Main_Theme_textColor.withOpacity(0.2))),
                              child:  Row(
                                children: [
                                  Spacer(),
                                  InkWell(
                                    onTap: () {
                                   //   Share.share('${value.MySubscription[index]["voucher_code_id"]}');
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: Duration(seconds: 1),content: Text("Copped ${value.MySubscription[index]["voucher_code_id"]}")));
                                      Clipboard.setData(new ClipboardData(text: "${value.MySubscription[index]["voucher_code_id"]}"));
                                    },
                                    child: Row(
                                      children: [
                                        Icon(Icons.copy,size: 20,color: Main_Theme_blac.withOpacity(0.7),),
                                        SizedBox(width: 7,),
                                        CustomText(fontSize: 12, fontWeight: FontWeight.w500, text: "Copy",  ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Container(height: 25,width: 1.5,color: Main_Theme_textColor.withOpacity(0.2),),
                                  Spacer(),
                                  InkWell(
                                    onTap:() {
                                      Share.share('${value.MySubscription[index]["voucher_code_id"]}');
                                    },
                                    child: Row(
                                      children: [
                                        Icon(Icons.share,size: 20,color: Main_Theme_blac.withOpacity(0.7),),
                                        SizedBox(width: 5,),
                                        CustomText(fontSize: 12, fontWeight: FontWeight.w500, text: "Share",),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                ],
                              )
                          ),
                        ),
                            SizedBox(height: 5,),
                            // Image.asset("assets/Gif/buynow.webp",height: 40,width: 100,fit: BoxFit.fill,)
                          ],
                        ),
                      ),
                    ),
                  );
                },),
              ),
            ),
          );
        },

      ),
    );
  }
}
