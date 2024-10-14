import 'package:get/get.dart';
import 'package:pshop_aplikasi/consts/consts.dart';
import 'package:pshop_aplikasi/controllers/cart_controller.dart';
import 'package:pshop_aplikasi/views/cart_screen/payment_method.dart';
import 'package:pshop_aplikasi/views/widgets_common/custom_textfield.dart';
import 'package:pshop_aplikasi/views/widgets_common/our_button.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Pengirim yang akan diantarkan"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButton(
          onPress: () {
            if (controller.addressController.text.length > 10) {
              Get.to(() => const PaymentMethods());
            } else {
              VxToast.show(context, msg: "Isilah formulir dengan benar");
            }
          },
          color: bluecolor,
          textColor: whiteColor,
          title: "Continue",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            customTextField(
                hint: "Alamat",
                isPass: false,
                title: "Alamat",
                controller: controller.addressController),
            customTextField(
                hint: "Kota",
                isPass: false,
                title: "Kota",
                controller: controller.cityController),
            customTextField(
                hint: "Negara",
                isPass: false,
                title: "Negara",
                controller: controller.stateController),
            customTextField(
                hint: "Kode Pos",
                isPass: false,
                title: "Kode Pos",
                controller: controller.postalcodeController),
            customTextField(
                hint: "Phone",
                isPass: false,
                title: "Phone",
                controller: controller.phoneController),
          ],
        ),
      ),
    );
  }
}
