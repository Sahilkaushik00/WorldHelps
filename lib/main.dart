import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:worldhelps/auth/data/repositories/auth_repository.dart';
import 'package:worldhelps/firebase_options.dart';
import 'package:worldhelps/splash_screen.dart';
import 'package:worldhelps/theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worldhelps/user/data/repositories/post_repo.dart';
import 'package:worldhelps/user/presentation/manager/post_bloc/post_bloc.dart';
import 'auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'user/data/local/models/user.dart';
import 'user/data/repositories/user_repository.dart';
import 'user/presentation/manager/user_bloc/user_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  await Hive.openBox('user');
  Hive.registerAdapter(UserModelAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider(
          create: (context) => UserRepository(),
        ),
        RepositoryProvider(
          create: (context) => PostRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              authRepository:RepositoryProvider.of<AuthRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => UserBloc(
              userRepository:RepositoryProvider.of<UserRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => PostBloc(
              postRepository:RepositoryProvider.of<PostRepository>(context),
            ),
          ),

        ],
        child: MaterialApp(
          title: 'World help',
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
