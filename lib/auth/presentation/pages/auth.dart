import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worldhelps/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:worldhelps/auth/presentation/pages/register.dart';
import 'package:worldhelps/constants/colors.dart';
import 'package:worldhelps/hometemp.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthErrorState) {
          notif(context: context, color: errorColors, text: state.err);
          Navigator.of(context).pop();
        }
        if (state is Authenticated) {
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const HomeScreen()));
        }

        if (state is LoadingState) {
          showDialog(
            context: context,
            builder: (context) => const Center(
              child: CupertinoActivityIndicator(
                color: primaryDark,
              ),
            ),
          );
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is Authenticated) {
            return const HomeScreen();
          } else {
            return RegisterScreen();
          }
        },
      ),
    );
  }

  void notif(
      {required BuildContext context,
      required Color color,
      required String text}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(
          text,
          style: const TextStyle(color: primaryWhite),
        ),
      ),
    );
  }
}
