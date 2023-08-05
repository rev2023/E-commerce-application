import 'package:flutter/material.dart';
import 'package:e_commerce_application/models/product.dart';
import 'package:currency_symbols/currency_symbols.dart';

class ProductHolder extends StatelessWidget {
  final Product product;

  const ProductHolder({Key? key, required this.product}) : super(key: key);

  // Method used to generate the image widget instead of directly using the image widget
  // This is done to deal with the HTTP exception where the connection is closed before the complete header is received
  Widget displayImage(String uri, BuildContext context) {
    return FutureBuilder<void>(
      future: precacheImage(NetworkImage(uri), context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            print('Error loading image: ${snapshot.error}');
            return const Placeholder();
          } else {
            return Image.network(uri);
          }
        } else {
          return Text('');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 180,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(40)),
      ),
      child: Column(
        children: [
          displayImage(product.mainImage, context),
          Column(
            children: [
              Align(
                child: Text(product.name, textAlign: TextAlign.center,),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(cSymbol(product.price['currency']), style: const TextStyle(fontWeight: FontWeight.bold)),
                    Padding(
                      padding: const EdgeInsets.only(left: 3.0),
                      child: Text(product.price['amount'], style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
