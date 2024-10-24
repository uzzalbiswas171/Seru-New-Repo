
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:seru_test_project/Controller/buy_package_controller.dart';
import 'package:seru_test_project/View/SplashScreens/splash_screen3.dart';
import 'package:seru_test_project/testmcq.dart';
import 'Controller/answerSubmitController.dart';
import 'Controller/homeController.dart';
import 'Controller/loginController.dart';
import 'Controller/profile_controller.dart';
import 'Controller/registrationController.dart';
import 'View/BootomBar/PackageScreen/ShowPaymentOptionScreen/show_payment_option_screen.dart';
import 'View/BootomBar/ProfileScreen/ExamResultScreen/IndividualResult/individual_result.dart';
import 'View/BootomBar/ProfileScreen/VideoClassScreen/video_class_screen.dart';
import 'View/BootomBar/bootombar.dart';
import 'View/SplashScreens/main_splash_pageview_screen.dart';
import '/payment_configurations.dart' as payment_configurations;
import 'package:flutter_localizations/flutter_localizations.dart';
// void main() {
//   HttpOverrides.global = MyHttpOverrides();
//   runApp(const MyApp());
// }
//
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main()async {
  HttpOverrides.global = MyHttpOverrides();
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<HomeController>(create: (context) => HomeController(),),
      ChangeNotifierProvider<ProfileController>(create: (context) => ProfileController(),),
      ChangeNotifierProvider<LoginController>(create: (context) => LoginController(),),
      ChangeNotifierProvider<RegistrationController>(create: (context) => RegistrationController(),),
      ChangeNotifierProvider<AnswerSubmitController>(create: (context) => AnswerSubmitController(),), 
      ChangeNotifierProvider<BuyPackageController>(create: (context) => BuyPackageController(),),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      localizationsDelegates: [
        ...GlobalMaterialLocalizations.delegates,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''),
        Locale('es', ''),
        Locale('de', ''),
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      /// Main Route --------------------------
      //  home:ShowPaymentOptionScreen(),
  home:SplashScreen3(),
      // home:FillInTheBlanksWidget(),
     // home:VdeoClassLst(),
      //   home:IndividualResultScreen(),
      /// Working route -----------------------
      // home:BttotomBarScreen(index: 0,),
      ),
    );
  }
}
