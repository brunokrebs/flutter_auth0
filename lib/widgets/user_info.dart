import 'package:flutter/material.dart';

class UserInfoText extends StatelessWidget {
  final String label;
  final String value;

  const UserInfoText({Key key, this.label, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '$label: $value',
      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0),
    );
  }
}
