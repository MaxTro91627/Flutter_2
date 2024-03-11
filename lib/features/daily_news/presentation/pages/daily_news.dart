import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_2/features/daily_news/domain/entities/news_entity.dart';
import 'package:flutter_2/features/daily_news/presentation/bloc/news/remote/remote_news.dart';
import 'package:flutter_2/features/daily_news/presentation/widgets/news_tile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({Key? key}) : super(key: key);

  @override
  Widget build (BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text(
          'Daily News',
          style: TextStyle(
            color: Colors.black
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () => _onShowSavedNewsViewTapped(context),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Icon(Icons.thumb_up, color: Colors.black),
            ),
          ),
        ],
    );
  }

  _buildBody() {
    return BlocBuilder<RemoteNewsBloc,RemoteNewsState> (
      builder: (_,state) {
        if (state is RemoteNewsLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }
        if (state is RemoteNewsError) {
          return const Center(child: Icon(Icons.refresh));
        }
        if (state is RemoteNewsDone) {
          return ListView.builder(
           itemBuilder: (context,index){
            return NewsWidget(
              news: state.news![index] ,
              onNewsPressed: (news) => _onNewsPressed(context,news),
            );
           },
           itemCount: state.news!.length,
         );
        }
        return const SizedBox();
      },
    );
  }
  
  void _onNewsPressed(BuildContext context, NewsEntity news) {
    Navigator.pushNamed(context, '/NewsDetails', arguments: news);
  }

  void _onShowSavedNewsViewTapped(BuildContext context) {
    Navigator.pushNamed(context, '/SavedNews');
  }
}