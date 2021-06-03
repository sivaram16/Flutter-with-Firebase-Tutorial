import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/firebase_helper.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final UserCredential userCredential;
  const HomeScreen(this.userCredential);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome home ${widget.userCredential.user?.email}"),
            ElevatedButton(
                onPressed: () async {
                  await FirebaseHelper.signOut();
                  Navigator.pop(context);
                },
                child: Text("Sign Out"))
          ],
        ),
      ),
    );
  }
}
