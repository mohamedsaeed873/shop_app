// ignore_for_file: file_names, unused_import, use_key_in_widget_constructors, prefer_const_constructors, sized_box_for_whitespace, unnecessary_string_interpolations, non_constant_identifier_names, unnecessary_string_escapes

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/model/Category/category_model.dart';
import 'package:shop_app/model/HomeModel/home_model.dart';

import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/state.dart';
import '../../shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCupit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCupit.get(context).homeModel != null &&
              ShopCupit.get(context).categoriesModel != null,
          builder: (context) => productsBuilder(
              ShopCupit.get(context).homeModel!,
              ShopCupit.get(context).categoriesModel!,
              context),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget productsBuilder(HomeModel model, CategoriesModel categoriesModel,
          BuildContext context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              child: CarouselSlider(
                items: model.data!.banners
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          width: double.infinity,
                          height: 300,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image(
                              image: NetworkImage('${e.image}'),
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
                options: CarouselOptions(
                  autoPlay: true,
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Categories',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          height: 100,
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return CategoriesItem(categoriesModel.data!.data[index]);
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  width: 10,
                                );
                              },
                              itemCount:categoriesModel.data!.data.length),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          'New Products',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1 / 1.7,
                    children: List.generate(
                      model.data!.products.length,
                      (index) =>
                          GridProducts(model.data!.products[index], context),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget GridProducts(ProductModel model, context) => Stack(
        children: [
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            clipBehavior: Clip.none,
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(
                    image: NetworkImage(
                      model.image!,
                    ),
                    width: double.infinity,
                    height: 150.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.name!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14.0, height: 1.3),
                      ),
                      Row(
                        children: [
                          Text(
                            '${model.price.round()}\ LE',
                            style: TextStyle(
                              color: defaultColor,
                            ),
                          ),
                          SizedBox(
                            width: 7.0,
                          ),
                          if (model.discount != 0)
                            Text(
                              '${model.oldPrice.round()}\LE',
                              style: TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          Spacer(),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: IconButton(
                onPressed: () {
               ShopCupit.get(context).changeFavorites(model.id!);
                },
                icon: Icon(
                  ShopCupit.get(context).favorites[model.id]
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: ShopCupit.get(context).favorites[model.id]
                      ? defaultColor
                      : Colors.grey,
                  size: 26,
                ),),
          ),
          if (model.discount != 0)
            Positioned.fill(
              child: Align(
                  child: ClipRect(
                child: Banner(
                  message: 'DISCOUNT',
                  textStyle: TextStyle(
                    fontFamily: 'Roboto',
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
      );

  Widget CategoriesItem(DataModel model) => Container(
        width: 90,
        child: Column(
          children: [
            Container(
              width: 75.0,
              height: 72.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: defaultColor, width: 1),
                image: DecorationImage(
                  image: NetworkImage(
                      model.image!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              model.name!.toUpperCase(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      );
}
