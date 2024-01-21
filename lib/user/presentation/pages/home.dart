// import 'dart:developer';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worldhelps/constants/colors.dart';
import 'package:worldhelps/user/presentation/manager/user_bloc/user_bloc.dart';
import 'package:worldhelps/user/presentation/pages/post/addpost.dart';
import 'package:worldhelps/user/presentation/pages/donatescreen.dart';
import 'package:worldhelps/user/presentation/pages/reelpage/reelpage.dart';

import '../widgets/post.dart';
// import 'reel.dart';

// import '../widgets/post.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // void getData() async {
  //   DocumentSnapshot snap = await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get();
  //   log(snap.data().toString());
  // }

  @override
  Widget build(BuildContext context) {
    final userbloc = BlocProvider.of<UserBloc>(context);
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.menu,
        ),
        title: const Text("World - Help"),
        centerTitle: true,
        actions: [
          CircleAvatar(
            radius: 15.5,
            backgroundColor: primaryWhite,
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserRefreshedState) {
                  return CircleAvatar(
                    radius: 15,
                    backgroundImage: CachedNetworkImageProvider(
                        userbloc.userRepository.getUser.photoUrl),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserRefreshedState) {
            return StreamBuilder(
              stream:FirebaseFirestore.instance.collection('posts').snapshots(),
              builder: (context,AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CupertinoActivityIndicator());
                }
                return ListView.builder(
                  physics: const BouncingScrollPhysics(
                    decelerationRate: ScrollDecelerationRate.normal,
                  ),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return PostWidget(
                      postUserImageUrl: snapshot.data!.docs[index]
                          ['profileImage'],
                      postUserName: snapshot.data!.docs[index]['username'],
                      // locaton: 'location',
                      postImageUrl: snapshot.data!.docs[index]['postUrl'],

                      caption: snapshot.data!.docs[index]['description'],
                      noOfComments: '20',
                      currentUserImageUrl:
                          userbloc.userRepository.getUser.photoUrl,
                      time:
                          snapshot.data!.docs[index]['datePublished'].toDate(),
                    );
                  },
                );
              },
            );
          } else if (state is UserLoadingState) {
            return const Center(child: CupertinoActivityIndicator());
          } else if (state is UserErrorState) {
            return Text(state.err);
          } else {
            return const Center(child: CupertinoActivityIndicator());
          }
        },
      ),
      bottomNavigationBar: CupertinoTabBar(
        // currentIndex: _currentIndex,
        currentIndex: 0,
        onTap: (index) {
          // setState(() {
          //   _currentIndex = index;
          // });
        },
        // type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ReelScreen()),
              ),
              child: const Icon(Icons.movie),
            ),
            label: 'Reel',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const AddpostScreen()),
              ),
              child: const Icon(Icons.add_box),
            ),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              child: const Icon(Icons.search),
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const DonateScreen()),
              ),
              child: const Icon(Icons.card_giftcard_rounded),
            ),
            label: 'Donate',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

