import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  final double pictureSize;
  final String pictureURL;

  const ProfilePic({this.pictureURL, this.pictureSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: pictureSize,
      height: pictureSize,
      decoration: new BoxDecoration(
        border: Border.all(color: Colors.blue, width: 4.0),
        shape: BoxShape.circle,
        image: new DecorationImage(
          fit: BoxFit.fill,
          image: new NetworkImage(
            pictureURL,
          ),
        ),
      ),
    );
  }
}
