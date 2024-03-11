

import 'package:equatable/equatable.dart';
import 'package:flutter_2/features/daily_news/domain/entities/news_entity.dart';
import 'package:flutter_2/features/daily_news/domain/usecases/news_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Bloc

class LocalNewsBloc extends Bloc<LocalNewsEvent,LocalNewsState> {
  final GetSavedNewsUseCase _getSavedNewsUseCase;
  final SaveNewsUseCase _saveNewsUseCase;
  final RemoveNewsUseCase _removeNewsUseCase;

  LocalNewsBloc(
    this._getSavedNewsUseCase,
    this._saveNewsUseCase,
    this._removeNewsUseCase
  ) : super(const LocalNewsLoading()){
    on <GetSavedNews> (onGetSavedNews);
    on <RemoveNews> (onRemoveNews);
    on <SaveNews> (onSaveNews);
  }


  void onGetSavedNews(GetSavedNews event,Emitter<LocalNewsState> emit) async {
    final news = await _getSavedNewsUseCase();
    emit(LocalNewsDone(news));
  }
  
  void onRemoveNews(RemoveNews removeNews,Emitter<LocalNewsState> emit) async {
    await _removeNewsUseCase(params: removeNews.news);
    final news = await _getSavedNewsUseCase();
    emit(LocalNewsDone(news));
  }

  void onSaveNews(SaveNews saveNews,Emitter<LocalNewsState> emit) async {
    await _saveNewsUseCase(params: saveNews.news);
    final news = await _getSavedNewsUseCase();
    emit(LocalNewsDone(news));
  }
}

// State

abstract class LocalNewsState extends Equatable {
  final List<NewsEntity> ? news;

  const LocalNewsState({this.news});

  @override
  List<Object> get props => [news!];
}

class LocalNewsLoading extends LocalNewsState {
  const LocalNewsLoading();
}

class LocalNewsDone extends LocalNewsState {
  const LocalNewsDone(List<NewsEntity> news) : super(news: news);
}

// Event 

abstract class LocalNewsEvent extends Equatable {
  final NewsEntity ? news;

  const LocalNewsEvent({this.news});

  @override
  List<Object> get props => [news!];
}

class GetSavedNews extends LocalNewsEvent {
  const GetSavedNews();
}

class RemoveNews extends LocalNewsEvent {
  const RemoveNews(NewsEntity news) : super(news: news);
}

class SaveNews extends LocalNewsEvent {
  const SaveNews(NewsEntity news) : super(news: news);
}