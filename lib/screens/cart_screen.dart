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
    final cartProvider = Provider.of<CartProvider>(context,);
    cartProvider.getItemsInCart();

    return Scaffold(
      key: _scaffoldKey,
      drawer: const Drawer(),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            CustomAppBar(scaffoldKey: _scaffoldKey),
          ];
        },
        body: Column(
          children: [
            Expanded(
              child: Container(
                child: ListView.builder(
                  itemCount: cartProvider.productList.length,
                  itemBuilder: (context, index) {
                    final product = cartProvider.productList[index];
                    return cartProvider.productList.isEmpty? CircularProgressIndicator() : Dismissible(
                      key: ValueKey(product.id), // Use a unique key for each item
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 16.0),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      onDismissed: (direction) {
                        cartProvider.productList.removeAt(index);
                        cartProvider.delete(product);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: Text('${product.name}  (x${product.quantity})\n size: ${product.selectedSize} \n price: ${product.price.amount}',
                            style: const TextStyle(color: Colors.black87),
                          ),
                          trailing: Image.network(product.mainImage),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Column(
              children: [
                Text('Total: ${cartProvider.totalCost.toString()}'),
                const SizedBox(height: 10,),
                Container(width: 300,height: 1,color: Colors.black,),
                const SizedBox(height: 5,),
                ElevatedButton(onPressed: (){}, style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blueGrey)), child: Text('Checkout'),)
              ],
            )
          ],
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
