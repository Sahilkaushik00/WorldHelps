// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../constants/colors.dart';

pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();

  XFile? file = await imagePicker.pickImage(source: source, imageQuality: 60);

  if (file != null) {
    return file.readAsBytes();
  }
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
