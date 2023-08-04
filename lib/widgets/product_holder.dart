import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';
import 'package:currency_symbols/currency_symbols.dart';

class ProductHolder extends StatelessWidget {
  final Product product;

  const ProductHolder({Key? key, required this.product}) : super(key: key);

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
          child: Image.network(product.mainImage),
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
