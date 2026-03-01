import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mypoly/generate/bills/api/category_api.dart';
import 'package:mypoly/generate/bills/model/category_response.dart';
import 'package:mypoly/util/error.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class CategoryService {
  // ignore: unused_field
  final Ref _ref;
  final CategoryApi _categoryApi;

  CategoryService(this._ref, this._categoryApi);

  Future<List<CategoryResponse>> getCategories() async {
    try {
      final response = await _categoryApi.getCategories();

      return response;
    } on DioException catch (e) {
      return Future.error(getErrorMessage(e));
    } catch (e) {
      debugPrint(e.toString());
      return Future.error("error");
    }
  }
}
