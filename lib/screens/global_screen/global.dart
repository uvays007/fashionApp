final List<Map<String, String>> products = [
  {
    "brandname": "2STROKE",
    "name": "Men Tshirt Black",
    "price": "RS 600",
    "image": "assets/images/black_sale.png",
  },
  {
    "brandname": "Leventer",
    "name": "Men Jeans Blue",
    "price": "RS 1200",
    "image": "assets/images/tuananh-blue-wNP79A-_bRY-unsplash.png",
  },
  {
    "brandname": "Ortox",
    "name": "Men Tshirt Blue",
    "price": "RS 500",
    "image": "assets/images/blue_sale.png",
  },
  {
    "brandname": "Gladiator",
    "name": "Men Tshirt Green",
    "price": "RS 399",
    "image": "assets/images/green_sale.png",
  },
];

final List<Map<String, dynamic>> wishlistItems = [];

List<bool> isLiked = List.generate(products.length, (index) => false);

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
