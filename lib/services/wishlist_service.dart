import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WishlistService {
  final _db = FirebaseFirestore.instance;
  final _user = FirebaseAuth.instance.currentUser;

  String get uid => _user!.uid;

  /// Add product to wishlist
  Future<void> addToWishlist(Map<String, dynamic> product) async {
    await _db
        .collection("wishlist")
        .doc(uid)
        .collection("items")
        .doc(product["id"])
        .set(product);
  }

  /// Remove product
  Future<void> removeFromWishlist(String productId) async {
    await _db
        .collection("wishlist")
        .doc(uid)
        .collection("items")
        .doc(productId)
        .delete();
  }

  /// Check if product is liked
  Stream<bool> isWishlisted(String productId) {
    return _db
        .collection("wishlist")
        .doc(uid)
        .collection("items")
        .doc(productId)
        .snapshots()
        .map((doc) => doc.exists);
  }

  /// Get all wishlist items
  Stream<List<Map<String, dynamic>>> getWishlistItems() {
    return _db
        .collection("wishlist")
        .doc(uid)
        .collection("items")
        .snapshots()
        .map((snap) => snap.docs.map((e) => e.data()).toList());
  }
}
