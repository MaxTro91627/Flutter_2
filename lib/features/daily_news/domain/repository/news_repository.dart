import 'package:flutter_2/core/resources/data_state.dart';
import 'package:flutter_2/features/daily_news/domain/entities/news_entity.dart';

abstract class NewsRepository {
  Future<DataState<List<NewsEntity>>> getNewsArticles();

  Future < List < NewsEntity >> getSavedNews();

  Future < void > saveNews(NewsEntity news);

  Future < void > removeNews(NewsEntity news);
}