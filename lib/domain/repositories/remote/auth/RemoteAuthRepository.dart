import 'dart:async';

import '../../../../data/models/auth/RequestEmailLoginModel.dart';
import '../../../../data/models/base/ApiResponse.dart';
import '../../../../data/models/auth/ResponseLoginModel.dart';

abstract class RemoteAuthRepository {
  /// 로그인
  Future<ApiResponse<ResponseLoginModel>> postEmailLogin({
    required RequestEmailLoginModel requestEmailLoginModel,
  });

  /// 로그아웃
  Future<ApiResponse<void>> postLogout();
}
