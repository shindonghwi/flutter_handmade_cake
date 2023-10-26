import 'package:get_it/get_it.dart';
import 'package:handmade_cake/data/data_source/remote/HeaderKey.dart';
import 'package:handmade_cake/data/data_source/remote/Service.dart';
import 'package:handmade_cake/presentation/model/UiState.dart';
import 'package:handmade_cake/presentation/utils/CollectionUtil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../data/models/me/ResponseMeInfoModel.dart';
import '../../../../domain/usecases/local/app/PostLoginAccessTokenUseCase.dart';
import '../../../../domain/usecases/remote/auth/PostEmailUseCase.dart';
import '../../../../domain/usecases/remote/me/GetMeInfoUseCase.dart';

final loginProvider = StateNotifierProvider<LoginUiStateNotifier, UIState<String?>>(
  (_) => LoginUiStateNotifier(),
);

class LoginUiStateNotifier extends StateNotifier<UIState<String?>> {
  LoginUiStateNotifier() : super(Idle<String?>());

  PostEmailLoginUseCase get _postEmailLoginInUseCase => GetIt.instance<PostEmailLoginUseCase>();

  PostLoginAccessTokenUseCase get _postLoginAccessToken => GetIt.instance<PostLoginAccessTokenUseCase>();

  GetMeInfoUseCase get _getMeInfoUseCase => GetIt.instance<GetMeInfoUseCase>();

  ResponseMeInfoModel? meInfo;

  String _email = "";
  String _password = "";

  void updateEmail(String text) => _email = text;

  void updatePassword(String text) => _password = text;

  void doEmailLogin({String? email, String? password}) async {
    state = Loading();

    final result = await _postEmailLoginInUseCase.call(
      email: email ?? _email,
      password: password ?? _password,
    );

    if (result.status == 200) {
      final accessToken = result.data?.accessToken;
      if (!CollectionUtil.isNullEmptyFromString(accessToken)) {
        await saveAccessToken(accessToken.toString());
      }
      requestMeInfo();
    } else {
      state = Failure(result.message);
    }
  }

  // 로그인 성공시, 사용자 정보 호출
  void requestMeInfo() {
    _getMeInfoUseCase.call().then(
      (value) {
        if (value.status == 200 && value.data != null) {
          meInfo = value.data;
          state = Success("");
        } else {
          state = Failure(value.message);
        }
      },
    );
  }

  Future<void> saveAccessToken(String accessToken) async {
    await _postLoginAccessToken.call(accessToken);
    Service.addHeader(key: HeaderKey.Authorization, value: accessToken);
  }

  void init() => state = Idle();
}
