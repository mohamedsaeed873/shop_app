
import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Shop' , style: Theme.of(context).textTheme.bodyText1,),
    );
  }
}
