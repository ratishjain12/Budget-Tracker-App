import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  final String? uid;
  Database({this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  Future updateUser(String email, String username) async {
    return await userCollection.doc(uid).set({
      "username": username,
      "email": email,
    });
  }

  Future addExpense(String userid, int expense, String category) async {
    return await userCollection.doc(userid).collection('expense').add({
      'amount': expense,
      'category': category,
      'Date': Timestamp.now(),
    });
  }
}
