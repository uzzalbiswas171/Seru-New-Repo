import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';
import 'package:seru_test_project/Controller/homeController.dart';
import 'package:seru_test_project/Controller/profile_controller.dart';
import 'package:seru_test_project/CustomWidget/CalosolSelalider/carosal_silaider.dart';
import 'package:seru_test_project/CustomWidget/CustomAppbar/custom_appbar.dart';
import 'package:seru_test_project/CustomWidget/CustomApplySection/custom_apply_section.dart';
import 'package:seru_test_project/CustomWidget/CustomCompany/costom_company_info.dart';
import 'package:seru_test_project/CustomWidget/CustomImageScetion/custom_image_section.dart';
import 'package:seru_test_project/CustomWidget/CustomText/custom_text.dart';
import 'package:seru_test_project/CustomWidget/SelectionOptions/selection_option.dart';
import 'package:seru_test_project/View/BootomBar/bootombar.dart';
import 'package:seru_test_project/View/RegistrationForBuyScreen/registration_for_buy_screen.dart';
import 'package:seru_test_project/View/apple_pay_gpay_screen.dart';
import '../../../Controller/buy_package_controller.dart';
import '../../../custom_const.dart';
import '../../Auth/Login/screens/login_screen.dart';
import '/payment_configurations.dart' as payment_configurations;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _applyCuponController = TextEditingController();
  late final Future<PaymentConfiguration> _googlePayConfigFuture;

  @override
  void initState() {
    Provider.of<HomeController>(context, listen: false)
        .getAllPackageProvider(context);
    super.initState();
    _googlePayConfigFuture = PaymentConfiguration.fromAsset('gpay.json');
  }

  void onGooglePayResult(paymentResult) {
    debugPrint(paymentResult.toString());
  }

  void onApplePayResult(paymentResult) {
    debugPrint(paymentResult.toString());
  }

  List carosal = [
    "assets/SeruTestBanner/seru_banner.jpg",
    "assets/SeruTestBanner/seru_banner.jpg",
    "assets/SeruTestBanner/seru_banner.jpg",
  ];

  bool is_cliced = false;
  String is_cliced_for_own = "1";
  List getAllActivePackageList = [];

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    //  final getAllPackageList=Provider.of<HomeController>(context).getAllPackageList;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60), child: CustomAppbar()),
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(
            Duration(seconds: 2),
            () {},
          );
        },
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: Stack(
                    children: [
                      Container(
                        height: h * 0.025 + 30,
                        decoration: BoxDecoration(),
                        child: Column(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(11),
                                        bottomRight: Radius.circular(11)),
                                    gradient: customBackground(),
                                  ),
                                )),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  color: Colors.white,
                                )),
                          ],
                        ),
                      ),

                      Positioned(
                          bottom: 0,
                          child: Container(
                            color: Colors.white.withOpacity(0.0),
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: CustomApplyVaucherSection(
                              applyCuponController: _applyCuponController,
                              onTap: () {
                                Provider.of<BuyPackageController>(context,
                                        listen: false)
                                    .vautureapplyprovider(
                                        context,
                                        "${_applyCuponController.text}",
                                        "${DateFormat("yyyy-MM-dd").format(DateTime.now())}");
                              },
                            ),
                          ))

                      /// Apply Sections
                    ],
                  ),
                ),
                SizedBox(
                  height: h * 0.025,
                ),

                /// Slide Company Banner
                CalosolSelalider(
                  custom_height: 130,
                  carousal_list: carosal,
                  carousal_onTab: () {},
                ),
                SizedBox(
                  height: h * 0.025,
                ),

                /// Select Options
                SelectionOptionsScreen(
                  leftText: "Select Your Package",
                  rite_text: "View all",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BttotomBarScreen(index: 1),
                        ));
                  },
                ),
                SizedBox(
                  height: h * 0.010,
                ),
                Consumer<HomeController>(
                  builder: (context, value, child) => Container(
                    padding: const EdgeInsets.all(10.0),
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: value.getAllPackageList == null
                          ? 0
                          : value.getAllPackageList.length,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          mainAxisExtent: 155),
                      itemBuilder: (context, index) {
                        return Card(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            //   color: listColors[index % listColors.length],
                               color: defaultBackgroundColor
                            ),
                            height: 70,
                            padding: const EdgeInsets.only(left: 8.0,right: 8,top: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                Center(
                                  child: CustomText(maxLines: 1, text: " ${value.getAllPackageList[index]["title"] ?? "0"}",
                                      fontSize: 14, fontWeight: FontWeight.w500),
                                ),
                                CustomText(maxLines: 1, text: "Details : ${value.getAllPackageList[index]["subscription_structures"][0]['access_keywords'] ?? ""}",
                                    fontSize: 13, fontWeight: FontWeight.w500,overflow: TextOverflow.ellipsis,),

                                CustomText(
                                    text: "Price : \£ ${value.getAllPackageList[index]["amount"] ?? value.getAllPackageList[index]["price"]}",
                                    text_color: main_text_blac_color,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),

                                // SizedBox(height: 5,),
                                InkWell(
                                  onTap: () {
                                    "${GetStorage().read("Api_token")}" == "" ||
                                            "${GetStorage().read("Api_token")}" ==
                                                "null"
                                        ? Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),))
                                        : showDialog(context: context, builder: (context) {
                                              return StatefulBuilder(
                                                builder: (context, setState) {
                                                  return AlertDialog(
                                                    title: CustomText(
                                                        text: " ${value.getAllPackageList[index]["title"] ?? "0"}",
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.w600),
                                                    content: Container(
                                                      height: is_cliced == true ? 240 : 90,
                                                      child: SingleChildScrollView(
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [

                                                            Container(
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(11),
                                                                border: Border.all(width: 1.5,color: Main_Theme_blac.withOpacity(0.2))
                                                              ),
                                                              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                                              child: CustomText(text: "${value.getAllPackageList[index]["subscription_structures"][0]['access_keywords'] ?? ""}", fontSize: 13, fontWeight: FontWeight.w400),
                                                            ),

                                                            Container(
                                                              height: 60,
                                                              width: MediaQuery.of(context).size.width * 0.85,
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                children: [
                                                                  ElevatedButton(
                                                                      style: ElevatedButton.styleFrom(
                                                                          backgroundColor: is_cliced_for_own == "FOR GIFT" ? BootomBarColor : Colors.white),
                                                                      onPressed: () {
                                                                        setState(() {
                                                                            is_cliced_for_own = "FOR GIFT";
                                                                            is_cliced = true;
                                                                          },
                                                                        );
                                                                      },
                                                                      child: CustomText(
                                                                          text: "FOR GIFT", fontSize: h < 700 ? 10 : 12,
                                                                          fontWeight: FontWeight.w500)),
                                                                  ElevatedButton(
                                                                      style: ElevatedButton.styleFrom(
                                                                          backgroundColor: is_cliced_for_own =="FOR OWN"? BootomBarColor: Colors.white),
                                                                      onPressed:() {
                                                                            setState(() {is_cliced_for_own ="FOR OWN";is_cliced =true;},
                                                                        );
                                                                      },
                                                                      child: CustomText(
                                                                          text: "FOR OWN",
                                                                          fontSize: h <  700 ? 10 : 12,
                                                                          fontWeight:FontWeight.w500)),
                                                                ],
                                                              ),
                                                            ),
                                                            is_cliced == false
                                                                ? Container(): SizedBox( height: 10,),
                                                            is_cliced == false
                                                                ? Container()
                                                                : Container(
                                                                    height: 47,
                                                                    width: MediaQuery.of(context).size.width * 0.8,
                                                                    child: GestureDetector(
                                                                        onTap:() {
                                                                          Navigator.push(context,MaterialPageRoute(builder: (context) => RegistrationForBuyScreen(
                                                                                  package_id: "${value.getAllPackageList[index]["subscription_structure_id"] ?? "0"}",
                                                                                  subscription_structure_id: "${value.getAllPackageList[index]["subscription_structures"][0]["subscription_structure_id"] ?? "0"}",
                                                                                  is_cliced_for_own: is_cliced_for_own,
                                                                                ),
                                                                              ));
                                                                        },
                                                                        child:  Container( 
                                                                          height:47,
                                                                          width: 235,
                                                                          decoration:BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(40),
                                                                            color: Colors.black,
                                                                          ),
                                                                          padding: EdgeInsets.only(left: 30, right: 20),
                                                                          child: Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Text(
                                                                                "Buy with ",
                                                                                style: GoogleFonts.roboto(letterSpacing: 0.3, fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white.withOpacity(0.95)),
                                                                              ),
                                                                              CustomImageSection(image: AssetImage("assets/PymentImage/mastercad.PNG"), img_height: 90, img_width: 50, img_margin: 10, Img_radius: 11),
                                                                            ],
                                                                          ),
                                                                        )),
                                                                  ),
                                                            FutureBuilder<PaymentConfiguration>(
                                                                future: _googlePayConfigFuture,
                                                                builder: (context, snapshot) => snapshot.hasData ? GooglePayButton(
                                                                            width: MediaQuery.of(context).size.width * 0.8,
                                                                            paymentConfiguration: snapshot.data!,
                                                                            paymentItems: _paymentItems,
                                                                            type: GooglePayButtonType.buy,
                                                                            margin: const EdgeInsets.only(top: 15.0),
                                                                            onPaymentResult: onGooglePayResult,
                                                                            loadingIndicator: const Center(
                                                                              child: CircularProgressIndicator(),
                                                                            ),
                                                                          )
                                                                        : const SizedBox
                                                                            .shrink()),
                                                            ApplePayButton(
                                                              paymentConfiguration:PaymentConfiguration.fromJsonString(payment_configurations.defaultApplePay),
                                                              paymentItems:_paymentItems,
                                                              style: ApplePayButtonStyle.black,
                                                              type: ApplePayButtonType.buy,
                                                              margin: const EdgeInsets.only(top: 15.0),
                                                              onPaymentResult: onApplePayResult,
                                                              loadingIndicator: const Center(child: CircularProgressIndicator(),),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          );
                                  },
                                  child: Card(
                                    elevation: 2,
                                    child: Container(
                                      height: 26,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        gradient: customBackground(),
                                      ),
                                      alignment: Alignment.center,
                                      child: CustomText(
                                        text: "Buy Now",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        text_color: Main_Theme_white,
                                      ),
                                    ),
                                  ),
                                ),
                                // Image.asset("assets/Gif/buynow.webp",height: 40,width: 100,fit: BoxFit.fill,)
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                /// Slide Add
                CalosolSelalider(
                  custom_height: 100,
                  carousal_list: carosal,
                  carousal_onTab: () {},
                ),
                SizedBox(
                  height: h * 0.010,
                ),

                /// Company Information
                CustomInfoScreen(),

                /// Company Payment way
                Container(
                  height: 50,
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListView.builder(
                    itemCount: imageList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Image.asset(
                          "${imageList[index]}",
                          height: 40,
                          width: 100,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 90,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List imageList = [
    "assets/PymentImage/applepay.jpg",
    "assets/PymentImage/gpay.PNG",
    "assets/PymentImage/mastercad.PNG",
    "assets/PymentImage/mestro.PNG",
    "assets/PymentImage/payple.PNG",
    "assets/PymentImage/stripe.PNG",
    "assets/PymentImage/visa.PNG",
    "assets/PymentImage/visaElectron.PNG",
  ];
}

const _paymentItems = [
  PaymentItem(
    label: 'Total',
    amount: '.09',
    status: PaymentItemStatus.final_price,
  )
];
