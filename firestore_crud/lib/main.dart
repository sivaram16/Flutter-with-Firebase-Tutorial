import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_crud/add_todo_screen.dart';
import 'package:firestore_crud/checklist_model.dart';
import 'package:firestore_crud/database_helper.dart';
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
      debugShowCheckedModeBanner: false,
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firestore CRUD"),
      ),
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: DatabaseHelper.getChecklist(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            } else if (snapshot.hasData || snapshot.data != null) {
              if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Text(
                    "No data's found",
                    style: TextStyle(fontSize: 20),
                  ),
                );
              }
              return ListView.separated(
                separatorBuilder: (context, index) => SizedBox(height: 10.0),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var checklistData = snapshot.data!.docs[index].data()!;
                  String docId = snapshot.data!.docs[index].id;
                  final CheckList checkList =
                      CheckList.fromJSON(checklistData as Map<String, dynamic>);
                  return _ListItem(checkList, docId);
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddTodoScreen()));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.yellow,
      ),
    );
  }
}

class _ListItem extends StatelessWidget {
  final CheckList checkList;
  final String docId;
  const _ListItem(this.checkList, this.docId);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      onTap: () {},
      title: Text(
        checkList.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        checkList.description,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Container(
        height: 50,
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddTodoScreen(
                              checkList: checkList,
                              docId: docId,
                            )));
              },
              child: Icon(
                Icons.edit,
                color: Colors.yellow,
              ),
            ),
            InkWell(
              onTap: () {
                DatabaseHelper.deleteChecklist(docId: docId);
              },
              child: Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
