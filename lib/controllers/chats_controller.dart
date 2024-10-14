import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pshop_aplikasi/consts/consts.dart';
import 'package:pshop_aplikasi/controllers/home_controllers.dart';

class ChatController extends GetxController {

  @override
  void onInit() {
    getChatId();
    super.onInit();
  }

  var chat = firestore.collection(chatsCollection);
  var friendName = Get.arguments[0];
  var friendId = Get.arguments[1];

  var senderName = Get.find<HomeController>().username;
  var currentId = currentUser!.uid;

  var msgController = TextEditingController();

  dynamic chatDocId;

  var isLoading = false.obs;

  getChatId() async{
    isLoading(true);

    await chat.where('users', isEqualTo: {
      friendId: null,
      currentId : null
    }
    ).limit(1).get().then((QuerySnapshot snapshot){
      if(snapshot.docs.isNotEmpty){
        chatDocId = snapshot.docs.single.id;
      }else{
        chat.add({
          'created_on': null,
          'last_msg' :'',
          'users' : {friendId: null,currentId: null},
          'toId' : '',
          'fromId' : '',
          'friend_name' : friendName,
          'sender_Name' : senderName
        }).then((value){
          {
            chatDocId = value.id;

          }
        });
        
      }

    });
    isLoading(false);
  }



  sendMsg(String msg) async {
    if(msg.trim().isNotEmpty){
      chat.doc(chatDocId).update({
        'created_on' :FieldValue.serverTimestamp(),
        'last_msg': msg,
        'toId' : friendId,
        'fromId' : currentId,

      });

      chat.doc(chatDocId).collection(messageCollection).doc().set({
        'created_on' :FieldValue.serverTimestamp(),
        'msg': msg,
        'uid' : currentId,
      });
    }

  }
  
}