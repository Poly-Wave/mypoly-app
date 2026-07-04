import 'package:dio/dio.dart';
import 'package:mypoly/enum/gender.dart';
import 'package:mypoly/generate/users/api/user_api.dart';
import 'package:mypoly/generate/users/model/address_search_response.dart';
import 'package:mypoly/generate/users/model/nickname_availability_response.dart';
import 'package:mypoly/generate/users/model/update_onboarding_status_request.dart';
import 'package:mypoly/generate/users/model/user_me_response.dart';
import 'package:mypoly/generate/users/model/user_update_basic_profile_request.dart';
import 'package:mypoly/generate/users/model/user_update_profile_request.dart';
import 'package:mypoly/generate/users/model/user_withdraw_request.dart';
import 'package:mypoly/provider/app_user_provider.dart';
import 'package:mypoly/util/error.dart';
import 'package:mypoly/util/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class UserService {
  final Ref _ref;
  final UserApi _userApi;

  UserService(this._ref, this._userApi);

  Future<NicknameAvailabilityResponseStatusEnum> checkNickname(
    String nickname,
  ) async {
    try {
      final response = await _userApi.checkNicknameAvailability(
        nickname: nickname,
      );

      return response.status;
    } on DioException catch (e) {
      return Future.error(getErrorMessage(e));
    } catch (e) {
      AppLogger.instance.talker.handle(e);
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
      AppLogger.instance.talker.handle(e);
      return Future.error("error");
    }
  }

  Future<void> deleteMe() async {
    try {
      return await _userApi.deleteMe();
    } on DioException catch (e) {
      return Future.error(getErrorMessage(e));
    } catch (e) {
      AppLogger.instance.talker.handle(e);
      return Future.error("error");
    }
  }

  Future<void> withdraw({
    required List<UserWithdrawRequestReasonsEnum> reasons,
    required String etcText,
  }) async {
    try {
      return await _userApi.withdraw(
        userWithdrawRequest: UserWithdrawRequest(
          reasons: reasons,
          etcText: etcText,
        ),
      );
    } on DioException catch (e) {
      return Future.error(getErrorMessage(e));
    } catch (e) {
      AppLogger.instance.talker.handle(e);
      return Future.error("error");
    }
  }

  Future<UserMeResponse> getMe() async {
    try {
      return await _userApi.getMe();
    } on DioException catch (e) {
      return Future.error(getErrorMessage(e));
    } catch (e) {
      AppLogger.instance.talker.handle(e);
      return Future.error("error");
    }
  }

  Future<void> updateProfile({
    required String nickname,
    required Gender gender,
    required String birthDate,
    required String sido,
    required String sigungu,
    required String emdName,
  }) async {
    try {
      return await _userApi.updateBasicProfile(
        userUpdateBasicProfileRequest: UserUpdateBasicProfileRequest(
          nickname: nickname,
          gender: gender.updateBasicProfile,
          birthDate: birthDate,
          sido: sido,
          sigungu: sigungu,
          emdName: emdName,
        ),
      );
    } on DioException catch (e) {
      return Future.error(getErrorMessage(e));
    } catch (e) {
      AppLogger.instance.talker.handle(e);
      return Future.error("error");
    }
  }

  Future<void> updateOnboardProfile({
    required Gender gender,
    required String birthDate,
    required String sido,
    required String sigungu,
    required String emdName,
  }) async {
    try {
      return await _userApi.updateProfile(
        userUpdateProfileRequest: UserUpdateProfileRequest(
          gender: gender.updateProfile,
          birthDate: birthDate,
          sido: sido,
          sigungu: sigungu,
          emdName: emdName,
        ),
      );
    } on DioException catch (e) {
      return Future.error(getErrorMessage(e));
    } catch (e) {
      AppLogger.instance.talker.handle(e);
      return Future.error("error");
    }
  }

  Future<void> updateOnboardStatus(
    UpdateOnboardingStatusRequestOnboardingStatusEnum status,
  ) async {
    final userId = _ref.read(appUserProvider)?.userId ?? 0;

    try {
      return await _userApi.updateOnboardingStatus(
        userId: userId,
        updateOnboardingStatusRequest: UpdateOnboardingStatusRequest(
          onboardingStatus: status,
        ),
      );
    } on DioException catch (e) {
      return Future.error(getErrorMessage(e));
    } catch (e) {
      AppLogger.instance.talker.handle(e);
      return Future.error("error");
    }
  }

  Future<AddressSearchResponse> searchAddress({
    required String keyword,
    required int page,
    int size = 40,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _userApi.searchAddress(
        keyword: keyword,
        currentPage: "$page",
        countPerPage: "$size",
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      return Future.error(getErrorMessage(e));
    } catch (e) {
      AppLogger.instance.talker.handle(e);
      return Future.error("error");
    }
  }
}
