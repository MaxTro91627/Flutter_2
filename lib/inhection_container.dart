import 'package:dio/dio.dart';
import 'package:flutter_2/features/daily_news/data/data_sources/local/app_database.dart';
import 'package:flutter_2/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:flutter_2/features/daily_news/data/repository/news_repository_impl.dart';
import 'package:flutter_2/features/daily_news/domain/repository/news_repository.dart';
import 'package:flutter_2/features/daily_news/domain/usecases/news_usecase.dart';
import 'package:flutter_2/features/daily_news/presentation/bloc/news/local/local_news.dart';
import 'package:flutter_2/features/daily_news/presentation/bloc/news/remote/remote_news.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  sl.registerSingleton<AppDatabase>(database);
  
  sl.registerSingleton<Dio>(Dio());

  sl.registerSingleton<NewsApiService>(NewsApiService(sl()));

  sl.registerSingleton<NewsRepository>(
    NewsRepositoryImpl(sl(), sl())
  );
  
  sl.registerSingleton<GetNewsUseCase>(
    GetNewsUseCase(sl())
  );

  sl.registerSingleton<GetSavedNewsUseCase>(
    GetSavedNewsUseCase(sl())
  );

  sl.registerSingleton<SaveNewsUseCase>(
    SaveNewsUseCase(sl())
  );
  
  sl.registerSingleton<RemoveNewsUseCase>(
    RemoveNewsUseCase(sl())
  );

  sl.registerFactory<RemoteNewsBloc>(
    ()=> RemoteNewsBloc(sl())
  );

  sl.registerFactory<LocalNewsBloc>(
    ()=> LocalNewsBloc(sl(),sl(),sl())
  );

}