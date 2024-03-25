import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:handmade_cake/data/data_source/remote/HeaderKey.dart';
import 'package:handmade_cake/data/data_source/remote/Service.dart';
import 'package:handmade_cake/domain/usecases/local/app/GetLoginAccessTokenUseCase.dart';
import 'package:handmade_cake/domain/usecases/remote/me/GetMeInfoUseCase.dart';
import 'package:handmade_cake/navigation/PageMoveUtil.dart';
import 'package:handmade_cake/navigation/Route.dart';
import 'package:handmade_cake/presentation/components/utils/BaseScaffold.dart';
import 'package:handmade_cake/presentation/components/utils/Clickable.dart';
import 'package:handmade_cake/presentation/features/sign_in/provider/MeInfoProvider.dart';
import 'package:handmade_cake/presentation/ui/colors.dart';
import 'package:handmade_cake/presentation/utils/CollectionUtil.dart';
import 'package:handmade_cake/presentation/utils/Common.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SplashScreen extends HookConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final meInfoManager = ref.read(meInfoProvider.notifier);

    void movePage(RoutingScreen screen) async {
      Future.delayed(const Duration(milliseconds: 300), () async {
        Navigator.pushReplacement(
          context,
          nextFadeInOutScreen(screen.route),
        );
      });
    }

    Future<RoutingScreen> runAutoLogin() async {
      final accessToken = await GetIt.instance<GetLoginAccessTokenUseCase>().call();

      if (!CollectionUtil.isNullEmptyFromString(accessToken)) {
        Service.addHeader(key: HeaderKey.Authorization, value: accessToken);
        final result = await GetIt.instance<GetMeInfoUseCase>().call();

        if (result.status == 200 && result.data != null) {
          meInfoManager.updateMeInfo(result.data);
          return RoutingScreen.Main;
        }
      }

      return RoutingScreen.SignIn;
    }

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        movePage(await runAutoLogin());
      });
      return;
    }, const []);

    return BaseScaffold(
      backgroundColor: getColorScheme(context).colorPrimary500,
      body: Center(
        child: SvgPicture.asset(
          "assets/imgs/splash_logo.svg",
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
