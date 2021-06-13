import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage_demo/file_helper.dart';
import 'package:firebase_storage_demo/file_uploader.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        brightness: Brightness.dark,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? imageURL;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Storage"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () async {
                  try {
                    FilePickerResult? filePickerResult =
                        await FileHelper.pickFile(FileType.image);
                    if (filePickerResult != null) {
                      String? url;
                      if (kIsWeb) {
                        url = await FileUploader.uploadFileWeb(
                            filePickerResult.files.first);
                      } else {
                        url = await FileUploader.uploadFileMobile(
                            filePickerResult.files.first);
                      }
                      print(url);
                      if (url != null) {
                        setState(() {
                          imageURL = url;
                        });
                      }
                    }
                  } catch (e) {}
                },
                child: Text("Upload File")),
            if (imageURL != null)
              SizedBox(
                  height: 500,
                  width: 500,
                  child: Image.network(kIsWeb
                      ? "https://cors.bridged.cc/" + imageURL!
                      : imageURL!)),
          ],
        ),
      ),
    );
  }
}
