import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mypoly/generate/users/api/user_api.dart';
import 'package:mypoly/util/error.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class UserService {
  // ignore: unused_field
  final Ref _ref;
  final UserApi _userApi;

  UserService(this._ref, this._userApi);

  Future<bool> checkNickname(String nickname) async {
    try {
      final response = await _userApi.checkNicknameAvailability(
        nickname: nickname,
      );

      return response.available;
    } on DioException catch (e) {
      return Future.error(getErrorMessage(e));
    } catch (e) {
      debugPrint(e.toString());
      return Future.error("error");
    }
  }

  Future<String> randomeNickname() async {
    try {
      final response = await _userApi.getRandomNickname();

      return response.nickname;
    } on DioException catch (e) {
      return Future.error(getErrorMessage(e));
    } catch (e) {
      debugPrint(e.toString());
      return Future.error("error");
    }
  }
}
