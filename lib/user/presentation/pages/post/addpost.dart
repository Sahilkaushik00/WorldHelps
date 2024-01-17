import 'package:flutter/material.dart';
import 'package:worldhelps/constants/colors.dart';
import 'package:worldhelps/user/presentation/pages/post/postpage.dart';

class AddpostScreen extends StatefulWidget {
  const AddpostScreen({super.key});

  @override
  State<AddpostScreen> createState() => _AddpostScreenState();
}

class _AddpostScreenState extends State<AddpostScreen> {
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
