import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_project/models/deterministic_qs.dart';
import 'package:q_project/shared/cubit.dart';

import 'modules/deterministic_qs_ui.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<QCubit>(
          create: (context) => QCubit(),
        ),
      ],
      child:MaterialApp(
        home: DD1K(),
      )
    ),
  );
}
