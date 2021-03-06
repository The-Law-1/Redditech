import 'package:flutter/material.dart';
import 'package:redditech/controller/reddit_draw.dart';
import 'package:redditech/model/subreddit_model.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:redditech/widgets/feed.dart';

class SearchingPage extends StatefulWidget {
  const SearchingPage({Key? key}) : super(key: key);

  @override
  _SearchingPageState createState() => _SearchingPageState();
}

class _SearchingPageState extends State<SearchingPage> {
  SubredditFeed subredditFeed = SubredditFeed();
  List<Widget> subredditsFeed = [];
  bool initialized = false;

  void Initialize(BuildContext context) async {
    if (!globalUpdateSearchPage) {
      return;
    } else {
      print("starting setInfo");

      await subredditFeed.setInfo("reddit");
      setState(() {
        print("Finished setInfo");
        subredditsFeed = [];
        subredditsFeed = subredditFeed.getFeed();
        //initialized = true;
        globalUpdateSearchPage = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    subredditFeed.setContext(context);
    Initialize(context);

    return Scaffold(
      body: Stack(fit: StackFit.expand, children: [
        ListView(
          padding: const EdgeInsets.only(top: 120),
          children: subredditsFeed,
        ),
        buildFloatingSearchBar(context),
      ]),
    );
  }

  Widget buildFloatingSearchBar(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    String globalQuery = "";

    return FloatingSearchBar(
      hint: 'Search...',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      onSubmitted: (query) async {
        await subredditFeed.setInfo(query);
        setState(() {
          subredditsFeed = [];
          subredditsFeed = subredditFeed.getFeed();
        });
      },
      onQueryChanged: (query) {
        //ici j'appelle l'api avec query qui est le mot en param
        //subredditFeed.setInfo(query);
        // setState(() {
        //   globalQuery = query;
        // });
        // Call your model, bloc, controller here.
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.manage_search),
            onPressed: () async {
              print("On pressed");
              await subredditFeed.setInfo(globalQuery);
              setState(() {
                subredditsFeed = [];
                subredditsFeed = subredditFeed.getFeed();
              });
              //search
            },
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [],
            ),
          ),
        );
      },
    );
  }
}
