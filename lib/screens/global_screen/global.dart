import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

/// ******************************
/// GLOBAL PRODUCT LIST (FROM FIREBASE / SUPABASE)
/// ******************************

List<Map<String, dynamic>> products = []; // Filled from Supabase Fetch

/// ******************************
/// WISHLIST + CART GLOBALS
/// ******************************

List<Map<String, dynamic>> wishlistItems = [];
List<Map<String, dynamic>> carts = [];

/// ******************************
/// LIKED STATE (DYNAMICALLY UPDATED)
/// ******************************

List<bool> isLiked = [];

/// ******************************
/// SAFE VALUE HELPER
/// ******************************

String safe(dynamic value) {
  if (value == null) return "";
  return value.toString();
}

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
