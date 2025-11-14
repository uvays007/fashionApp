import 'package:cloud_firestore/cloud_firestore.dart';

Stream<QuerySnapshot> getProductsStream() {
  return FirebaseFirestore.instance.collection('products').snapshots();
}

final List<Map<String, dynamic>> wishlistItems = [];

final List<Map<String, dynamic>> carts = [];
final List<Map<String, dynamic>> orders = [];
final List<Map<String, dynamic>> notifications = [
  {
    "message": "Get 25% off on all men’s clothing this weekend only!",
    "time": "5h ago",
  },
  {
    "message": "Items from your wishlist are now on sale. Don’t miss out!",
    "time": "1 day ago",
  },
];
String? docemail;
