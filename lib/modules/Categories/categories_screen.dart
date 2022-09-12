
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/state.dart';
import 'package:shop_app/shared/styles/colors.dart';

import '../../model/Category/category_model.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCupit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.builder(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) =>
              CatList(
                  ShopCupit
                      .get(context)
                      .categoriesModel!
                      .data!
                      .data[index], context),
          itemCount: ShopCupit
              .get(context)
              .categoriesModel!
              .data!
              .data
              .length,
        );
      },
    );
  }

    Widget CatList(DataModel model, context) => Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 20,
        child: Row(
          children: [
            Container(
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
             //  shape: BoxShape.v,
                //border: Border.all(color: defaultColor, width: 1),
                image: DecorationImage(
                  image: NetworkImage(
                    model.image!,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Text(
              model.name!.toUpperCase(),
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Spacer(),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.arrow_forward_ios,
              ),
            ),
          ],
        ),
      ),
    );
  }
