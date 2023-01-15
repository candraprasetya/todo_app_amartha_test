import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo_app_amartha_test/src/utilities/utilities.dart';

import 'cubits/cubits.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AddTaskCubit()),
        BlocProvider(create: (context) => UpdateCompleteTaskCubit()),
        BlocProvider(create: (context) => DeleteTaskCubit()),
      ],
      child: MaterialApp.router(
        routerConfig: router,
      ),
    );
  }
}
