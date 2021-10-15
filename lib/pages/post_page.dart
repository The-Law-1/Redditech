import 'dart:ffi';

import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import '../widgets/feed.dart';

// takes type "Post" containing post INFO
class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        body: ListView(
        padding: EdgeInsets.zero,
        children: [
          buildPostInfo(
          "Toto",
          Image.network('https://images.unsplash.com/photo-1552820728-8b83bb6b773f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2070&q=80'),
          "Post subredditName"),
          buildPostContent("Post header",
          'https://images.unsplash.com/photo-1552820728-8b83bb6b773f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2070&q=80',
          )
        ],
      )
    ));
  }

  Widget buildPostInfo(String authorName, Image subredditPic, String subredditName)
  {
    final double profPicDiameter = 140;

    return Container(

      child: Column(children: [
          Row(
            children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                      width: profPicDiameter,
                      height: profPicDiameter,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(profPicDiameter / 2),
                          child: subredditPic)
                        ),
                ),
                Text(
                  subredditName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          Text(
              authorName,
              style: const TextStyle(
                fontSize: 25
              ),
            )

        ],
      )
    );
  }

  Widget buildPostContent(String postHeader, String imageUrl)
  {
    return Container(
      child: Column(children: [
          Text(
            postHeader,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Image.network(imageUrl),
        ],
      )
    );
  }

}
