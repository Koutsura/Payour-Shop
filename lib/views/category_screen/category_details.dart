import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pshop_aplikasi/consts/consts.dart';
import 'package:pshop_aplikasi/controllers/product_controller.dart';
import 'package:pshop_aplikasi/services/firestore_services.dart';
import 'package:pshop_aplikasi/views/category_screen/item_details.dart';
import 'package:pshop_aplikasi/views/widgets_common/bg.widget.dart';
import 'package:get/get.dart';
import 'package:pshop_aplikasi/views/widgets_common/loading_indicator.dart';

class CategoryDetails extends StatelessWidget {
  final String? title;
  const CategoryDetails({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();

    return bgWidget(
        child: Scaffold(
      appBar: AppBar(
        title: title!.text.fontFamily(bold).white.make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getProducts(title),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: "No Products found!".text.color(darkFontGrey).make(),
            );
          } else {
            var data = snapshot.data!.docs;

            return Container(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                              controller.subcat.length,
                              (index) => "${controller.subcat[index]}"
                                  .text
                                  .size(12)
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .makeCentered()
                                  .box
                                  .white
                                  .rounded
                                  .size(120, 60)
                                  .margin(
                                      const EdgeInsets.symmetric(horizontal: 4))
                                  .make()),
                        )),
                    20.heightBox,
                    Expanded(
                        child: GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: data.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisExtent: 250,
                                    mainAxisSpacing: 8,
                                    crossAxisSpacing: 8),
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    data[index]['p_imgs'][0],
                                    height: 150,
                                    width: 200,
                                    fit: BoxFit.cover,
                                  ),
                                  "${data[index]['p_name']}"
                                      .text
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .make(),
                                  10.heightBox,
                                  "${data[index]['p_price']}"
                                      .numCurrency
                                      .text
                                      .color(bluecolor)
                                      .fontFamily(bold)
                                      .size(16)
                                      .make(),
                                  10.heightBox,
                                ],
                              )
                                  .box
                                  .white
                                  .margin(
                                      const EdgeInsets.symmetric(horizontal: 4))
                                  .roundedSM
                                  .outerShadowSm
                                  .padding(const EdgeInsets.all(12))
                                  .make()
                                  .onTap(() {
                                    controller.checkIfFav(data[index]);
                                Get.to(
                                  () => ItemDetails(
                                    title: "${data[index]['p_name']}",
                                    data: data[index],
                                  ),
                                );
                              });
                            }))
                  ],
                ));
          }
        },
      ),
    ));
  }
}
