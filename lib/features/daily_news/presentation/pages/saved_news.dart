import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_2/features/daily_news/domain/entities/news_entity.dart';
import 'package:flutter_2/features/daily_news/presentation/bloc/news/local/local_news.dart';
import 'package:flutter_2/features/daily_news/presentation/widgets/news_tile.dart';
import 'package:flutter_2/inhection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ionicons/ionicons.dart';

class SavedNews extends HookWidget {
  const SavedNews({Key ? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LocalNewsBloc>()..add(const GetSavedNews()),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: Builder(
        builder: (context) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _onBackButtonTapped(context),
          child: const Icon(Ionicons.chevron_back, color: Colors.black),
        ),
      ),
      title: const Text('Saved News', style: TextStyle(color: Colors.black)),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<LocalNewsBloc, LocalNewsState>(
      builder: (context, state) {
        if (state is LocalNewsLoading) {
          return const Center(child: CupertinoActivityIndicator());
        } else if (state is LocalNewsDone) {
          return _buildNewsList(state.news!);
        }
        return Container();
      },
    );
  }

  Widget _buildNewsList(List<NewsEntity> news) {
    if (news.isEmpty) {
      return const Center(
          child: Text(
        'NO SAVED NEWS',
        style: TextStyle(color: Colors.black),
      ));
    }

    return ListView.builder(
      itemCount: news.length,
      itemBuilder: (context, index) {
        return NewsWidget(
          news: news[index],
          isRemovable: true,
          onRemove: (news) => _onRemoveNews(context, news),
          onNewsPressed: (news) => _onNewsPressed(context, news),
        );
      },
    );
  }

  void _onBackButtonTapped(BuildContext context) {
    Navigator.pop(context);
  }

  void _onRemoveNews(BuildContext context, NewsEntity news) {
    BlocProvider.of<LocalNewsBloc>(context).add(RemoveNews(news));
  }

  void _onNewsPressed(BuildContext context, NewsEntity news) {
    Navigator.pushNamed(context, '/NewsDetails', arguments: news);
  }
}