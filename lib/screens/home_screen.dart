import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce_application/styles/app_colors.dart';
import 'package:e_commerce_application/provider/home_screen_provider.dart';
import 'package:e_commerce_application/widgets/brand_icon.dart';
import 'package:e_commerce_application/widgets/custom_app_bar.dart';
import 'package:e_commerce_application/widgets/product_holder.dart';
import 'package:e_commerce_application/widgets/search_bar.dart';

class HomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Wrap the HomeScreen with ChangeNotifierProvider and provide the HomeScreenProvider instance.
    return ChangeNotifierProvider(
      create: (context) => HomeScreenProvider(),
      child: Scaffold(
        key: _scaffoldKey,
        drawer: const Drawer(),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              CustomAppBar(scaffoldKey: _scaffoldKey),
            ];
          },
          body: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: SizedBox(
                  height: 92,
                  child: SearchBar(),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 22.0),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Explore',
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 25.0),
                      child: Center(
                        child: Text(
                          'Our Brands',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    Consumer<HomeScreenProvider>(
                      builder: (context, homeScreenProvider, _) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: GestureDetector(
                                  child: Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.black87),
                                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.only(top: 8.0),
                                      child: Center(
                                        child: Text(
                                          'All',
                                          style: TextStyle(color: Colors.black87, fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: (){homeScreenProvider.fetchData();}
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: GestureDetector(
                                  child: BrandIcon(
                                    image: 'lib/assets/images/nike.svg',
                                    backgroundColor: AppColors.nikeOrange,
                                  ),
                                  onTap: (){homeScreenProvider.filterNike();}
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: GestureDetector(
                                onTap: () {
                                  homeScreenProvider.filterPuma();
                                },
                                child: BrandIcon(
                                  image: 'lib/assets/images/puma-white.svg',
                                  backgroundColor: AppColors.pumaRed,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    Consumer<HomeScreenProvider>(
                      builder: (context, HomeScreenProvider homeScreenProvider, _) {
                        if (homeScreenProvider.productList.isEmpty) {
                          // Show a loading indicator while data is being fetched
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 100.0),
                              child: CircularProgressIndicator(color: AppColors.primaryColor),
                            ),
                          );
                        } else {
                          // Build a grid view with two columns for each product once the data is available
                          return Padding(
                            padding: const EdgeInsets.only(top: 65.0),
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                                childAspectRatio: 0.75,
                              ),
                              itemCount: homeScreenProvider.productList.length,
                              itemBuilder: (context, index) {
                                final product = homeScreenProvider.productList[index];
                                return Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: ProductHolder(product: product),
                                );
                              },
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black87,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_basket),
              label: 'Cart',
            ),
          ],
        ),
      ),
    );
  }
}
