import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_2/core/resources/data_state.dart';
import 'package:flutter_2/features/daily_news/domain/entities/news_entity.dart';
import 'package:flutter_2/features/daily_news/domain/usecases/news_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Bloc

class RemoteNewsBloc extends Bloc<RemoteNewsEvent,RemoteNewsState> {
  
  final GetNewsUseCase _getNewsUseCase;
  
  RemoteNewsBloc(this._getNewsUseCase) : super(const RemoteNewsLoading()){
    on <GetNews> (onGetNews);
  }


  void onGetNews(GetNews event, Emitter < RemoteNewsState > emit) async {
    final dataState = await _getNewsUseCase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(
        RemoteNewsDone(dataState.data!)
      );
    }
    
    if (dataState is DataFailed) {
      // print(dataState.error!.message);
      emit(
        RemoteNewsError(dataState.error!)
      );
    }
  }
}

// State 

abstract class RemoteNewsState extends Equatable {
  final List<NewsEntity> ? news;
  final DioError ? error;
  
  const RemoteNewsState({this.news,this.error});
  
  @override
  List<Object> get props => [news!, error!];
}

class RemoteNewsLoading extends RemoteNewsState {
  const RemoteNewsLoading();
}

class RemoteNewsDone extends RemoteNewsState {
  const RemoteNewsDone(List<NewsEntity> news) : super(news: news);
}

class RemoteNewsError extends RemoteNewsState {
  const RemoteNewsError(DioError error) : super(error: error);
}

// Event

abstract class RemoteNewsEvent {
  const RemoteNewsEvent();
}

class GetNews extends RemoteNewsEvent {
  const GetNews();
}