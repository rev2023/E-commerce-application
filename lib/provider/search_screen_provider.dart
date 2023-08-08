import 'package:e_commerce_application/repository/product_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_application/models/product.dart';
import 'package:get_it/get_it.dart';

class SearchScreenProvider extends ChangeNotifier {
  final productRepository = GetIt.instance<ProductRepository>();
  List<Product> productList = [];
  bool noResult = false;




  Future<void> fetchData(String searchQuery) async {
    noResult = false;
    productList.clear();
    try {
      ProductList products = await productRepository.fetchData();
      for(Product product in products.productList){
        if(product.name.toLowerCase().contains(searchQuery) || product.name.toUpperCase().contains(searchQuery)){
          productList.add(product);
        }
      }

    } catch (e) {
      // Handle any errors that might occur during data fetching
      print('Error fetching data: $e');
    }
    if(productList.isEmpty){
      noResult = true;
    }
    notifyListeners(); // Notify listeners that the data has been fetched

  }
  }
