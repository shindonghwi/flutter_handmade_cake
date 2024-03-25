import 'dart:async';

import '../../../../data/models/base/ApiResponse.dart';
import '../../../../data/models/me/RequestMeJoinModel.dart';
import '../../../../data/models/me/ResponseMeInfoModel.dart';

abstract class RemoteMeRepository {
  /// 내 정보 요청
  Future<ApiResponse<ResponseMeInfoModel>> getMe();

  /// 비밀번호 수정
  Future<ApiResponse<void>> patchPw(String password);

  /// 이메일 회원가입
  Future<ApiResponse<void>> postJoin(RequestMeJoinModel model);

  /// 계정 삭제
  Future<ApiResponse<void>> postMeLeave();
}
