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
    num totalExpenses;
    await userCollection.doc(userid).collection('expense').add({
      'amount': expense,
      'category': category,
      'Date': Timestamp.now(),
    });

    DocumentSnapshot s = await userCollection.doc(userid).get();
    totalExpenses = s['totalExpense'];

    return await userCollection.doc(userid).update({
      'totalExpense': totalExpenses + expense,
    });
  }

  Future userDetail(int monthly, String savingmode) async {
    return await userCollection.doc(uid).update({
      'monthlyincome': monthly,
      'savingmode': savingmode,
      'totalExpense': 0,
    });
  }

  Future userDetailCustomSaving(
      int monthly, String savingmode, int amountSave) async {
    return await userCollection.doc(uid).update({
      'monthlyincome': monthly,
      'savingmode': savingmode,
      'amountSave': amountSave,
      'totalExpense': 0,
    });
  }

  Future fetchUserDetails(String? email) async {
    QuerySnapshot s =
        await userCollection.where("email", isEqualTo: email).get();
    return s;
  }

  Future fetchUserDetailsUser(String? username) async {
    QuerySnapshot s =
        await userCollection.where("username", isEqualTo: username).get();
    return s;
  }

  Future fetchUserExpenses(String userid) async {
    return await userCollection
        .doc(userid)
        .collection('expense')
        .limit(4)
        .snapshots();
  }
}
