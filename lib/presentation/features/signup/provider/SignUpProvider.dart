import 'package:get_it/get_it.dart';
import 'package:handmade_cake/data/data_source/remote/HeaderKey.dart';
import 'package:handmade_cake/data/data_source/remote/Service.dart';
import 'package:handmade_cake/presentation/utils/CollectionUtil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../data/models/me/RequestMeJoinModel.dart';
import '../../../../data/models/me/ResponseMeInfoModel.dart';
import '../../../../domain/usecases/local/app/PostLoginAccessTokenUseCase.dart';
import '../../../../domain/usecases/remote/auth/PostEmailUseCase.dart';
import '../../../../domain/usecases/remote/me/GetMeInfoUseCase.dart';
import '../../../../domain/usecases/remote/me/PostMeJoinUseCase.dart';
import '../../../model/UiState.dart';

final signUpProvider = StateNotifierProvider<SignUpNotifier, UIState<String?>>(
  (_) => SignUpNotifier(),
);

class SignUpNotifier extends StateNotifier<UIState<String?>> {
  SignUpNotifier() : super(Idle<String?>());

  PostMeJoinUseCase get _postMeJoinUseCase => GetIt.instance<PostMeJoinUseCase>();

  PostLoginAccessTokenUseCase get _postLoginAccessToken => GetIt.instance<PostLoginAccessTokenUseCase>();

  GetMeInfoUseCase get _getMeInfoUseCase => GetIt.instance<GetMeInfoUseCase>();

  PostEmailLoginUseCase get _postEmailLoginInUseCase => GetIt.instance<PostEmailLoginUseCase>();

  ResponseMeInfoModel? meInfo;

  // 회원가입 요청
  void requestMeJoin(RequestMeJoinModel model) async {
    state = Loading();
    _postMeJoinUseCase.call(model).then(
      (value) {
        if (value.status == 200) {
          _doEmailLogin(model.email, model.password);
        } else {
          state = Failure(value.message);
        }
      },
    );
  }

  void _doEmailLogin(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final result = await _postEmailLoginInUseCase.call(
      email: email,
      password: password,
    );

    if (result.status == 200) {
      final accessToken = result.data?.accessToken;
      if (!CollectionUtil.isNullEmptyFromString(accessToken)) {
        await _saveAccessToken(accessToken.toString());
      }
      _requestMeInfo();
    } else {
      state = Failure(result.message);
    }
  }

  // 회원가입 성공시, 사용자 정보 호출
  void _requestMeInfo() async {
    state = Loading();
    await Future.delayed(const Duration(seconds: 1));
    _getMeInfoUseCase.call().then(
      (value) async {
        if (value.status == 200 && value.data != null) {
          meInfo = value.data;
          state = Success("");
        } else {
          state = Failure(value.message);
        }
      },
    );
  }

  Future<void> _saveAccessToken(String accessToken) async {
    await _postLoginAccessToken.call(accessToken);
    Service.addHeader(key: HeaderKey.Authorization, value: accessToken);
  }

  void init() => state = Idle();
}
