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

// poly-morphic for content ?
Widget buildPostFeedContainer(
    Image profileImage, String author, String postHeader) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      subredditRow(profileImage, author),
      // post header
      Text(postHeader,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32)),
      // content
    ],
  );
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
// List<Widget> createPostsFeed(String option) {
//   return ([
//     buildPostFeedContainer(
//         Image.network(
//             'https://images.unsplash.com/photo-1552820728-8b83bb6b773f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2070&q=80'),
//         "Post 1 " + option)
//   ]);
// }
