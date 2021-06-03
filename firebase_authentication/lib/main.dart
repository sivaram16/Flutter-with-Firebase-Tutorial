import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/firebase_helper.dart';
import 'package:firebase_authentication/home_screen.dart';
import 'package:firebase_authentication/register_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Firebase Auth'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            inputField(
                "Email", "Please enter your email", widget.emailController),
            const SizedBox(
              height: 20,
            ),
            inputField("Password", "Please enter your password",
                widget.passwordController,
                isObscureText: true),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      try {
                        UserCredential userCredential =
                            await FirebaseHelper.signInWithEmailAndPassword(
                                widget.emailController.text,
                                widget.passwordController.text);
                        if (userCredential.user != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      HomeScreen(userCredential)));
                        }
                      } catch (e) {
                        print("User not found");
                      }
                    },
                    child: Text("Sign In")),
                ElevatedButton(
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()));
                    },
                    child: Text("Register")),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  //    FirebaseHelper.signInWithGoogle(context: context);
                },
                child: Text("Sign in with google")),
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
