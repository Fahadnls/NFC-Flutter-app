import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/api/logging_interceptor.dart';
import '../utils/app_logger.dart';
import '../../domain/providers/shared_prefrence.dart';
import '../../domain/providers/storage_service.dart';

final sl = GetIt.instance;

Future<void> initDependencyInjection() async {
  if (sl.isRegistered<SharedPreferences>()) {
    return;
  }
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);
  sl.registerLazySingleton<AppLogger>(() => AppLogger());
  sl.registerLazySingleton<StorageService>(() => SharedPrefsStorage(sl()));
  sl.registerLazySingleton<Dio>(() {
    final dio = Dio();
    dio.interceptors.add(LoggingInterceptor());
    return dio;
  });
}
