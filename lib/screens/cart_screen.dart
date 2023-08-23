import 'package:e_commerce_application/provider/cart_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_app_bar.dart';

class CartScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    print(cartProvider.productList.length);

    return Scaffold(
      key: _scaffoldKey,
      drawer: const Drawer(),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            CustomAppBar(scaffoldKey: _scaffoldKey),
          ];
        },
        body: ListView.builder(
          itemCount: cartProvider.productList.length, // Replace with your actual list length
          itemBuilder: (context, index) {
            print(cartProvider.productList.length);
            // Replace CartItemWidget with your actual cart item widget
            return ListTile( leading: Text(cartProvider.productList[index].name + '\n x ' + cartProvider.productList[index].quantity.toString(),style: TextStyle(color: Colors.black87),),trailing: Image.network(cartProvider.productList[index].mainImage),);
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black87,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            label: 'Cart',
          ),
        ],
      ),
    );
  }
}
