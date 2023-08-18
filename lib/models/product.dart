class ProductList{
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
  final Map<String, dynamic> price;
  final List<dynamic> sizes;
  final String color;
  final String stockStatus;
  final String description;

  Product({
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

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'] as String,
      brandName: json['brandName'] as String,
      id: json['id'] as String,
      mainImage: json['mainImage'] as String,
      color: json['colour'] as String,
      SKU: json['SKU'] as String,
      price: json['price'] as Map<String,dynamic>,
        sizes: json['sizes'] as List<dynamic>,
        description: json['description'] as String,
      stockStatus: json['stockStatus'] as String,
    );
  }
}
