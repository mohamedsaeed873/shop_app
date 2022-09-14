// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/model/search/search_model.dart';
import 'package:shop_app/modules/Search/cubit/state.dart';

import '../../../shared/components/conest.dart';
import '../../../shared/network/end_pointe.dart';
import '../../../shared/network/remot/dio_helper.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;

  TextEditingController SearchController = TextEditingController();

  void getSearch({String? text}) {
    emit(SearchLoadingStates());
    DioHelper.postData(url: SEARCH, token: token, data: {
      'search': text,
    }).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorStates());
    });
  }

  void clearSearchData() {
    SearchController.clear();
    searchModel ;
  }
}
