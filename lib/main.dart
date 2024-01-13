import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:worldhelps/auth/data/repositories/auth_repository.dart';
import 'package:worldhelps/firebase_options.dart';
import 'package:worldhelps/splash_screen.dart';
import 'package:worldhelps/theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth/presentation/blocs/auth/auth_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: BlocProvider(
        create: (context) => AuthBloc(
          authRepository: RepositoryProvider.of<AuthRepository>(context),
        ),
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
