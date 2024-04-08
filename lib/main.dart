import 'package:bot/core/routes.dart';
import 'package:bot/data/repository/message_repository.dart';
import 'package:bot/logic/message_bloc/bloc/message_bloc.dart';
import 'package:bot/presentation/master_screen/master_screen.dart';
import 'package:bot/presentation/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MessageBloc(MessageRepository()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        onGenerateRoute: Routes.onGenerateRoute,
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.white,
          textTheme: Typography.whiteHelsinki,
        ),
        home: MasterScreen(),
      ),
    );
  }
}
