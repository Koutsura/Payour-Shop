import 'package:pshop_aplikasi/consts/consts.dart';
import 'package:pshop_aplikasi/consts/lists.dart';
import 'package:pshop_aplikasi/controllers/auth_controller.dart';
import 'package:pshop_aplikasi/views/auth_screen/signup_screen.dart';
import 'package:pshop_aplikasi/views/home_screen/home.dart';
import 'package:pshop_aplikasi/views/widgets_common/applogo_widget.dart';
import 'package:pshop_aplikasi/views/widgets_common/bg.widget.dart';
import 'package:pshop_aplikasi/views/widgets_common/custom_textfield.dart';
import 'package:pshop_aplikasi/views/widgets_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(AuthController());

    return bgWidget(child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(children: [(context.screenHeight * 0.1).heightBox, applogoWidget(),
        10.heightBox,
        "Log in to $appname".text.fontFamily(bold).white.size(18).make(),
        15.heightBox,
        Obx(()=>
           Column(
            children: [
              customTextField(hint: emailHint,title: email,isPass: false,controller: controller.emailController),
              customTextField(hint: passwordHint,title: password,isPass: true,controller : controller.passwordController),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(onPressed: (){}, child: forgetPass.text.make())),
                5.heightBox,
                controller.isloading.value ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(bluecolor),
                ): ourButton(color: bluecolor, 
                title: login,
                 textColor: whiteColor,
                 onPress: () async{
                  controller.isloading(true);

                  await controller.loginMethod(context: context).then((value){
                    if(value !=null){
                      VxToast.show(context, msg: loggedin);
                      Get.offAll(()=>const Home());
                    } else {
                      controller.isloading(false);
                    }
                  });
                  
                })
                .box.
                width(context.screenWidth - 50)
                .make(),
                5.heightBox,
                createNewAccount.text.color(fontGrey).make(),
                5.heightBox,
                ourButton(color: lightBlue, title: signup, textColor: bluecolor,
                onPress: (){
                  Get.to(()=> const SignupScreen());
                })
                .box.
                width(context.screenWidth - 50)
                .make(),
        
                10.heightBox,
                loginwith.text.color(fontGrey).make(),
                5.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, 
                  (index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                    backgroundColor: lightGrey,
                    radius: 25,
                    child: Image.asset
                    (socialIconList[index],
                    width: 30,
                    ),
                    ),
                  )),
                ) 
            ],
          ).box.white.rounded.padding(const EdgeInsets.all(16)).width(context.screenWidth -70).shadowSm.make(),
        )]),
      ),
    ));
  }
}