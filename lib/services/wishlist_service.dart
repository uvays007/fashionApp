import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WishlistService {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  // ---------- Get User ID ----------
  String get userId => _auth.currentUser!.uid;

  // ---------- Add to Wishlist ----------
  Future<void> addToWishlist(Map<String, dynamic> product) async {
    await _firestore
        .collection("users")
        .doc(userId)
        .collection("wishlist")
        .doc(product["id"])
        .set(product);
  }

  // ---------- Remove from Wishlist ----------
  Future<void> removeFromWishlist(String productId) async {
    await _firestore
        .collection("users")
        .doc(userId)
        .collection("wishlist")
        .doc(productId)
        .delete();
  }

  // ---------- Check if product is wishlisted ----------
  Stream<bool> isWishlisted(String productId) {
    return _firestore
        .collection("users")
        .doc(userId)
        .collection("wishlist")
        .doc(productId)
        .snapshots()
        .map((doc) => doc.exists);
  }

  // ---------- Get all wishlist products ----------
  Stream<List<Map<String, dynamic>>> getWishlist() {
    return _firestore
        .collection("users")
        .doc(userId)
        .collection("wishlist")
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }
}
