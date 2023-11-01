import 'dart:async';

import 'package:handmade_cake/data/models/base/ApiListResponse.dart';
import 'package:handmade_cake/data/models/notice/ResponseNoticeModel.dart';

abstract class RemoteNoticeRepository {
  /// 공지사항 목록 조회
  Future<ApiListResponse<List<ResponseNoticeModel>>> getNotices();
}
