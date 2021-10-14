import 'package:flutter/material.dart';

// ! https://www.youtube.com/watch?v=X95-2wES1II&ab_channel=JohannesMilke

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final double coverHeight = 280;

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          buildCoverImage()
        ],
      )
    ));
  }

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
