import 'package:flutter/services.dart';
import 'package:pshop_aplikasi/consts/consts.dart';
import 'package:pshop_aplikasi/views/widgets_common/our_button.dart';

Widget exitDialog(context){
  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius:  BorderRadius.circular(12),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Confirm".text.fontFamily(bold).size(18).color(darkFontGrey).make(),
        const Divider(),
        10.heightBox,
        "Are you sure you want to exit?".text.size(16).color(darkFontGrey).make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ourButton(color : bluecolor,onPress: (){
              SystemNavigator.pop();
            },textColor: whiteColor,title: "Yes"),
            ourButton(color : bluecolor,onPress: (){
              Navigator.pop(context);
            },textColor: whiteColor,title: "No"),
          ],
        ),
      ],
    ).box.color(lightGrey).padding(const EdgeInsets.all(12)).rounded.make(),
  );
}