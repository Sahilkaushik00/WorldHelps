import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:worldhelps/constants/colors.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({
    super.key,
    required this.postUserImageUrl,
    required this.postUserName,
    required this.postImageUrl,
    required this.caption,
    required this.noOfComments,
    required this.currentUserImageUrl,
    required this.time,
  });
  final String postUserImageUrl;
  final String postUserName;
  final String postImageUrl;
  final String caption;
  final String noOfComments;
  final String currentUserImageUrl;
  final DateTime time;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
          color: primaryWhite, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              CircleAvatar(
                  radius: 20.0,
                  backgroundImage:
                      CachedNetworkImageProvider(postUserImageUrl)),
              const SizedBox(width: 8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    postUserName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  // Text(locaton),
                ],
              ),
              const Spacer(),
              const Icon(Icons.more_vert),
            ],
          ),
          const SizedBox(height: 8.0),

          // Post Image
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: postImageUrl,
              placeholder: (context, url) =>
                  const Center(child: CupertinoActivityIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),

          const SizedBox(height: 10),

          // Like, Comment, Share Icons
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.favorite_border),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.chat_bubble_outline),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.send),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.card_giftcard),
                ],
              ),
              Icon(Icons.share),
            ],
          ),
          const SizedBox(height: 8.0),

          // Caption
          Text(
            caption,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4.0),

          // View all comments
          GestureDetector(
            onTap: () {
              // Add functionality to navigate to comments
            },
            child: Text(
              'View all $noOfComments comments',
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(height: 4.0),

          // Add a comment
          Row(
            children: [
              CircleAvatar(
                  radius: 15.0,
                  backgroundImage:
                      CachedNetworkImageProvider(currentUserImageUrl)),
              const SizedBox(width: 8.0),
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Add a comment...',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),

          // Time since post
          Text(
            DateFormat.yMMMd().format(time),
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
