import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/firebase_helper.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            inputField("Email", "Please enter your email", emailController),
            const SizedBox(
              height: 20,
            ),
            inputField(
                "Password", "Please enter your password", passwordController,
                isObscureText: true),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  try {
                    UserCredential userCredential =
                        await FirebaseHelper.createAccount(
                            emailController.text, passwordController.text);
                    if (userCredential.user != null) {
                      Navigator.pop(context);
                    }
                  } catch (e) {
                    print("Failed");
                  }
                },
                child: Text("Register now")),
          ],
        ),
      ),
    );
  }

  Widget inputField(
      String title, String hintText, TextEditingController controller,
      {bool isObscureText = false}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          TextField(
            obscureText: isObscureText,
            controller: controller,
            decoration: InputDecoration(hintText: hintText),
          ),
        ],
      ),
    );
  }
}
