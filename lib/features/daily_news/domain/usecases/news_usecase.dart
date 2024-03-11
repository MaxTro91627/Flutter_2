import 'package:flutter_2/core/resources/data_state.dart';
import 'package:flutter_2/core/usecases/usecase.dart';
import 'package:flutter_2/features/daily_news/domain/entities/news_entity.dart';
import 'package:flutter_2/features/daily_news/domain/repository/news_repository.dart';

// Get

class GetNewsUseCase implements UseCase<DataState<List<NewsEntity>>,void>{
  
  final NewsRepository _newsRepository;

  GetNewsUseCase(this._newsRepository);
  
  @override
  Future<DataState<List<NewsEntity>>> call({void params}) {
    return _newsRepository.getNewsArticles();
  }
}

// Save 

class SaveNewsUseCase implements UseCase<void,NewsEntity>{
  
  final NewsRepository _newsRepository;

  SaveNewsUseCase(this._newsRepository);
  
  @override
  Future<void> call({NewsEntity ? params}) {
    return _newsRepository.saveNews(params!);
  }
  
}

// Remove

class RemoveNewsUseCase implements UseCase<void,NewsEntity>{
  
  final NewsRepository _newsRepository;

  RemoveNewsUseCase(this._newsRepository);
  
  @override
  Future<void> call({NewsEntity ? params}) {
    return _newsRepository.removeNews(params!);
  }
  
}

// Get saved

class GetSavedNewsUseCase implements UseCase<List<NewsEntity>,void>{
  
  final NewsRepository _newsRepository;

  GetSavedNewsUseCase(this._newsRepository);
  
  @override
  Future<List<NewsEntity>> call({void params}) {
    return _newsRepository.getSavedNews();
  }
}