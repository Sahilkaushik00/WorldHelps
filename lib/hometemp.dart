import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worldhelps/auth/presentation/blocs/auth/auth_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _authbloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () => _authbloc.add(LogoutEvent()),
            child: const Text("Logout")),
      ),
    );
  }
}
