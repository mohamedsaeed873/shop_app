// ignore_for_file: use_key_in_widget_constructors, unused_local_variable, prefer_const_literals_to_create_immutables, prefer_const_constructors, non_constant_identifier_names, sized_box_for_whitespace

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/cubit.dart';

import '../../model/Favorite/favoriteModel.dart';
import '../../shared/cubit/state.dart';
import '../../shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCupit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.builder(
          physics: BouncingScrollPhysics(),
            itemCount: ShopCupit.get(context).favoritesModel!.data!.data!.length,
            itemBuilder: (context,index){
          return BuildListProduct(context);
        });
      },
    );
  }
}

Widget BuildListProduct( BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Card(
      elevation: 20,
      child: Container(
        width: double.infinity,
        height: 120,
        child: Stack(
          children: [
            Row(
              children: [
                Container(
                  height: 120,
                  width: 120,
                  child: Image(
                    image: NetworkImage(""),
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Apple iPhone 12 Pro Max 256GB 6 GB RAM, Pacific Blue ',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14.0, height: 1.3),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Text("20000",
                                style: TextStyle(
                                  color: defaultColor,
                                )),
                            SizedBox(
                              width: 7.0,
                            ),
                            Text(
                              '23000',
                              style: TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            Spacer(),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned.fill(
              child: Align(
                  child: ClipRect(
                    child: Banner(
                      message: 'DISCOUNT',
                      textStyle: TextStyle(
                        //fontFamily: 'Cairo',
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        letterSpacing: 0.5,
                      ),
                      location: BannerLocation.topStart,
                      color: Colors.red,
                      child: Container(
                        height: 300.0,
                      ),
                    ),
                  )),
            )
          ],
        ),
      ),
    ),
  );
}
