import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseHelper {
  static final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;
  static final CollectionReference _collectionReference =
      _firebaseFirestore.collection('to-do');

  static String userId = "KHAeKhrmX5R4V0CrbVXgKZH1WCL2";
  static Future<void> addCheckList({
    required String title,
    required String description,
  }) async {
    DocumentReference documentReferencer =
        _collectionReference.doc(userId).collection('checklist').doc();

    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "description": description,
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("Checklist added"))
        .catchError((e) => print(e));
  }

  static Future<void> updateChecklist({
    required String title,
    required String description,
    required String docId,
  }) async {
    DocumentReference documentReferencer =
        _collectionReference.doc(userId).collection('checklist').doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "description": description,
    };

    await documentReferencer
        .update(data)
        .whenComplete(() => print("Checklist Updated"))
        .catchError((e) => print(e));
  }

  static Stream<QuerySnapshot> getChecklist() {
    CollectionReference checklistItemCollection =
        _collectionReference.doc(userId).collection('checklist');

    return checklistItemCollection.snapshots();
  }

  static Future<void> deleteChecklist({
    required String docId,
  }) async {
    DocumentReference documentReferencer =
        _collectionReference.doc(userId).collection('checklist').doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => print('Checklist Deleted'))
        .catchError((e) => print(e));
  }
}
