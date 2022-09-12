// ignore_for_file: file_names, unused_import, use_key_in_widget_constructors, prefer_const_constructors, sized_box_for_whitespace, unnecessary_string_interpolations, non_constant_identifier_names, unnecessary_string_escapes

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/model/Category/category_model.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/state.dart';
import 'package:shop_app/shared/styles/colors.dart';

import '../../model/HomeModel/home_model.dart';
import '../../shared/components/components.dart';

class ProductsScreen extends StatelessWidget { 
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCupit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessFavoritesState) {
          if (state.model!.status!) {
            ShowToast(
              text: state.model!.message!,
              state: ToastStates.SUCCESS,
            );
          } else {
            ShowToast(
              text: state.model!.message!,
              state: ToastStates.ERROR,
            );
          }
        }
      },
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

  Widget productsBuilder(HomeModel model, CategoriesModel categoriesModel, context) =>
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
                  Text(
                    'Categories',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 140.0,
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Scrollbar(
                      thickness: 1,
                      child: ListView.separated(
                        padding:
                            EdgeInsetsDirectional.only(start: 10.0, top: 10),
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => CategoriesItem(
                            categoriesModel.data!.data[index], context),
                        separatorBuilder: (context, index) => SizedBox(
                          width: 10.0,
                        ),
                        itemCount: categoriesModel.data!.data.length,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'New Products',
                    style: Theme.of(context).textTheme.headline5,
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


  Widget GridProducts(ProductModel model, context) => InkWell(
        onTap: () {
        },
        child: Stack(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              clipBehavior: Clip.none,
              elevation: 20,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
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
                      children: [
                        Text(
                          model.name!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
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
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 0,
              child: IconButton(
                onPressed: () {
                  ShopCupit.get(context).changeFavorites(model.id!);
                },
                icon: Icon(
                  ShopCupit.get(context).favorites[model.id]
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: ShopCupit.get(context).favorites[model.id]
                      ? Colors.red
                      : Colors.grey,
                  size: 26,
                ),
              ),
            ),
            if (model.discount != 0)
              Positioned.fill(
                child: Align(
                  alignment: Alignment(1, -1),
                  child: ClipRect(
                    child: Banner(
                      message: 'OFFERS',
                      textStyle: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        letterSpacing: 0.5,
                      ),
                      location: BannerLocation.topStart,
                      color: Colors.red,
                      child: Container(
                        height: 100.0,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      );

  Widget CategoriesItem(DataModel model, context) => InkWell(
    onTap: () {
    },
    child: Container(
      width: 105,
      child: Column(
        children: [
          Card(
            elevation: 10,
            child: Container(
              width: 95.0,
              height: 75.0,
              decoration: BoxDecoration(
               // shape: BoxShape.circle,
                //border: Border.all(color: defaultColor, width: 2),
                image: DecorationImage(
                  image: NetworkImage(
                    model.image!,
                  ),
                  fit: BoxFit.cover,
                ),
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
    ),
  );

}
