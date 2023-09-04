import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_application/provider/cart_provider.dart';
import 'package:e_commerce_application/provider/product_details_screen_provider.dart';
import 'package:e_commerce_application/provider/selected_screen_provider.dart';
import 'package:e_commerce_application/router/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce_application/styles/app_colors.dart';
import 'package:e_commerce_application/provider/home_screen_provider.dart';
import 'package:e_commerce_application/widgets/brand_icon.dart';
import 'package:e_commerce_application/widgets/custom_app_bar.dart';
import 'package:e_commerce_application/widgets/product_holder.dart';
import 'package:e_commerce_application/widgets/search_bar.dart';
import 'package:e_commerce_application/widgets/bottom_nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/app_drawer.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  HomeScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeScreenProvider()),
      ],
      child: Scaffold(
        key: _scaffoldKey,
        drawer: AppDrawer(onDrawerItemOnePressed: () {context.router.push(HomeRoute());  }, onDrawerItemTwoPressed: () { context.router.push(PreferencesRoute()); },),
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
                     Padding(
                      padding: EdgeInsets.only(left: 22.0),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                            AppLocalizations.of(context)!.explore,
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                    ),
                     Padding(
                      padding: EdgeInsets.only(top: 25.0),
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.ourBrands,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    Consumer<HomeScreenProvider>(
                      builder: (context, homeScreenProvider, _) {
                        return Column(
                          children: [
                            Row(
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
                                        border:
                                            Border.all(color: Colors.black87),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                      child:  Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: Center(
                                          child: Text(
                                            AppLocalizations.of(context)!.all,
                                            style: const TextStyle(
                                                color: Colors.black87,
                                                fontSize: 20),
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      homeScreenProvider.fetchData();
                                      homeScreenProvider.selectedSortingOption =
                                          AppLocalizations.of(context)!.regular;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: GestureDetector(
                                    child: BrandIcon(
                                      image: 'lib/assets/images/nike.svg',
                                      backgroundColor: AppColors.nikeOrange,
                                    ),
                                    onTap: () {
                                      homeScreenProvider.filterNike();
                                      homeScreenProvider.selectedSortingOption =
                                          'Regular';
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: GestureDetector(
                                    onTap: () {
                                      homeScreenProvider.filterPuma();
                                      homeScreenProvider.selectedSortingOption =
                                          'Regular';
                                    },
                                    child: BrandIcon(
                                      image: 'lib/assets/images/puma-white.svg',
                                      backgroundColor: AppColors.pumaRed,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: DropdownButton<String>(
                                  alignment: Alignment.centerRight,
                                  value:
                                      homeScreenProvider.selectedSortingOption,
                                  onChanged: (newValue) {
                                    homeScreenProvider.selectedSortingOption =
                                        newValue!;
                                    homeScreenProvider
                                        .handleSortingOption(newValue);
                                  },
                                  items: <String>[
                                    AppLocalizations.of(context)!.regular,
                                    AppLocalizations.of(context)!.sortAZ,
                                    AppLocalizations.of(context)!.sortZA,
                                    AppLocalizations.of(context)!.highestToLowestPrice,
                                    AppLocalizations.of(context)!.lowestToHighestPrice,
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    Consumer<HomeScreenProvider>(
                      builder: (context, homeScreenProvider, _) {
                        if (homeScreenProvider.productList.isEmpty) {
                          homeScreenProvider.fetchData();
                          // Show a loading indicator while data is being fetched
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 100.0),
                              child: CircularProgressIndicator(
                                  color: AppColors.primaryColor),
                            ),
                          );
                        } else {
                          // Build a grid view with two columns for each product once the data is available
                          return Padding(
                            padding: const EdgeInsets.only(top: 45.0),
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                                childAspectRatio: 0.75,
                              ),
                              itemCount: homeScreenProvider.productList.length,
                              itemBuilder: (context, index) {
                                final product =
                                    homeScreenProvider.productList[index];
                                return Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: GestureDetector(
                                      onTap: () {
                                        final productDetailsProvider = Provider
                                            .of<ProductDetailsScreenProvider>(
                                                context,
                                                listen: false);
                                        productDetailsProvider.product = product;
                                        context.router.push(const ProductDetailsRoute());

                                      },
                                      child: ProductHolder(product: product)),
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
        bottomNavigationBar:  Consumer<SelectedScreenProvider>(
          builder: (context, selectedIndexProvider, _) {
            BottomNavBar.itemCount = cartProvider.productList.length;
            return BottomNavBar(selectedIndex: selectedIndexProvider.selectedIndex,
                onSelect: selectedIndexProvider.updateIndex, );
          }
        )
      ),
    );
  }
}
