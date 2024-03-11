import 'package:flutter/material.dart';
import 'package:flutter_2/features/daily_news/domain/entities/news_entity.dart';
import 'package:flutter_2/features/daily_news/presentation/pages/news_detail.dart';
import 'package:flutter_2/features/daily_news/presentation/pages/daily_news.dart';
import 'package:flutter_2/features/daily_news/presentation/pages/saved_news.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const DailyNews());

      case '/NewsDetails':
        return _materialRoute(NewsDetailsView(news: settings.arguments as NewsEntity));

      case '/SavedNews':
        return _materialRoute(const SavedNews());
        
      default:
        return _materialRoute(const DailyNews());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}