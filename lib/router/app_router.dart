import 'package:auto_route/auto_route.dart';
import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(path: '/screens/splash_screen.dart', page: SplashRoute.page,),
    AutoRoute(path: '/screens/home_screen.dart', page: HomeRoute.page,initial: true),
    AutoRoute(path: '/screens/search_screen.dart', page: SearchRoute.page,),
    AutoRoute(path: '/screens/product_details_screen.dart', page: ProductDetailsRoute.page, ),
    AutoRoute(path: '/screens/cart_sreen.dart', page: CartRoute.page ),

  ];
}