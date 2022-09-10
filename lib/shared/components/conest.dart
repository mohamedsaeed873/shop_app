


import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

import '../../layout/Auth/login/login_screen.dart';

void SignOut(context){
  CacheHelper.removeData(key: "token").then((value){
    if(value){
      navigateToFinsh(context, LoginScreen());
    }

  });
}

void printFullText(String text){
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) =>
    print(match.group(0)));
}

String token='';