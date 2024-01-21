import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:worldhelps/common/widgets/customtextfield.dart';
import 'package:worldhelps/user/presentation/manager/shorts_bloc/shorts_bloc.dart';
import 'package:worldhelps/utils/utils.dart';

import '../../../../constants/colors.dart';
import '../../manager/user_bloc/user_bloc.dart';

class ConfirmScreen extends StatefulWidget {
  const ConfirmScreen(
      {super.key,
      required this.videoFile,
      required this.videoPath});

  final File videoFile;
  final String videoPath;

  @override
  State<ConfirmScreen> createState() =>
      _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  TextEditingController titile = TextEditingController();
  TextEditingController subtitle = TextEditingController();

  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    setState(() {
      controller =
          VideoPlayerController.file(widget.videoFile);
    });
    controller.initialize();
    controller.play();
    controller.setLooping(true);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    titile.dispose();
    subtitle.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);
    final shortsBloc = BlocProvider.of<ShortsBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Video short'),
        centerTitle: false,
        backgroundColor: Colors.black.withAlpha(1),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height /
                    1.5,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: VideoPlayer(controller),
                ),
              ),
            ),
            const SizedBox(height: 30),
            CustomTextField(
              controller: titile,
              hintText: "title",
              ispass: false,
              keyboardType: TextInputType.text,
              maxLines: 1,
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: subtitle,
              hintText: "subtitile",
              ispass: false,
              keyboardType: TextInputType.text,
              maxLines: 1,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {
                  if (titile.text.isEmpty ||
                      subtitle.text.isEmpty) {
                    notif(
                        context: context,
                        color: Colors.red,
                        text: "field can't be empty");
                  } else {
                    shortsBloc.add(
                      ShortsUploadRequest(
                        title: titile.text.trim(),
                        subtitle: subtitle.text.trim(),
                        description: '',
                        file: widget.videoFile,
                        uid: userBloc
                            .userRepository.getUser.uid,
                        username: userBloc.userRepository
                            .getUser.username,
                        profileImage: userBloc
                            .userRepository
                            .getUser
                            .photoUrl,
                      ),
                    );
                  }
                },
                child:
                    BlocListener<ShortsBloc, ShortsState>(
                  listener: (context, state) {
                    if(state is ShortsSucessState){
                      notif(context: context, color: Colors.green, text: 'Short uploaded');
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }else if (state is ShortsErrorState){
                      notif(context: context, color: Colors.red, text: state.err);
                    }
                  },
                  child:
                      BlocBuilder<ShortsBloc, ShortsState>(
                    builder: (context, state) {
                      if (state is ShortsLoadingState) {
                        return const CircularProgressIndicator(
                          color: primaryWhite,
                        );
                      } else {
                        return const Text("Upload");
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
