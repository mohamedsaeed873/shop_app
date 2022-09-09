
import 'package:flutter/material.dart';

import '../layout/Auth/login/login_screen.dart';
import '../layout/ShopApp/shopLayout.dart';
import '../layout/onBoarding/on_boarding.dart';
import '../shared/network/local/cache_helper.dart';

class StartWidget extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
    bool? token = CacheHelper.getData(key: 'token');


    if (onBoarding != null) {
      if (token != null) {
        return const ShopLayout();
      } else {
        return  LoginScreen();
      }
    } else {
      return OnBoarding();
    }
  }
}
