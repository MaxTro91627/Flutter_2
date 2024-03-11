import 'package:floor/floor.dart';
import 'package:flutter_2/features/daily_news/data/models/news_model.dart';

@dao
abstract class NewsDao {
  
  @Insert()
  Future<void> insertNews(NewsModel news);
  
  @delete
  Future<void> deleteNews(NewsModel NewsModel);
  
  @Query('SELECT * FROM news')
  Future<List<NewsModel>> getNews();
}