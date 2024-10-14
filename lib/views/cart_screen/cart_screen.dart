import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pshop_aplikasi/consts/consts.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:pshop_aplikasi/controllers/cart_controller.dart';
import 'package:pshop_aplikasi/services/firestore_services.dart';
import 'package:pshop_aplikasi/views/cart_screen/shipping_screen.dart';
import 'package:pshop_aplikasi/views/widgets_common/loading_indicator.dart';
import 'package:pshop_aplikasi/views/widgets_common/our_button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());

    return Scaffold(
        backgroundColor: whiteColor,
        bottomNavigationBar: SizedBox(
          height: 60,
          child: ourButton(
            color: bluecolor,
            onPress: () {
              Get.to(() => const ShippingDetails());
            },
            textColor: whiteColor,
            title: "Lanjut ke Pengiriman",
          ),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title:
              "Keranjang".text.color(darkFontGrey).fontFamily(semibold).make(),
        ),
        body: StreamBuilder(
          stream: FirestoreServices.getCart(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: "cart is empty".text.color(darkFontGrey).make(),
              );
            } else {
              var data = snapshot.data!.docs;
              controller.calculate(data);
              controller.productSnapshot = data;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            leading: Image.network("${data[index]['img']}",
                            width: 80,
                            fit: BoxFit.cover,
                            ),
                            title:
                                "${data[index]['title']} (x${data[index]['qty']})"
                                    .text
                                    .fontFamily(semibold)
                                    .size(16)
                                    .make(),
                            subtitle: "${data[index]['tprice']}"
                                .numCurrency
                                .text
                                .color(bluecolor)
                                .fontFamily(semibold)
                                .make(),
                            trailing: const Icon(
                              Icons.delete,
                              color: bluecolor,
                            ).onTap(() {
                              FirestoreServices.deleteDocument(data[index].id);
                            }),
                          );
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "Total price"
                            .text
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .make(),
                        Obx(() => "${controller.totalP.value}"
                            .numCurrency
                            .text
                            .fontFamily(semibold)
                            .color(bluecolor)
                            .make())
                      ],
                    )
                        .box
                        .padding(const EdgeInsets.all(12))
                        .color(lightBlue)
                        .width(context.screenWidth - 60)
                        .roundedSM
                        .make(),
                    10.heightBox,
                    //SizedBox(
                    //width: context.screenWidth - 60,
                    //child: ourButton(
                    //color: bluecolor,
                    // onPress: () {},
                    //textColor: whiteColor,
                    //title: "Proceed to shipping",
                    //),
                    //),
                  ],
                ),
              );
            }
          },
        ));
  }
}
