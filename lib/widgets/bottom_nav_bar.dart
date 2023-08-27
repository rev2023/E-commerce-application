import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_application/router/app_router.gr.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  static int? itemCount;
  final ValueChanged<int> onSelect;

  set count(int count){
    itemCount = count;
  }
  const BottomNavBar({super.key, required this.selectedIndex, required this.onSelect,});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      currentIndex: selectedIndex,
      selectedItemColor: Colors.black87,
      onTap: (index) {
        onSelect(index);

        if (index == 1) {
          context.router.push(CartRoute());
        } else {
          context.router.push(HomeRoute());
        }
      },
      items:  [
        const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
          icon: itemCount != 0 ? Badge(label: Text(itemCount.toString()),child: const Icon(Icons.shopping_basket),) : const Icon(Icons.shopping_basket),
          label: 'Cart',
        ),
      ],
    );
  }
}
