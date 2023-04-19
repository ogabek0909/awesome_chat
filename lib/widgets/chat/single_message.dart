import 'package:flutter/material.dart';

class SingleMessage extends StatelessWidget {
  final String message;
  final bool isMe;
  const SingleMessage({super.key,required this.message,required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Text(message),
    );
  }
}