import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth/auth_bloc.dart';
import 'loginscreen.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common/widgets/customtextfield.dart';
import '../../../constants/colors.dart';

// import '../blocs/auth/auth_bloc.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final cPassController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.of(context).size.height;

    final _authbloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: primaryWhite,
          child: Form(
            key: _formKey,
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
                    "Register your \n Account",
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
                  validator: (value) {
                    if (!EmailValidator.validate(value!)) {
                      return 'Invalid email!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                // password
                titletext('Password'),
                CustomTextField(
                  controller: passController,
                  ispass: true,
                  hintText: "Password",
                  keyboardType: TextInputType.visiblePassword,
                  validator: (p0) {
                    if (p0!.isEmpty || p0.length < 5) {
                      return 'password greater than 5';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                // confirm password
                titletext('Confirm-Password'),
                CustomTextField(
                  controller: cPassController,
                  ispass: true,
                  hintText: "Confirm-Password",
                  keyboardType: TextInputType.visiblePassword,
                  validator: (p0) {
                    if (p0 != passController.text || p0!.isEmpty) {
                      return 'Password does not match!';
                    }
                    return null;
                  },
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
                      child: const Text("Register"),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _authbloc.add(
                            SignupRequested(
                              email: emailController.text,
                              password: passController.text,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have account"),
                    TextButton(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => LoginScreen(),
                        ),
                      ),
                      child: const Text("Sign In"),
                    )
                  ],
                ),
              ],
            ),
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