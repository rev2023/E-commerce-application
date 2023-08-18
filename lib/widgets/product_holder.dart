import 'package:flutter/material.dart';
import 'package:e_commerce_application/models/product.dart';
import 'package:currency_symbols/currency_symbols.dart';

class ProductHolder extends StatelessWidget {
  final Product product;
  const ProductHolder({Key? key, required this.product}) : super(key: key);

  // Method used to generate the image widget with error handling
  Widget displayImage(String uri, BuildContext context) {
    return FutureBuilder<void>(
      future: precacheImage(NetworkImage(uri), context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('');
        } else if (snapshot.hasError) {
          return const Icon(Icons.error);
        } else {
          return Image.network(uri, width: 220, height: 120, fit: BoxFit.cover);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(bottomRight:Radius.circular(40), bottomLeft:Radius.circular(40) ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            width: 220,
            height: 120,
            child: displayImage(product.mainImage, context),
          ),
          const SizedBox(height: 5),
          Align(
            child: Text(product.name, textAlign: TextAlign.center),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                cSymbol(product.price['currency']),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 3),
              Text(
                product.price['amount'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
