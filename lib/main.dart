import 'package:flutter/material.dart';
import 'package:flutter_2/config/routes/routes.dart';
import 'package:flutter_2/config/theme/app_theme.dart';
import 'package:flutter_2/features/daily_news/presentation/bloc/news/remote/remote_news.dart';
import 'package:flutter_2/features/daily_news/presentation/pages/daily_news.dart';
import 'package:flutter_2/inhection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteNewsBloc>(
      create: (context) => sl()..add(const GetNews()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme(),
        onGenerateRoute: AppRoutes.onGenerateRoutes,
        home: const DailyNews()
      ),
    );
  }
}

