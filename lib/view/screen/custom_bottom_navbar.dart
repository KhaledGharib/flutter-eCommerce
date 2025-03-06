import 'package:ecommerce/view/screen/cart_screen.dart';
import 'package:ecommerce/view/screen/fav_screen.dart';
import 'package:ecommerce/view/screen/home_screen.dart';
import 'package:ecommerce/view/screen/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class CustomBottomNavbar extends StatefulWidget {
  const CustomBottomNavbar({super.key});

  @override
  State<CustomBottomNavbar> createState() => _CustomBottomNavbarState();
}

class _CustomBottomNavbarState extends State<CustomBottomNavbar> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return PersistentTabView(
      tabs: [
        PersistentTabConfig(
          screen: HomeScreen(),
          item: ItemConfig(
            icon: Icon(Icons.home),
            title: "Home",
            activeForegroundColor: colorScheme.primary,
          ),
        ),
        PersistentTabConfig(
          screen: CartScreen(),
          item: ItemConfig(
            icon: Icon(Icons.shopping_bag),
            title: "Cart",
            activeForegroundColor: colorScheme.primary,
          ),
        ),
        PersistentTabConfig(
          screen: FavScreen(),
          item: ItemConfig(
            icon: Icon(Icons.favorite_rounded),
            title: "favorite",
            activeForegroundColor: colorScheme.primary,
          ),
        ),
        PersistentTabConfig(
          screen: SettingScreen(),
          item: ItemConfig(
            icon: Icon(Icons.person),
            title: "Settings",
            activeForegroundColor: colorScheme.primary,
          ),
        ),
      ],
      navBarBuilder:
          (navBarConfig) => Style6BottomNavBar(navBarConfig: navBarConfig),
    );
  }
}
