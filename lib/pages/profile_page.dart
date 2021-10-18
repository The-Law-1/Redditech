import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import '../widgets/feed.dart';
import '../controller/reddit_draw.dart';
import '../model/profile_model.dart';

// ! https://www.youtube.com/watch?v=X95-2wES1II&ab_channel=JohannesMilke

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // new instance of class profileModel

  final double coverHeight = 280; // banner height
  final double profileHeight = 144; // profile pic height

  List<Widget> profileElements = [];
  ProfileModel profileModel = ProfileModel();

  bool connected = false;
  bool infoSet = false;

  void SetProfilePage() async {
    profileElements = [];
    if (connected) {
      if (infoSet == false) {
        await profileModel.setInfo();
        print("Welcome back " + profileModel.userName);
        // remove the loginBtn from the profileElements
        // add the appropriate widgets
        setState(() {
          infoSet = true;
        });
      }
      setState(() {
        profileElements = [];
        profileElements.addAll(
            [buildUpperZone(profileModel), buildProfileInfo(profileModel)]);
        profileElements.addAll(createSubredditsFeed());
      });
    } else {
      print("Connect yo self");
      profileElements.add(connectButton());
    }
  }

  @override
  Widget build(BuildContext context) {
    SetProfilePage();

    return (Scaffold(
        body: ListView(
      //padding: EdgeInsets.zero,
      padding: connected ? EdgeInsets.zero : const EdgeInsets.only(top: 100),

      children: profileElements,
    )));
  }

  Widget connectButton() {
    return OutlinedButton(
        onPressed: () async {
          await RedditInfo.connection();
          setState(() {
            connected = true;
          });
        },
        child: const Text('Connect'));
  }

  Widget buildProfileInfo(ProfileModel profile) => Column(
        children: [
          const SizedBox(height: 8),
          Text(
            profile.userName,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            profile.description,
            style: const TextStyle(fontSize: 20, color: Colors.black),
          )
        ],
      );

  Widget buildUpperZone(ProfileModel profile) {
    final bottomOffset = profileHeight / 2; // offset for text

    final topOffset = coverHeight -
        profileHeight / 2; // offset between coverHeight and profile pic

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: bottomOffset),
          child: buildCoverImage(),
        ),
        Positioned(
          top: topOffset,
          child: buildProfileImage(profile),
        )
      ],
    );
  }

  Widget buildProfileImage(ProfileModel profile) => CircleAvatar(
        radius: profileHeight / 2,
        backgroundColor: Colors.grey.shade800,
        backgroundImage: NetworkImage(/*profile.profilePicUrl)*/
            'https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=880&q=80'),
      );

  Widget buildCoverImage() => Container(
        color: Colors.grey,
        // replace .network with .asset probably ??
        child: Image.network(
          'https://images.unsplash.com/photo-1554147090-e1221a04a025?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1448&q=80',
          width: double.infinity,
          height: coverHeight,
          fit: BoxFit.cover,
        ),
      );
}
