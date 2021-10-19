import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import '../model/post_model.dart';

Widget subredditRow(String profileImgUrl, String title) {
  const double profPicDiameter = 44;

  Image defaultImage =
      Image.network("https://www.reddit.com/static/self_default2.png");
  Image finalImg = defaultImage;

  if (profileImgUrl != "") {
    finalImg = Image.network(profileImgUrl);
  }

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
                  child: finalImg)),
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
Widget buildSubredditsFeedContainer(String profileImageUrl, String title) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [subredditRow(profileImageUrl, title)],
  );
}

Widget buildPostFeedContainerFromPost(Post post) {
  if (post.thumbnail == "self" || post.thumbnail == "default") {
    print("WARNING");
  }

  List<Widget> postElements =
      buildPostFeedContainer(post.subredditImgUrl, post.authorName, post.postHeader);

  postElements.add(Text(post.textContent));

  if (post.thumbnail != "" && post.thumbnail != "self" && post.thumbnail != "default" && post.thumbnail != "spoiler") {
    postElements.add(Image.network(post.thumbnail));
  }
  // for (var imageUrl in post.previewImages) {
  //   try {
  //     postElements.add(Image.network(imageUrl));
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: postElements,
  );
}

// function to generate postFeedContainer with
// GIF
// VIDEO (https://flutter.dev/docs/cookbook/plugins/play-video)

List<Widget> buildPostFeedContainer(
    String profileImageUrl, String author, String postHeader) {
  return ([
    subredditRow(profileImageUrl, author),
    Text(postHeader,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32))
  ]);
}

// tmp function returning a list of subreddit feed items
List<Widget> createSubredditsFeed() {
  return ([
    buildSubredditsFeedContainer(
        'https://images.unsplash.com/photo-1552820728-8b83bb6b773f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2070&q=80',
        "Subreddit 1"),
    buildSubredditsFeedContainer(
         'https://images.unsplash.com/photo-1552820728-8b83bb6b773f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2070&q=80',
        "Subreddit 2"),
    buildSubredditsFeedContainer(
        'https://images.unsplash.com/photo-1552820728-8b83bb6b773f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2070&q=80',
        "Subreddit 4"),
    buildSubredditsFeedContainer(
        'https://images.unsplash.com/photo-1552820728-8b83bb6b773f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2070&q=80',
        "Subreddit 5"),
    buildSubredditsFeedContainer(
        'https://images.unsplash.com/photo-1552820728-8b83bb6b773f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2070&q=80',
        "Subreddit 6"),
    buildSubredditsFeedContainer(
        'https://images.unsplash.com/photo-1552820728-8b83bb6b773f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2070&q=80',
        "Subreddit 7"),
    buildSubredditsFeedContainer(
        'https://images.unsplash.com/photo-1552820728-8b83bb6b773f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2070&q=80',
        "Subreddit 8"),
    buildSubredditsFeedContainer(
        'https://images.unsplash.com/photo-1552820728-8b83bb6b773f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2070&q=80',
        "Subreddit 9"),
    buildSubredditsFeedContainer(
        'https://images.unsplash.com/photo-1552820728-8b83bb6b773f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2070&q=80',
        "Subreddit 10"),
  ]);
}
