import 'package:floor/floor.dart';
import 'package:flutter_2/features/daily_news/data/data_sources/local/DAO/news_dao.dart';
import 'package:flutter_2/features/daily_news/data/models/news_model.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';
part 'app_database.g.dart';

@Database(version: 1, entities: [NewsModel])
abstract class AppDatabase extends FloorDatabase {
  NewsDao get NewsDAO;
}