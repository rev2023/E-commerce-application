import 'package:e_commerce_application/repository/product_repository.dart';
import 'package:e_commerce_application/services/api/api_service.dart';
import 'package:get_it/get_it.dart';

  final getIt = GetIt.instance;

void setupDependencies() {
  // Registering APIs with interfaces or abstract classes
  getIt.registerSingleton<ApiService>(ApiService(Uri.parse('https://s3-eu-west-1.amazonaws.com/api.themeshplatform.com/products.json')));
  getIt.registerSingleton<ProductRepository>(ProductRepository());


}