import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handmade_cake/data/models/notice/ResponseNoticeModel.dart';
import 'package:handmade_cake/presentation/components/button/PrimaryFilledButton.dart';
import 'package:handmade_cake/presentation/ui/colors.dart';
import 'package:handmade_cake/presentation/ui/typography.dart';
import 'package:handmade_cake/presentation/utils/Common.dart';

class PopupNotice extends HookWidget {
  final List<ResponseNoticeModel> items;

  const PopupNotice({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              "공지사항",
              style: getTextTheme(context).bold.copyWith(
                    fontSize: 20,
                    color: getColorScheme(context).black,
                  ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            height: 250,
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                final noticeItem = items[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      noticeItem.title,
                      style: getTextTheme(context).bold.copyWith(
                            fontSize: 20,
                            color: getColorScheme(context).black,
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        noticeItem.createdDate,
                        style: getTextTheme(context).regular.copyWith(
                              fontSize: 10,
                              color: getColorScheme(context).black,
                            ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 8.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: getColorScheme(context).colorGray300,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          noticeItem.content,
                          style: getTextTheme(context).medium.copyWith(
                                fontSize: 12,
                                color: getColorScheme(context).black,
                              ),
                        ),
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return Container(
                  width: double.infinity,
                  height: 1,
                  margin: const EdgeInsets.symmetric(vertical: 12.0),
                  color: getColorScheme(context).colorGray300,
                );
              },
              itemCount: items.length,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              "케이크 주문은 최소 3일 이전에 카카오톡 또는 인스타그램으로 주문 부탁드립니다.\n감사합니다.",
              style: getTextTheme(context).regular.copyWith(
                    fontSize: 10,
                    color: getColorScheme(context).colorGray500,
                    overflow: TextOverflow.visible,
                  ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: PrimaryFilledButton.normalRect(
              content: Text(
                "닫기",
                style: getTextTheme(context).semiBold.copyWith(
                      color: getColorScheme(context).white,
                    ),
              ),
              isActivated: true,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }
}
