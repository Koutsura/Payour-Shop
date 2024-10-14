import 'package:firebase_auth/firebase_auth.dart';
import 'package:pshop_aplikasi/consts/consts.dart';
import 'package:pshop_aplikasi/views/auth_screen/login_screen.dart';
import 'package:pshop_aplikasi/views/widgets_common/applogo_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home_screen/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  changeScreen(){
    Future.delayed(const Duration(seconds: 3), () {
      //Get.to(()=> const LoginScreen());

      auth.authStateChanges().listen((User? user) {
        if(user ==null && mounted){
          Get.to(()=>const LoginScreen());
        }else{
          Get.to(()=>const Home());
        }
       });
    });
  }

  @override
  void initState() {
    changeScreen();
    super.initState();
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bluecolor,
      body: Center(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,child: Image.asset(icSplashBg, width:300 )),
              20.heightBox,
              applogoWidget(),
              10.heightBox, 
              appname.text.fontFamily(bold).white.make(), 
              5.heightBox, 
              appversion.text.white.make(), 
              const Spacer(), 
              credits.text.white.fontFamily(semibold).make(),
              30.heightBox,
          ],
        ),
      ),
    );
  }
}