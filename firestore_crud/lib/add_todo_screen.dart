import 'package:firestore_crud/checklist_model.dart';
import 'package:firestore_crud/database_helper.dart';
import 'package:flutter/material.dart';

class AddTodoScreen extends StatefulWidget {
  final CheckList? checkList;
  final String? docId;
  const AddTodoScreen({this.checkList, this.docId});

  @override
  _AddTodoScreenState createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descpController = TextEditingController();

  @override
  void initState() {
    if (widget.checkList != null) {
      titleController.text = widget.checkList!.title;
      descpController.text = widget.checkList!.description;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Check List"),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          shrinkWrap: true,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              'Title',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                  hintText: "Enter title", border: OutlineInputBorder()),
            ),
            SizedBox(height: 20.0),
            Text(
              'Description',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: descpController,
              maxLines: 8,
              decoration: InputDecoration(
                  hintText: "Enter description", border: OutlineInputBorder()),
            ),
            SizedBox(height: 20.0),
            Container(
              width: double.maxFinite,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  if (titleController.text.trim().isNotEmpty &&
                      descpController.text.trim().isNotEmpty) {
                    if (widget.docId != null) {
                      await DatabaseHelper.updateChecklist(
                          title: titleController.text,
                          description: descpController.text,
                          docId: widget.docId!);
                    } else {
                      await DatabaseHelper.addCheckList(
                        title: titleController.text,
                        description: descpController.text,
                      );
                    }
                    Navigator.of(context).pop();
                  }
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                  child: Text(
                    widget.docId != null ? 'UPDATE' : 'ADD',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descpController.dispose();
    super.dispose();
  }
}
