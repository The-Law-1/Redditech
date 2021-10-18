import 'package:draw/draw.dart';
import 'package:flutter/material.dart';

Widget subredditRow(Image pictureImage, String title) {
  const double profPicDiameter = 44;

  return Container(
    //onTap: () => BlocProvider.of<HomeNavigatorCubit>(context).showProfile(),
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
              width: profPicDiameter,
              height: profPicDiameter,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(profPicDiameter / 2),
                  child: pictureImage)),
        ),
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        )
      ],
    ),
  );
}

// widget for subreddit feed container
Widget buildSubredditsFeedContainer(Image profileImage, String title) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [subredditRow(profileImage, title)],
  );
}

Widget buildTextPostFeedContainer(Image profImg, String author, String postHeader, String content)
{
  List<Widget> postElements = buildPostFeedContainer(profImg, author, postHeader);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      postElements[0],
      postElements[1],
      Text(content),
    ],
  );
}

Widget buildImagePostFeedContainer(Image profImg, String author, String postHeader, Image content)
{
  List<Widget> postElements = buildPostFeedContainer(profImg, author, postHeader);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      postElements[0],
      postElements[1],
      content,
    ],
  );
}

// function to generate postFeedContainer with
  // GIF
  // VIDEO (https://flutter.dev/docs/cookbook/plugins/play-video)

List<Widget> buildPostFeedContainer(Image profileImage, String author, String postHeader)
{
  return ([
    subredditRow(profileImage, author),
    Text(postHeader,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32))
  ]);
}

// tmp function returning a list of subreddit feed items
List<Widget> createSubredditsFeed() {
  return ([
    buildSubredditsFeedContainer(
        Image.network(
            'https://images.unsplash.com/photo-1552820728-8b83bb6b773f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2070&q=80'),
        "Subreddit 1"),
    buildSubredditsFeedContainer(
        Image.network(
            'https://images.unsplash.com/photo-1552820728-8b83bb6b773f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2070&q=80'),
        "Subreddit 2"),
    buildSubredditsFeedContainer(
        Image.network(
            'https://images.unsplash.com/photo-1552820728-8b83bb6b773f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2070&q=80'),
        "Subreddit 4"),
    buildSubredditsFeedContainer(
        Image.network(
            'https://images.unsplash.com/photo-1552820728-8b83bb6b773f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2070&q=80'),
        "Subreddit 5"),
    buildSubredditsFeedContainer(
        Image.network(
            'https://images.unsplash.com/photo-1552820728-8b83bb6b773f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2070&q=80'),
        "Subreddit 6"),
    buildSubredditsFeedContainer(
        Image.network(
            'https://images.unsplash.com/photo-1552820728-8b83bb6b773f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2070&q=80'),
        "Subreddit 7"),
    buildSubredditsFeedContainer(
        Image.network(
            'https://images.unsplash.com/photo-1552820728-8b83bb6b773f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2070&q=80'),
        "Subreddit 8"),
    buildSubredditsFeedContainer(
        Image.network(
            'https://images.unsplash.com/photo-1552820728-8b83bb6b773f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2070&q=80'),
        "Subreddit 9"),
    buildSubredditsFeedContainer(
        Image.network(
            'https://images.unsplash.com/photo-1552820728-8b83bb6b773f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2070&q=80'),
        "Subreddit 10"),
  ]);
}

// popular | best | hot | new
List<Widget> createPostsFeed(String option) {

  return ([
    buildTextPostFeedContainer(
        Image.network(
            'https://images.unsplash.com/photo-1552820728-8b83bb6b773f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2070&q=80'),
            "Toto",
            "Post header 1 " + option,
            "Post content"),
    buildTextPostFeedContainer(
        Image.network(
            'https://images.unsplash.com/photo-1552820728-8b83bb6b773f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2070&q=80'),
            "Toto",
            "Post header 2 " + option,
            "Post content"),
                buildTextPostFeedContainer(
        Image.network(
            'https://images.unsplash.com/photo-1552820728-8b83bb6b773f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2070&q=80'),
            "Toto",
            "Post header 3 " + option,
            "Post content"),
                buildTextPostFeedContainer(
        Image.network(
            'https://images.unsplash.com/photo-1552820728-8b83bb6b773f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2070&q=80'),
            "Toto",
            "Post header 4 " + option,
            "Post content"),
                buildTextPostFeedContainer(
        Image.network(
            'https://images.unsplash.com/photo-1552820728-8b83bb6b773f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2070&q=80'),
            "Toto",
            "Post header 5 " + option,
            "Post content"),
                buildTextPostFeedContainer(
        Image.network(
            'https://images.unsplash.com/photo-1552820728-8b83bb6b773f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2070&q=80'),
            "Toto",
            "Post header 6 " + option,
            "Post content"),
                buildTextPostFeedContainer(
        Image.network(
            'https://images.unsplash.com/photo-1552820728-8b83bb6b773f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2070&q=80'),
            "Toto",
            "Post header 7 " + option,
            "Post content"),
  ]);
}
