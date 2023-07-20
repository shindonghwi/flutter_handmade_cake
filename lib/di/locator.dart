import 'package:get_it/get_it.dart';
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


  /// -------
  /// repository
  /// -------

  /// -------
  /// api
  /// -------
}
