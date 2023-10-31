import 'package:get_it/get_it.dart';
import 'package:handmade_cake/data/data_source/local/app/LocalAppApi.dart';
import 'package:handmade_cake/data/data_source/remote/auth/RemoteAuthApi.dart';
import 'package:handmade_cake/data/data_source/remote/me/RemoteMeApi.dart';
import 'package:handmade_cake/data/data_source/remote/order/RemoteOrderApi.dart';
import 'package:handmade_cake/data/repositories/local/app/LocalAppRepositoryImpl.dart';
import 'package:handmade_cake/data/repositories/remote/auth/RemoteAuthRepositoryImpl.dart';
import 'package:handmade_cake/data/repositories/remote/me/RemoteMeRepositoryImpl.dart';
import 'package:handmade_cake/data/repositories/remote/order/RemoteOrderRepositoryImpl.dart';
import 'package:handmade_cake/domain/repositories/local/app/LocalAppRepository.dart';
import 'package:handmade_cake/domain/repositories/remote/auth/RemoteAuthRepository.dart';
import 'package:handmade_cake/domain/repositories/remote/me/RemoteMeRepository.dart';
import 'package:handmade_cake/domain/repositories/remote/order/RemoteOrderRepository.dart';
import 'package:handmade_cake/domain/usecases/local/app/GetLoginAccessTokenUseCase.dart';
import 'package:handmade_cake/domain/usecases/local/app/PostLoginAccessTokenUseCase.dart';
import 'package:handmade_cake/domain/usecases/remote/auth/PostEmailUseCase.dart';
import 'package:handmade_cake/domain/usecases/remote/auth/PostLogoutUseCase.dart';
import 'package:handmade_cake/domain/usecases/remote/me/GetMeInfoUseCase.dart';
import 'package:handmade_cake/domain/usecases/remote/me/PatchMePwUseCase.dart';
import 'package:handmade_cake/domain/usecases/remote/me/PostMeJoinUseCase.dart';
import 'package:handmade_cake/domain/usecases/remote/me/PostMeLeaveUseCase.dart';
import 'package:handmade_cake/domain/usecases/remote/order/PostImageUseCase.dart';
import 'package:handmade_cake/domain/usecases/remote/order/PostOrderIndentUseCase.dart';
import 'package:handmade_cake/presentation/utils/Common.dart';

final serviceLocator = GetIt.instance;

void initServiceLocator() {
  /// -------
  /// common
  /// -------
  GetIt.instance.registerLazySingleton<AppLocalization>(() => AppLocalization());

  /// -------
  /// usecase
  /// -------

  // local
  GetIt.instance.registerLazySingleton<GetLoginAccessTokenUseCase>(() => GetLoginAccessTokenUseCase());
  GetIt.instance.registerLazySingleton<PostLoginAccessTokenUseCase>(() => PostLoginAccessTokenUseCase());

  // auth
  GetIt.instance.registerLazySingleton<PostEmailLoginUseCase>(() => PostEmailLoginUseCase());
  GetIt.instance.registerLazySingleton<PostLogoutUseCase>(() => PostLogoutUseCase());

  // me
  GetIt.instance.registerLazySingleton<GetMeInfoUseCase>(() => GetMeInfoUseCase());
  GetIt.instance.registerLazySingleton<PatchMePwUseCase>(() => PatchMePwUseCase());
  GetIt.instance.registerLazySingleton<PostMeJoinUseCase>(() => PostMeJoinUseCase());
  GetIt.instance.registerLazySingleton<PostMeLeaveUseCase>(() => PostMeLeaveUseCase());

  // order
  GetIt.instance.registerLazySingleton<PostImageUseCase>(() => PostImageUseCase());
  GetIt.instance.registerLazySingleton<PostOrderIndentUseCase>(() => PostOrderIndentUseCase());

  /// -------
  /// repository
  /// -------
  GetIt.instance.registerLazySingleton<LocalAppRepository>(() => LocalAppRepositoryImpl());
  GetIt.instance.registerLazySingleton<RemoteMeRepository>(() => RemoteMeRepositoryImpl());
  GetIt.instance.registerLazySingleton<RemoteAuthRepository>(() => RemoteAuthRepositoryImpl());
  GetIt.instance.registerLazySingleton<RemoteOrderRepository>(() => RemoteOrderRepositoryImpl());

  /// -------
  /// api
  /// -------
  GetIt.instance.registerLazySingleton<LocalAppApi>(() => LocalAppApi());
  GetIt.instance.registerLazySingleton<RemoteAuthApi>(() => RemoteAuthApi());
  GetIt.instance.registerLazySingleton<RemoteMeApi>(() => RemoteMeApi());
  GetIt.instance.registerLazySingleton<RemoteOrderApi>(() => RemoteOrderApi());
}
