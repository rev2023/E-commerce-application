import 'package:auto_route/auto_route.dart';
import 'package:currency_symbols/currency_symbols.dart';
import 'package:e_commerce_application/provider/cart_provider.dart';
import 'package:emerge_alert_dialog/emerge_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce_application/widgets/custom_app_bar.dart';
import 'package:e_commerce_application/models/product.dart';
import 'package:e_commerce_application/provider/selected_screen_provider.dart';
import 'package:e_commerce_application/widgets/bottom_nav_bar.dart';
import 'package:e_commerce_application/styles/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:e_commerce_application/router/app_router.gr.dart';
import 'package:e_commerce_application/widgets/app_drawer.dart';


@RoutePage()
class CartScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context,);
    cartProvider.getItemsInCart();
    double fontSize = 15;
    const int numberOfDecimals = 2;

    Future<void> _showDialog(BuildContext context, VoidCallback method, Product product) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return  EmergeAlertDialog(
            alignment: Alignment.bottomCenter,
            emergeAlertDialogOptions: EmergeAlertDialogOptions(
              title:Text(AppLocalizations.of(context)!.remove),                
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
              content: Text(AppLocalizations.of(context)!.confirmNotif(product.name)),
              actions: [Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(onTap: (){Navigator.pop(context);},child: const Text('Cancel')),
              ),Container(
                height: 45,
                width: 110,
                child: ElevatedButton(onPressed: method ,style: ButtonStyle(shape: MaterialStateProperty.all(const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15)))),backgroundColor: MaterialStateProperty.all(Colors.black87)),
                child: Text(AppLocalizations.of(context)!.confirm,style: TextStyle(color: Colors.white),)),
              )],
              actionsOverflowButtonSpacing: 50
            ),
          );
        },
      );
    }

    return Scaffold(
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
            cartProvider.productList.isEmpty ? Text('') : Padding(
              padding: const EdgeInsets.only(right: 8.0, top: 8),
              child: GestureDetector(onTap: (){cartProvider.clearCart();},child: const Align(alignment: Alignment.bottomRight,child: Text('clear cart', style: TextStyle(fontWeight: FontWeight.w500),))),
            ),
            Expanded(
              child: Container(
                child: cartProvider.productList.isEmpty
                    ?  Center(child: Text(AppLocalizations.of(context)!.emptyCart))
                    : ListView.builder(
                  itemCount: cartProvider.productList.length,
                  itemBuilder: (context, index) {
                    final product = cartProvider.productList[index];
                    return Dismissible(
                      key: ValueKey(product.id),
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 16.0),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      onDismissed: (direction) {
                        cartProvider.productList.removeAt(index);
                        cartProvider.delete(product);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 3,
                          child: ListTile(
                            trailing: Column(
                              children: [
                                GestureDetector(onTap:(){
                                  cartProvider.incrementQuantity(product);
                                },child: const Icon(Icons.add_circle)),
                                GestureDetector(onTap:(){
                                  if(product.quantity! <= 1 ){
                                    _showDialog(context, (){cartProvider.delete(product);context.router.pop();}, product);
                                  }
                                    cartProvider.decrementQuantity(product);
                                },child: const Icon(Icons.remove_circle)),
                              ],
                            ),
                            contentPadding: const EdgeInsets.all(16.0),
                            leading: SizedBox(width: 60, child: Image.network(product.mainImage)),
                            title: Text(
                              product.name,
                              style: const TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                AppLocalizations.of(context)!.size(product.selectedSize as Object),
                                  style: const TextStyle(color: AppColors.lightBlack),
                                ),
                                Text(
                                  AppLocalizations.of(context)!.quantity(product.quantity as Object),
                                  style: const TextStyle(color: AppColors.lightBlack),
                                ),
                                Text(
                                  'Price: ${cSymbol(
                                      product.price.currency)}${product.price.amount}',
                                  style: const TextStyle(color: AppColors.lightBlack),
                                ),
                              ],

                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              color: Colors.white60,
              width: double.infinity,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(AppLocalizations.of(context)!.products, style: TextStyle(color: AppColors.darkGrey, fontSize: fontSize),),
                              Text('£${(cartProvider.totalCost - cartProvider.vatAmount).toStringAsFixed(numberOfDecimals)}', style: TextStyle(color: Colors.grey[700]),),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(AppLocalizations.of(context)!.vat, style:  TextStyle(color: AppColors.darkGrey, fontSize: fontSize),),
                              Text('£${cartProvider.vatAmount.toStringAsFixed(numberOfDecimals)}', style: TextStyle(color: Colors.grey[700]),),
                            ],
                          ),
                          const SizedBox(height: 5,),
                          Container(width: double.infinity,height: 1,color: AppColors.grey,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(AppLocalizations.of(context)!.total, style: TextStyle(color: AppColors.darkGrey,fontSize: fontSize),),
                              Text('£${cartProvider.totalCost.toStringAsFixed(numberOfDecimals)}', style: TextStyle(color: AppColors.darkGrey),),
                            ],
                          ),
                          const SizedBox(height: 5,),                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: 220,
                    child: Opacity(
                      opacity: cartProvider.productList.isEmpty ? 0.3 : 1,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)))),
                          backgroundColor: MaterialStateProperty.all(const Color(0xFF003366)),
                        ),
                        child:  Text(
                          AppLocalizations.of(context)!.checkout,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
             const SizedBox(height: 20,),
          ],
        ),
      ),
        bottomNavigationBar:  Consumer<SelectedScreenProvider>(
            builder: (context, selectedIndexProvider, _) {
              return BottomNavBar(selectedIndex: selectedIndexProvider.selectedIndex,
                onSelect: selectedIndexProvider.updateIndex,);
            }
        )
    );
  }
}
