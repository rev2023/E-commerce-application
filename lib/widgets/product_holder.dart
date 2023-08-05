import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_application/models/product.dart';
import 'package:currency_symbols/currency_symbols.dart';

class ProductHolder extends StatelessWidget {
  final Product product;

  const ProductHolder({Key? key, required this.product}) : super(key: key);

  //Method used to generate image widget instead of directly using image widget
  // This is done to deal with the HTTP exception where the connection is closed before complete header is received
  Widget displayImage(String uri, BuildContext context) {
    return FutureBuilder<void>(
      future: precacheImage(NetworkImage(uri), context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            // Handle the error here
            print('Error loading image: ${snapshot.error}');
            // You can return a placeholder image or any other widget to show when the image fails to load.
            return const Placeholder();
          } else {
            return Image.network(uri);
          }
        } else {
          // While the image is loading, you can show a loading indicator or any other widget.
          return Text('');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: false,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Container(
          width: 200,
          height: 150,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(40)),
          ),
          child: displayImage(product.mainImage, context)
        ),
        Column(
          children: [
            Align(
              child: Text(product.name, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(cSymbol(product.price['currency'])),
                  Padding(
                    padding: const EdgeInsets.only(left: 3.0,),
                    child: Text(product.price['amount'],),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
