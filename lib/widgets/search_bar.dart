import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';

@override
  class SearchBar extends StatelessWidget {
    const SearchBar({super.key});

    @override
    Widget build(BuildContext context) {
      final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

      return Padding(
        padding: const EdgeInsets.only(bottom: 0),
        child: FloatingSearchBar(
          automaticallyImplyDrawerHamburger: false,
          backdropColor: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          hint: 'Search...',
          scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
          transitionDuration: const Duration(milliseconds: 800),
          transitionCurve: Curves.easeInOut,
          physics: const BouncingScrollPhysics(),
          axisAlignment: isPortrait ? 0.0 : -1.0,
          openAxisAlignment: 0.0,
          width: isPortrait ? 600 : 500,
          debounceDelay: const Duration(milliseconds: 500),
          onQueryChanged: (query) {
            // Call your model, bloc, controller here.
          },
          // Specify a custom transition to be used for
          // animating between opened and closed stated.
          transition: CircularFloatingSearchBarTransition(),
          actions: [
            FloatingSearchBarAction(
              showIfOpened: false,
              child: Container(
                decoration: const BoxDecoration(color:Colors.black87,borderRadius: BorderRadius.all(Radius.circular(20))),
                child: CircularButton(
                  icon: const Icon(Icons.search, color: Colors.white,),
                  onPressed: () {},
                ),
              ),
            ),
            FloatingSearchBarAction.searchToClear(
              showIfClosed: false,
            ),
          ],
          builder: (context, transition) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Material(
                color: Colors.white,
                elevation: 4.0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: Colors.accents.map((color) {
                    return Container(height: 112, color: Colors.black87);
                  }).toList(),
                ),
              ),
            );
          },
        ),
      );
  }




}