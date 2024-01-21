import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:worldhelps/constants/colors.dart';
import 'package:worldhelps/user/presentation/pages/post/postpage.dart';

import 'confirm_screen.dart';

class AddpostScreen extends StatefulWidget {
  const AddpostScreen({super.key});

  @override
  State<AddpostScreen> createState() => _AddpostScreenState();
}

class _AddpostScreenState extends State<AddpostScreen> {
  // pick video
  pickVideo(ImageSource src, BuildContext context) async {
    final video = await ImagePicker().pickVideo(source: src);
    if (video != null) {
      log("video not null");
      Navigator.of(context).pop();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ConfirmScreen(
            videoFile: File(video.path),
            videoPath: video.path,
          ),
        ),
      );
    } else {}
  }

  // shows options
  selectVideo(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text("create a post"),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () async {
                pickVideo(ImageSource.camera, context);
                Navigator.of(context).pop();
              },
              child: const Text('choose from camera'),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () async {
                await pickVideo(ImageSource.gallery, context);
              },
              child: const Text('choose from gallery'),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () async {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Upload a Post"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => selectVideo(context),
                  child: postCard(icon: Icons.movie, text: 'Shorts'),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const PostScreenImage())),
                  child: postCard(icon: Icons.image, text: 'Image'),
                ),
              ),
            ],
          ),
        ));
  }

  Container postCard({required String text, required IconData icon}) {
    return Container(
      height: 150,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
          color: primaryWhite, borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: primary,
          ),
          const SizedBox(height: 20),
          Text(
            text,
            style: const TextStyle(
              color: primary,
              fontWeight: FontWeight.w900,
            ),
          )
        ],
      ),
    );
  }
}
