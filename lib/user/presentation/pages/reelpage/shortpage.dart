import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
import 'package:worldhelps/user/presentation/pages/reelpage/video_player.dart';

import '../../../../constants/colors.dart';
import 'dart:ui' as ui;


class ShortScreen extends StatelessWidget {
  const ShortScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('shorts').snapshots(),
      builder: (context,AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>snapshot) {
        if (snapshot.connectionState ==ConnectionState.waiting) {
          return const Center(child: CupertinoActivityIndicator(),);
        }
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: const Text('shorts'),
            centerTitle: false,
            backgroundColor: Colors.transparent,
          ),
          body: PageView.builder(
            itemCount: snapshot.data!.docs.length,
            controller: PageController(initialPage: 0, viewportFraction: 1),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  VideoPlayerItem(
                      videoUrl: snapshot.data!.docs[index]
                          ['shortsUrl']),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Wrap(
                            direction: Axis.vertical,
                            spacing: 20,
                            children: [
                              Icon(
                                Icons.favorite_border,
                                color: primaryWhite,
                                size: 35,
                              ),
                              Icon(
                                Icons.comment,
                                color: primaryWhite,
                                size: 35,
                              ),
                              Icon(
                                Icons.send,
                                color: primaryWhite,
                                size: 35,
                              ),
                              Icon(
                                Icons.card_giftcard,
                                color: primaryWhite,
                                size: 35,
                              ),
                            ],
                          ),
                        ),
                      )),
                      ClipRect(
                        child: BackdropFilter(
                          filter: ui.ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                          child: Container(
                            width: double.maxFinite,
                            color: Colors.black.withOpacity(0.3),
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  snapshot.data!.docs[index]['title'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(
                                  snapshot.data!.docs[index]['subtitle'],
                                  maxLines: 2,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 20)
                              ],
                            ),
                          ),
                        ),
                      ),

                    ],
                  )
                ],
              );
            },
          ),
        );
      },
    );
  }
}
