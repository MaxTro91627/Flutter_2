import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_2/core/constants/constants.dart';
import 'package:flutter_2/core/resources/data_state.dart';
import 'package:flutter_2/features/daily_news/data/data_sources/local/app_database.dart';
import 'package:flutter_2/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:flutter_2/features/daily_news/data/models/news_model.dart';
import 'package:flutter_2/features/daily_news/domain/entities/news_entity.dart';
import 'package:flutter_2/features/daily_news/domain/repository/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsApiService _newsApiService;
  final AppDatabase _appDatabase;
  NewsRepositoryImpl(this._newsApiService,this._appDatabase);
  
    @override
  Future<DataState<List<NewsModel>>> getNewsArticles() async {
   try {
    final httpResponse = await _newsApiService.getNewsArticles(
      apiKey:newsAPIKey,
      country:country,
      category:category,
    );

    if (httpResponse.response.statusCode == HttpStatus.ok) {
      return DataSuccess(httpResponse.data);
    } else {
      return DataFailed(
        DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioErrorType.response,
          requestOptions: httpResponse.response.requestOptions
        )
      );
    }
   } on DioError catch(e){
    return DataFailed(e);
   }
  }

  @override
  Future<List<NewsEntity>> getSavedNews() async {
    return _appDatabase.NewsDAO.getNews();
  }

  @override
  Future<void> removeNews(NewsEntity news) {
    return _appDatabase.NewsDAO.deleteNews(NewsModel.fromEntity(news));
  }

  @override
  Future<void> saveNews(NewsEntity news) {
    return _appDatabase.NewsDAO.insertNews(NewsModel.fromEntity(news));
  }
}