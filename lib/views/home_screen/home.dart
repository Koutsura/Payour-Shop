import 'package:pshop_aplikasi/consts/consts.dart';
import 'package:pshop_aplikasi/controllers/home_controllers.dart';
import 'package:pshop_aplikasi/views/cart_screen/cart_screen.dart';
import 'package:pshop_aplikasi/views/category_screen/category_screen.dart';
import 'package:pshop_aplikasi/views/home_screen/home_screen.dart';
import 'package:pshop_aplikasi/views/profile_screen/profile_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pshop_aplikasi/views/widgets_common/exit_dialog.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(HomeController());

    var navbarItem = [
      BottomNavigationBarItem(icon: Image.asset(icHome, width: 26), label: home),
      BottomNavigationBarItem(icon: Image.asset(icCategories, width: 26), label: categories),
      BottomNavigationBarItem(icon: Image.asset(icCart, width: 26), label: cart),
      BottomNavigationBarItem(icon: Image.asset(icProfile, width: 26), label: account)
    ];

    var navBody =[
      const HomeScreen(),
      const CategoryScreen(),
      const CartScreen(),
      const ProfileScreen(),
    ];
    return WillPopScope(
      onWillPop: () async{
        showDialog(
          barrierDismissible: false,
          context: context, builder: (context) => exitDialog(context));
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            Obx(() => Expanded(child: navBody.elementAt(controller.currentNavIndex.value))),
          ],
        ),
        bottomNavigationBar: Obx(()=> 
          BottomNavigationBar(
            currentIndex: controller.currentNavIndex.value,
            selectedItemColor: bluecolor,
            selectedLabelStyle: const TextStyle(fontFamily: semibold),
            type: BottomNavigationBarType.fixed,
            backgroundColor: whiteColor,
            items: navbarItem,
            onTap:(value){
              controller.currentNavIndex.value = value;
    
            },
            ),
        ),
      ),
    );
  }
}