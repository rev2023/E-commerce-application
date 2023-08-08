import 'package:e_commerce_application/services/api/api_service.dart';
import 'package:e_commerce_application/models/product.dart';
import 'package:e_commerce_application/services/services_configuration.dart';

class ProductRepository {

  final apiService = getIt<ApiService>();

  Future<ProductList> fetchData() async {
    var response = await apiService.getResponse();
    return ProductList.fromJson(response);
  }
}

  
