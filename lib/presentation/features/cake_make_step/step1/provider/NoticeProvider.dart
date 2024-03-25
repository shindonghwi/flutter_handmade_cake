import 'package:get_it/get_it.dart';
import 'package:handmade_cake/data/models/notice/ResponseNoticeModel.dart';
import 'package:handmade_cake/domain/usecases/remote/notice/GetNoticesUseCase.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../model/UiState.dart';


final noticeProvider = StateNotifierProvider<NoticeNotifier, UIState<List<ResponseNoticeModel>>>(
      (_) => NoticeNotifier(),
);

class NoticeNotifier extends StateNotifier<UIState<List<ResponseNoticeModel>>> {
  NoticeNotifier() : super(Idle());

  GetNoticesUseCase get _getNotices => GetIt.instance<GetNoticesUseCase>();

  void requestNotices() async {
    state = Loading();

    await _getNotices.call().then((result) {
      if (result.status == 200) {
        state = Success(result.list ?? []);
      } else {
        state = Failure(result.message);
      }
    });
  }

  void init() => state = Idle();
}
