import 'dart:convert';
import 'package:e_commerce_application/models/product_price.dart';
import 'cart.dart';

class ProductList {
  List<Product> productList;

  ProductList(this.productList);

  factory ProductList.fromJson(Map<String, dynamic> jsonData) {
    final products = jsonData['data'] as List<dynamic>;
    final productsList = products.map((product) => Product.fromJson(product)).toList();
    return ProductList(productsList);
  }
}

class Product {
  final String id;
  final String SKU;
  final String name;
  final String brandName;
  final String mainImage;
  final ProductPrice price;
  final List<dynamic> sizes;
  final String color;
  final String stockStatus;
  final String description;
   num? quantity;

  Product({
    this.quantity,
    required this.name,
    required this.brandName,
    required this.id,
    required this.mainImage,
    required this.SKU,
    required this.price,
    required this.sizes,
    required this.color,
    required this.description,
    required this.stockStatus,
  });

  Map<String, dynamic> toMap(num quantity) => {
    CartFields.id: int.parse(id),
    CartFields.sku: int.parse(SKU),
    CartFields.name: name,
    CartFields.brandName: brandName,
    CartFields.mainImage: mainImage,
    CartFields.currency: price.currency,
    CartFields.price: double.parse(price.amount) *quantity,
    CartFields.sizes: json.encode(sizes),
    CartFields.color: color,
    CartFields.stockStatus: stockStatus,
    CartFields.description: description,
    CartFields.quantity: quantity,

  };

  static Product fromMap(Map<String, dynamic> map) => Product(
    name: map[CartFields.name] as String,
    brandName: map[CartFields.brandName] as String,
    id: map[CartFields.id].toString(),
    mainImage: map[CartFields.mainImage] as String,
    SKU: map[CartFields.sku].toString(),
    price: ProductPrice(
        amount: map[CartFields.price].toString(),
        currency: map[CartFields.currency].toString()),
    sizes: json.decode(map[CartFields.sizes]) as List<dynamic>,
    color: map[CartFields.color] as String,
    description: map[CartFields.description] as String,
    stockStatus: map[CartFields.stockStatus] as String,
    quantity: map[CartFields.quantity]
  );

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'] as String,
      brandName: json['brandName'] as String,
      id: json['id'] as String,
      mainImage: json['mainImage'] as String,
      color: json['colour'] as String,
      SKU: json['SKU'] as String,
      price: ProductPrice.fromJson(json['price']),
      sizes: List<dynamic>.from(json['sizes']),
      description: json['description'] as String,
      stockStatus: json['stockStatus'] as String,
    );
  }
}
