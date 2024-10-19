import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seru_test_project/Controller/profile_controller.dart';
import 'package:seru_test_project/CustomWidget/CustomAppbar/custom_appbar.dart';
import 'package:seru_test_project/View/BootomBar/ProfileScreen/VideoClassScreen/VideoListScreen/video_list_screen.dart';
import 'package:seru_test_project/View/BootomBar/bootombar.dart';
import 'package:video_player/video_player.dart';

import '../../../../CustomWidget/CustomText/custom_text.dart';
import '../../../../custom_const.dart';

class VdeoClassLst extends StatefulWidget {
  const VdeoClassLst({super.key});

  @override
  State<VdeoClassLst> createState() => _VdeoClassLstState();
}

class _VdeoClassLstState extends State<VdeoClassLst> {
  @override
  void initState() {
    Provider.of<ProfileController>(context,listen: false).GETVDOECLASSlstProvder(context);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future(() => false),
      child: Scaffold(
        appBar: PreferredSize(preferredSize:Size.fromHeight(60), child: CustomAppbar()),
        floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back,size: 30,color: BootomBarColor),
          onPressed: () => Navigator.push(context,MaterialPageRoute(builder: (context) => BttotomBarScreen(index: 2,),)),),
        body:   Consumer<ProfileController>(
          builder: (context, value, child)=> Container(
            padding: EdgeInsets.only(left: 10,right: 10,top: 10),
            height: double.infinity,
            width: double.infinity,
            child: GridView.builder(
              itemCount:value.GETVDOECLASSlst==null?0: value.GETVDOECLASSlst.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => VideoPlayerScreen(url: "${value.GETVDOECLASSlst[index]}"),));
                },
                child: Card(
                    elevation: 0.8,
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:AssetImage("assets/Icons/videoicon.png"),fit: BoxFit.cover)
                            ),
                          ),
                        ),
                        CustomText(text: "Class ${index+1}", fontSize: 18, fontWeight: FontWeight.w500)
                      ],
                    )
                 
                ),
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),),
          ),
        )
      
      ),
    );
  }
}
