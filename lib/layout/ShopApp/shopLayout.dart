

// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/state.dart';

import '../../modules/Search/search.dart';
import '../../modules/cart/cart.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCupit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessFavoritesState) {
          if (!state.model!.status!) {
            ShowToast(text: state.model!.message!, state: ToastStates.ERROR);
          }
        }
      },
      builder: (context, state) {
        var cubit = ShopCupit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text("Salla"),
            actions: [

              IconButton(onPressed: () {
                navigateTo(context,  SearchScreen());
              }, icon: const Icon(Icons.search)),
              IconButton(onPressed: () {
                navigateTo(context,  CartScreen());
              }, icon: const Icon(Icons.shopping_cart)),

            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.ChangeBottom(index);
            },
            currentIndex: cubit.currentIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.apps),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'settings',
              ),
            ],
          ),
        );
      },
    );
  }
}
