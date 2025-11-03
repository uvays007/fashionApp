import 'package:comercial_app/screens/nav_screen/cart.dart';
import 'package:comercial_app/screens/nav_screen/home.dart';
import 'package:comercial_app/screens/nav_screen/profile.dart';
import 'package:comercial_app/screens/nav_screen/tryon.dart';
import 'package:comercial_app/screens/notification_screen/notification.dart';
import 'package:comercial_app/screens/order_screen/order.dart';
import 'package:comercial_app/screens/wishlist_screen/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Nav extends StatefulWidget {
  const Nav({super.key});

  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> with SingleTickerProviderStateMixin {
  int selectedIndex = 0;

  final List<Widget> pages = [Home(), Tryon(), Cart(), Profile()];

  final List<String> icons = [
    'assets/icons/bottm_nav/home_30dp_000000_FILL0_wght400_GRAD0_opsz24.svg',
    'assets/icons/bottm_nav/checkroom_30dp_000000_FILL0_wght400_GRAD0_opsz24.svg',
    'assets/icons/bottm_nav/shopping_cart_30dp_000000_FILL0_wght400_GRAD0_opsz24.svg',
    'assets/icons/bottm_nav/person_30dp_000000_FILL0_wght400_GRAD0_opsz24.svg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildDrawer(context),
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        centerTitle: true,
        title: Text(
          'FITMAX',
          style: TextStyle(
            fontFamily: 'LondrinaSolid',
            fontWeight: FontWeight.w600,
            fontSize: 30,
            color: Color(0xFFC19375),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationPage()),
              );
            },
            icon: Icon(Icons.notifications_none, color: Colors.black87),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: GestureDetector(
              onTap: () => setState(() => selectedIndex = 3),
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400, width: 1),
                  borderRadius: BorderRadius.circular(100),
                  image: DecorationImage(
                    image: AssetImage("assets/images/appi.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      body: AnimatedSwitcher(
        switchInCurve: Curves.easeInCubic,
        duration: const Duration(milliseconds: 300),
        child: pages[selectedIndex],
      ),

      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.grey.shade200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(icons.length, (index) {
            final bool isSelected = selectedIndex == index;
            return GestureDetector(
              onTap: () => setState(() => selectedIndex = index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  color: isSelected ? Colors.black : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    icons[index],
                    height: 24,
                    width: 24,
                    colorFilter: ColorFilter.mode(
                      isSelected
                          ? Colors.white
                          : const Color.fromARGB(255, 88, 88, 88),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Drawer buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey.shade100,
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.grey.shade300),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage("assets/images/appi.jpg"),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Fazil shaz",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        "fasilshaz123@gmail.com",
                        style: TextStyle(color: Colors.black54, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          buildDrawerItem(
            icon: Icons.home_outlined,
            text: "Home",
            onTap: () => _navigateTo(0),
          ),
          buildDrawerItem(
            icon: Icons.shopping_cart_checkout,
            text: "Orders",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OrderPage()),
            ),
          ),

          buildDrawerItem(
            icon: Icons.favorite_outline,
            text: "Wishlist",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WishlistPage()),
            ),
          ),
          buildDrawerItem(
            icon: Icons.settings_outlined,
            text: "Settings",
            onTap: () => () {},
          ),
          buildDrawerItem(
            icon: Icons.help_outline,
            text: "Help",
            onTap: () => () {},
          ),

          const Spacer(),

          Divider(thickness: 1, color: Colors.grey.shade400),

          ListTile(
            leading: Icon(Icons.logout, color: Colors.redAccent),
            title: Text("Logout", style: TextStyle(color: Colors.redAccent)),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget buildDrawerItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.black87),
      title: Text(
        text,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
    );
  }

  void _navigateTo(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
