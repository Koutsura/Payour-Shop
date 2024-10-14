import 'package:pshop_aplikasi/consts/firebase_const.dart';

class FirestoreServices {
  static getUsers(uid) {
    return firestore
        .collection(usersCollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }

  static getProducts(category) {
    return firestore
        .collection(produtsCollection)
        .where('p_category', isEqualTo: category)
        .snapshots();
  }

  static getCart(uid) {
    return firestore
        .collection(cartCollection)
        .where('added_by', isEqualTo: uid)
        .snapshots();
  }

  static deleteDocument(docId) {
    return firestore.collection(cartCollection).doc(docId).delete();
  }

  static getChatMessages(docId) {
    return firestore
        .collection(chatsCollection)
        .doc(docId)
        .collection(messageCollection)
        .orderBy('created_on', descending: false)
        .snapshots();
  }

  static getAllOrders() {
    return firestore
        .collection(ordersCollection)
        .where('order_by', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static getWishlists() {
    return firestore
        .collection(produtsCollection)
        .where('p_wishlist', arrayContains: currentUser!.uid)
        .snapshots();
  }

  static getAllMessages() {
    return firestore
        .collection(chatsCollection)
        .where('fromId', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static getCounts() async {
    var res = await Future.wait([
      firestore
          .collection(cartCollection)
          .where('added_by', isEqualTo: currentUser!.uid).get().then((value) {
            return value.docs.length;
          }),
          firestore
        .collection(produtsCollection)
        .where('p_wishlist', arrayContains: currentUser!.uid).get().then((value) {
            return value.docs.length;
          }),
          firestore
        .collection(ordersCollection)
        .where('order_by', isEqualTo: currentUser!.uid).get().then((value) {
            return value.docs.length;
          }),
    ]);
    return res;
  }

  static allproducts() {
    return firestore
        .collection(produtsCollection)
        .snapshots();
  }
}
