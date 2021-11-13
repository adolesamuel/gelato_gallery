import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'core/helpers/json_checker.dart';
import 'core/network_info/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features

//Blocs
  //Hymns Bloc
  // sl.registerFactory(() => HymnBloc(
  //       getHymns: sl(),
  //       getSingleHymn: sl(),
  //       getHymnCategories: sl(),
  //       cacheHymnsList: sl(),
  //       getCachedHymnsList: sl(),
  //       searchHymns: sl(),
  //     ));

  ///////////////////////////////////////////////////////////////////////////////////
  /// Application [USECASES]
  ///////////////////////////////////////////////////////////////////////////////////

  //Hymns Usecases
  // sl.registerLazySingleton(() => GetHymns(sl()));
  // sl.registerLazySingleton(() => GetSingleHymn(sl()));
  // sl.registerLazySingleton(() => GetHymnCategories(sl()));
  // sl.registerLazySingleton(() => CacheHymnsList(sl()));
  // sl.registerLazySingleton(() => GetCachedHymnsList(sl()));
  // sl.registerLazySingleton(() => SearchHymns(sl()));

  //songs usecases

  ///////////////////////////////////////////////////////////////////////////////////
  /// Application [REPOSITORIES]
  ///////////////////////////////////////////////////////////////////////////////////

  // //Hymn Repository
  // sl.registerLazySingleton<HymnRepository>(() => HymnRepositoryImpl(
  //       hymnsRemoteDataSource: sl(),
  //       networkInfo: sl(),
  //       hymnsLocalDataSource: sl(),
  //     ));

  ///////////////////////////////////////////////////////////////////////////////////
  ///Application [DATA_SOURCES]
  ///////////////////////////////////////////////////////////////////////////////////

  // //Hymns Data Sources
  // sl.registerLazySingleton<HymnsRemoteDataSource>(
  //     () => HymnsRemoteDataSourceImpl(sl(), sl()));
  // sl.registerLazySingleton<HymnsLocalDataSource>(
  //     () => HymnsLocalDataSourceImpl(sl()));

  ///////////////////////////////////////////////////////////////////////////////////

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<JsonChecker>(() => JsonCheckerImpl(sl()));

  //! External
  // final sharedPreferences = await SharedPreferences.getInstance();
  // sl.registerLazySingleton(() => sharedPreferences);
  // sl.registerLazySingleton(
  //     () => AudioManager()); //registering audiomanager without playlist or url
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => json);
}
