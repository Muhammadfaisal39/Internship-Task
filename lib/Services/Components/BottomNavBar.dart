import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_task/Screens/categories_screen.dart';
import 'package:internship_task/Screens/favourites_screen.dart';
import 'package:internship_task/Screens/products_screen.dart';
import 'package:internship_task/Screens/profile_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int screenIndex = 0;
  late List<Widget> screens;

  @override
  void initState() {
    super.initState();
    screens = [
      const ProductsScreen(),
      const CategoryScreen(),
      FavoritesScreen(),
      ProfileScreen()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[screenIndex],
      bottomNavigationBar: buildMyNavBar(),
    );
  }

  Container buildMyNavBar() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildNavBarItem(0, Icons.production_quantity_limits, "Products"),
          buildNavBarItem(1, Icons.category, "Categories"),
          buildNavBarItem(2, Icons.favorite_border_outlined, "Favourites"),
          buildNavBarItem(3, Icons.person_outline_rounded, "Profile"),
        ],
      ),
    );
  }

  Widget buildNavBarItem(int index, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () {
            setState(() {
              screenIndex = index;
            });
          },
          icon: Icon(
            icon,
            color: Colors.white,
            size: 30,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            fontFamily: "Poppins",
            color: Colors.white
          ),
        ),
      ],
    );
  }
}
