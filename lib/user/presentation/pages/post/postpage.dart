import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:worldhelps/constants/colors.dart';
import 'package:worldhelps/user/presentation/manager/post_bloc/post_bloc.dart';
import 'package:worldhelps/user/presentation/manager/user_bloc/user_bloc.dart';
import 'package:worldhelps/utils/utils.dart';
import '../../../../common/widgets/customtextfield.dart';
import '../home.dart';

class PostScreenImage extends StatefulWidget {
  const PostScreenImage({super.key});

  @override
  State<PostScreenImage> createState() => _PostScreenImageState();
}

class _PostScreenImageState extends State<PostScreenImage> {
  Uint8List? _file;

  selectImage(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text("create a post"),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              // Makes this button the default (bolder)
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(ImageSource.camera);
                setState(() {
                  _file = file;
                });
              },
              child: const Text('Take a photo'),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              // Makes this button the default (bolder)
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(ImageSource.gallery);
                setState(() {
                  _file = file;
                });
              },
              child: const Text('choose from gallery'),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              // Makes this button the default (bolder)
              onPressed: () async {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.red),
              ),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              // Makes this button the default (bolder)
              onPressed: () async {
                Navigator.of(context).pop();
                setState(() {
                  _file = null;
                });
              },
              child: const Text(
                'Remove photo',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  final TextEditingController title = TextEditingController();
  final TextEditingController caption = TextEditingController();

  @override
  void dispose() {
    title.dispose();
    caption.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final postBloc = BlocProvider.of<PostBloc>(context);
    final userBloc = BlocProvider.of<UserBloc>(context);

    return BlocListener<PostBloc, PostState>(
      listener: (context, state) {
        if (state is PostErrorState) {
          notif(context: context, color: errorColors, text: state.err);
          Navigator.of(context).pop();
        }
        if (state is PostSucessState) {
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const HomeScreen()));
        }

        if (state is PostLoadingState) {
          showDialog(
            context: context,
            builder: (context) => const Center(
              child: CupertinoActivityIndicator(color: primaryDark),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: primaryWhite,
        appBar: AppBar(
          backgroundColor: primaryDark,
          centerTitle: true,
          title: const Text("Post Image"),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // titletext("Title"),
              // const SizedBox(height: 10),
              // CustomTextField(
              //   controller: title,
              //   ispass: false,
              //   hintText: "Enter title",
              //   keyboardType: TextInputType.emailAddress,
              //   onFieldSubmitted: (p0) => FocusScope.of(context).nextFocus(),
              // ),
              const SizedBox(height: 10),
              titletext("Select Image"),
              const SizedBox(height: 10),
              _file != null
                  ? GestureDetector(
                      onTap: () => selectImage(context),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image(
                            height: 250,
                            fit: BoxFit.cover,
                            width: double.maxFinite,
                            image: MemoryImage(_file!),
                            filterQuality: FilterQuality.high,
                          ),
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () => selectImage(context),
                      child: Container(
                        height: 250,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: primaryWhite,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.image,
                          color: primaryGrey,
                        ),
                      ),
                    ),
              const SizedBox(height: 10),
              titletext("Caption"),
              const SizedBox(height: 10),
              CustomTextField(
                controller: caption,
                ispass: false,
                hintText: "Enter Caption",
                keyboardType: TextInputType.emailAddress,
                onFieldSubmitted: (p0) => FocusScope.of(context).nextFocus(),
                maxLines: 4,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () => postBloc.add(
                    PostUploadRequest(
                      description: caption.text,
                      file: _file!,
                      uid: userBloc.userRepository.getUser.uid,
                      username: userBloc.userRepository.getUser.username,
                      profileImage: userBloc.userRepository.getUser.photoUrl,
                    ),
                  ),
                  child: BlocBuilder<PostBloc, PostState>(
                    builder: (context, state) {
                      if (state is PostLoadingState) {
                        return const CircularProgressIndicator(
                          color: primaryWhite,
                        );
                      } else {
                        return const Text("Post");
                      }
                    },
                  ),
                ),
              )
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
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
      ),
    );
  }
}
