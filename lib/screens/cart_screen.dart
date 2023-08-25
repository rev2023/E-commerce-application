import 'package:currency_symbols/currency_symbols.dart';
import 'package:e_commerce_application/provider/cart_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce_application/widgets/custom_app_bar.dart';

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
                child: cartProvider.productList.isEmpty
                    ? Center(child: Text('Cart is Empty'))
                    : ListView.builder(
                  itemCount: cartProvider.productList.length,
                  itemBuilder: (context, index) {
                    final product = cartProvider.productList[index];
                    return Dismissible(
                      key: ValueKey(product.id),
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
                        child: Card(
                          elevation: 3,
                          child: ListTile(
                            trailing: GestureDetector(onTap:(){cartProvider.productList.removeAt(index);
                            cartProvider.delete(product);},child: const Icon(Icons.remove_circle)),
                            contentPadding: const EdgeInsets.all(16.0),
                            leading: Image.network(product.mainImage),
                            title: Text(
                              '${product.name}',
                              style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Size: ${product.selectedSize}',
                                  style: const TextStyle(color: Colors.black54),
                                ),
                                Text(
                                  'Quantity: ${product.quantity}',
                                  style: const TextStyle(color: Colors.black54),
                                ),
                                Text(
                                  'Price: ${cSymbol(
                                      product.price.currency)}${product.price.amount}',
                                  style: const TextStyle(color: Colors.black54),
                                ),
                              ],

                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              color: Colors.white60,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(height: 10,),
                  Text('Products: £${cartProvider.totalCost - cartProvider.vatAmount}', style: TextStyle(color: Colors.black87),),
                  Text('VAT(%3): £${cartProvider.vatAmount.toStringAsFixed(2)}', style: TextStyle(color: Colors.black87),),
                  const SizedBox(height: 5,),
                  Container(width: 300,height: 1,color: Colors.black,),
                  Text('Total: £${cartProvider.totalCost.toStringAsFixed(2)}', style: TextStyle(color: Colors.black87),),
                  const SizedBox(height: 10,),
                  SizedBox(
                    height: 40,
                    width: 130,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)))),
                        backgroundColor: MaterialStateProperty.all(const Color(0xFF003366)),
                      ),
                      child: Text(
                        'Checkout',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                ],
              ),
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
