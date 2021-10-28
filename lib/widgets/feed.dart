import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:redditech/pages/subreddit_page.dart';
import '../model/post_model.dart';
import '../model/subreddit_model.dart';

bool globalUpdateSearchPage = true;

Widget subredditFeedItem(SubredditModel subreddit, BuildContext context,
    {VoidCallback faveCallback = defaultCallback}) {
  return OutlinedButton(
      onPressed: () => ExpandSubredditPage(context, subreddit),
      child: subredditRow(subreddit.subredditImgUrl, subreddit.subredditName,
          isFaved: subreddit.isJoined, faveCallback: faveCallback));
}

void defaultCallback() {}

// pass bool for subreddit expand possibility ?
Widget subredditRow(String profileImgUrl, String title,
    {isFaved = false, VoidCallback faveCallback = defaultCallback}) {
  const double profPicDiameter = 44;

  Image defaultImage =
      Image.network("https://www.reddit.com/static/self_default2.png");
  Image finalImg = defaultImage;

  if (profileImgUrl != "") {
    finalImg = Image.network(profileImgUrl);
  }

  List<Widget> rowChildren = [
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
        fontSize: 12,
      ),
    ),
  ];

  if (isFaved) {
    rowChildren.add(IconButton(
        onPressed: () async {
          if (!isFaved) {
            await subscribeToSubreddit(title);
          } else {
            await unsubscribeFromSubreddit(title);
          }
          faveCallback();
        },
        icon: const Icon(Icons.favorite)));
  }

  return Row(
    mainAxisAlignment:
        isFaved ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
    children: rowChildren,
  );
}

// widget for subreddit feed container
Widget buildSubredditsFeedContainer(String profileImageUrl, String title) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [subredditRow(profileImageUrl, title)],
  );
}

Widget buildSubredditFeedContaierFromSubreddit(SubredditModel subreddit) {
  List<Widget> postElements = buildPostFeedContainer(subreddit.subredditImgUrl,
      subreddit.subredditName, subreddit.description);

  postElements.add(Text(subreddit.subredditName));

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: postElements,
  );
}

Widget buildPostFeedContainerFromPost(Post post) {
  if (post.thumbnail == "self" || post.thumbnail == "default") {
    print("WARNING");
  }

  void ExpandPost() {
    // add to navigation the post page (which takes a post)
  }

  List<Widget> postElements = buildPostFeedContainer(
      post.subredditImgUrl, post.authorName, post.postHeader);

  postElements.add(Padding(
    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
    child: Text(
      post.textContent,
      style: const TextStyle(
        fontSize: 15,
      )
    ),
  ));

  if (post.thumbnail != "" &&
      post.thumbnail != "self" &&
      post.thumbnail != "default" &&
      post.thumbnail != "spoiler") {
    postElements.add(Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(post.thumbnail, scale: 0.5),
      ],
    ));
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
    Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Text(postHeader,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          )),
    )
  ]);
  /*return ([ListTile(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
    contentPadding: const EdgeInsets.all(8.0),
      tileColor: Colors.grey[200],
    leading: subredditRow(profileImageUrl, author),
    title: Text(postHeader,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22))
  )]);*/
}
