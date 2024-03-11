import 'package:dio/dio.dart';
import 'package:flutter_2/core/constants/constants.dart';
import 'package:flutter_2/features/daily_news/data/models/news_model.dart';
import 'package:retrofit/retrofit.dart';
part 'news_api_service.g.dart';

@RestApi(baseUrl:newsAPIBaseURL)
abstract class NewsApiService {
  factory NewsApiService(Dio dio) = _NewsApiService;
  
  @GET('/top-headlines')
  Future<HttpResponse<List<NewsModel>>> getNewsArticles({
    @Query("apiKey") String ? apiKey,
    @Query("country") String ? country,
    @Query("category") String ? category,
  });
}