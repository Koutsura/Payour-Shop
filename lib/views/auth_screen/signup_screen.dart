//import 'package:flutter/src/foundation/key.dart';
//import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:pshop_aplikasi/controllers/auth_controller.dart';

import '../../consts/consts.dart';
//import '../../consts/lists.dart';
import '../../views/widgets_common/applogo_widget.dart';
import '../../views/widgets_common/bg.widget.dart';
import '../../views/widgets_common/custom_textfield.dart';
import '../../views/widgets_common/our_button.dart';
import '../home_screen/home.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck = false;
  var controller = Get.put(AuthController());

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(children: [
          (context.screenHeight * 0.1).heightBox,
          applogoWidget(),
          10.heightBox,
          "Join the $appname".text.fontFamily(bold).white.size(18).make(),
          15.heightBox,
          Obx(
            () => Column(
              children: newMethod(context),
            )
                .box
                .white
                .rounded
                .padding(const EdgeInsets.all(16))
                .width(context.screenWidth - 70)
                .shadowSm
                .make(),
          )
        ]),
      ),
    ));
  }

  List<Widget> newMethod(BuildContext context) {
    return [
      customTextField(
          hint: nameHint,
          title: name,
          controller: nameController,
          isPass: false),
      customTextField(
          hint: emailHint,
          title: email,
          controller: emailController,
          isPass: false),
      customTextField(
          hint: passwordHint,
          title: password,
          controller: passwordController,
          isPass: true),
      customTextField(
          hint: passwordHint,
          title: retypePassword,
          controller: passwordRetypeController,
          isPass: true),
      Align(
          alignment: Alignment.centerRight,
          child: TextButton(onPressed: () {}, child: forgetPass.text.make())),
      Row(
        children: [
          Checkbox(
            activeColor: bluecolor,
            checkColor: whiteColor,
            value: isCheck,
            onChanged: (newValue) {
              setState(() {
                isCheck = newValue;
              });
            },
          ),
          10.heightBox,
          Expanded(
            child: RichText(
                text: const TextSpan(children: [
              TextSpan(
                  text: " I agree to the",
                  style: TextStyle(
                    fontFamily: regular,
                    color: fontGrey,
                  )),
              TextSpan(
                  text: termAndCond,
                  style: TextStyle(
                    fontFamily: regular,
                    color: bluecolor,
                  )),
              TextSpan(
                  text: " &",
                  style: TextStyle(
                    fontFamily: regular,
                    color: fontGrey,
                  )),
              TextSpan(
                  text: privacyPolicy,
                  style: TextStyle(
                    fontFamily: regular,
                    color: bluecolor,
                  ))
            ])),
          ),
        ],
      ),
      5.heightBox,
      controller.isloading.value
          ? const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(bluecolor),
            )
          : ourButton(
              color: isCheck == true ? bluecolor : lightGrey,
              title: signup,
              textColor: whiteColor,
              onPress: () async {
                if (isCheck != false) {
                  controller.isloading(true);
                  try {
                    await controller
                        .signupMethod(
                            context: context,
                            email: emailController.text,
                            password: passwordController.text)
                        .then((value) {
                      return controller.storeUserData(
                          email: emailController.text,
                          password: passwordController.text,
                          name: nameController.text);
                    }).then((value) {
                      VxToast.show(context, msg: loggedin);
                      Get.offAll(() => const Home());
                    });
                  } catch (e) {
                    auth.signOut();
                    VxToast.show(context, msg: e.toString());
                    controller.isloading(false);
                  }
                }
              },
            ).box.width(context.screenWidth - 50).make(),
      10.heightBox,
      RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: alreadyHaveAccount,
              style: TextStyle(fontFamily: bold, color: fontGrey),
            ),
            TextSpan(
              text: login,
              style: TextStyle(fontFamily: bold, color: bluecolor),
            )
          ],
        ),
      ).onTap(() {
        Get.back();
      }),
    ];
  }
}
