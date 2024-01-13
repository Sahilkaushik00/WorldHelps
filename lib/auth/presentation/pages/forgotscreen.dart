import 'package:flutter/material.dart';
// import 'package:worldhelps/auth/presentation/pages/loginscreen.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worldhelps/common/widgets/customtextfield.dart';
import 'package:worldhelps/constants/colors.dart';

// import '../blocs/auth/auth_bloc.dart';

class ForgotScreen extends StatelessWidget {
  ForgotScreen({super.key});
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.of(context).size.height;

    // final _authbloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: primaryWhite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // topbar
              Container(
                height: ht * 0.25,
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                alignment: Alignment.bottomLeft,
                decoration: const BoxDecoration(
                  color: primaryDark,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: const Text(
                  "Forgor your \n Password ?",
                  style: TextStyle(color: primaryWhite, fontSize: 32),
                ),
              ),
              const SizedBox(height: 20),
              // email
              titletext("Email"),
              CustomTextField(
                controller: emailController,
                ispass: false,
                hintText: "Email",
                keyboardType: TextInputType.emailAddress,
                onFieldSubmitted: (p0) => FocusScope.of(context).nextFocus(),
              ),
              const SizedBox(height: 20),

              // register button
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: ElevatedButton(
                    child: const Text("Send Mail"),
                    onPressed: () {},
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Remember password"),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text("Login"),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding titletext(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        title,
        style: const TextStyle(color: Colors.black, fontSize: 18),
      ),
    );
  }
}
