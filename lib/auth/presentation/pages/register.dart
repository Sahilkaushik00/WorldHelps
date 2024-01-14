import 'dart:developer';
import 'dart:typed_data';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:worldhelps/utils/utils.dart';
import '../blocs/auth/auth_bloc.dart';
import 'loginscreen.dart';
import '../../../common/widgets/customtextfield.dart';
import '../../../constants/colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();

  final nameController = TextEditingController();

  final bioController = TextEditingController();

  final passController = TextEditingController();

  final cPassController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Uint8List? file;
  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      file = img;
    });
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    nameController.dispose();
    bioController.dispose();
    passController.dispose();
    cPassController.dispose();
  }

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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          "Register your \n Account",
                          style: TextStyle(color: primaryWhite, fontSize: 32),
                        ),
                        GestureDetector(
                          onTap: () {
                            selectImage();
                            log("message");
                          },
                          child: Stack(
                            children: [
                              file != null
                                  ? CircleAvatar(
                                      backgroundColor: primary,
                                      backgroundImage: MemoryImage(file!),
                                      radius: 50,
                                    )
                                  : const CircleAvatar(
                                      backgroundColor: primaryGrey,
                                      radius: 50,
                                      child: Icon(
                                        Icons.person_2_rounded,
                                        color: Colors.white,
                                        size: 50,
                                      ),
                                    ),
                              Positioned(
                                bottom: -10,
                                left: 50,
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.add_a_photo,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
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
                // username
                titletext("Username"),
                CustomTextField(
                  controller: nameController,
                  ispass: false,
                  hintText: "Username",
                  keyboardType: TextInputType.emailAddress,
                  onFieldSubmitted: (p0) => FocusScope.of(context).nextFocus(),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Can't be empty!";
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

                const SizedBox(height: 10),
                // Bio
                titletext("Bio"),
                CustomTextField(
                  controller: bioController,
                  ispass: false,
                  hintText: "bio",
                  keyboardType: TextInputType.emailAddress,
                  onFieldSubmitted: (p0) => FocusScope.of(context).nextFocus(),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Can't be empty!";
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
                          print(file);
                          _authbloc.add(
                            SignupRequested(
                              name: nameController.text,
                              bio: bioController.text,
                              email: emailController.text,
                              password: passController.text,
                              file: file!,
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
