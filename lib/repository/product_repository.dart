import 'package:e_commerce_application/services/api/api_service.dart';

import '../models/product.dart';

class ProductRepository{
  
ApiService api = ApiService('https://s3-eu-west-1.amazonaws.com/api.themeshplatform.com/products.json');

Future<ProductList> fetchData() async {
  var response = await  api.getResponse();
  return ProductList.fromJson(response);
}

  
}