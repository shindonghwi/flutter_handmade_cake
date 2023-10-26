import 'package:flutter/material.dart';
import 'package:handmade_cake/data/data_source/remote/HeaderKey.dart';
import 'package:handmade_cake/data/data_source/remote/Service.dart';
import 'package:handmade_cake/data/models/me/ResponseMeInfoModel.dart';
import 'package:riverpod/riverpod.dart';

final meInfoProvider = StateNotifierProvider<MeInfoNotifier, ResponseMeInfoModel?>(
  (_) => MeInfoNotifier(),
);

class MeInfoNotifier extends StateNotifier<ResponseMeInfoModel?> {
  MeInfoNotifier() : super(null);

  void updateMeInfo(ResponseMeInfoModel? meInfo) async {
    Service.addHeader(key: HeaderKey.XUserId, value: meInfo?.memberId.toString() ?? "");
    debugPrint("updateMeInfo : $meInfo");
    state = meInfo;
  }
}
