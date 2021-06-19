import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  final String data;
  const PostScreen(this.data);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Post Screen"),),
      body: Center(
          child: Text(
        widget.data,
        style: TextStyle(fontSize: 24),
      )),
    );
  }
}
