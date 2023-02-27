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

  Future addGoal(String userid, String name, int goal_amount, int saved) async {
    return await userCollection.doc(userid).collection('goal').add({
      'title': name,
      'goal': goal_amount,
      'saved': saved,
    });
  }

  Future fetchUserEmail(String userid) async {
    DocumentSnapshot s = await userCollection.doc(userid).get();
    return s['email'];
  }

  Future fetchUsername(String userid) async {
    DocumentSnapshot s = await userCollection.doc(userid).get();
    return s['username'];
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
    return await userCollection.where("email", isEqualTo: email).get();
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
        .orderBy("Date", descending: true)
        .limitToLast(4)
        .snapshots();
  }

  Future fetchGoals(String userid) async {
    return await userCollection.doc(userid).collection('goal').snapshots();
  }

  Future foodCategory(String userid) async {
    QuerySnapshot s = await userCollection
        .doc(userid)
        .collection('expense')
        .where('category', isEqualTo: 'Food & Drinks')
        .get();
    return s;
  }

  Future shoppingCategory(String userid) async {
    QuerySnapshot s = await userCollection
        .doc(userid)
        .collection('expense')
        .where('category', isEqualTo: 'Shopping')
        .get();
    return s;
  }

  Future housingCategory(String userid) async {
    QuerySnapshot s = await userCollection
        .doc(userid)
        .collection('expense')
        .where('category', isEqualTo: 'Housing')
        .get();
    return s;
  }

  Future lifehealthCategory(String userid) async {
    QuerySnapshot s = await userCollection
        .doc(userid)
        .collection('expense')
        .where('category', isEqualTo: 'Life & Health')
        .get();
    return s;
  }

  Future investmentCategory(String userid) async {
    QuerySnapshot s = await userCollection
        .doc(userid)
        .collection('expense')
        .where('category', isEqualTo: 'Investments')
        .get();
    return s;
  }

  Future vehicleCategory(String userid) async {
    QuerySnapshot s = await userCollection
        .doc(userid)
        .collection('expense')
        .where('category', isEqualTo: 'Vehicle & Transportation')
        .get();
    return s;
  }

  Future groceriesCategory(String userid) async {
    QuerySnapshot s = await userCollection
        .doc(userid)
        .collection('expense')
        .where('category', isEqualTo: 'Groceries')
        .get();
    return s;
  }

  Future otherCategory(String userid) async {
    QuerySnapshot s = await userCollection
        .doc(userid)
        .collection('expense')
        .where('category', isEqualTo: 'Other')
        .get();
    return s;
  }

  Future entertainCategory(String userid) async {
    QuerySnapshot s = await userCollection
        .doc(userid)
        .collection('expense')
        .where('category', isEqualTo: 'Entertaiment')
        .get();
    return s;
  }

  Future CategoricExpenses(String userid, String category) async {
    return await userCollection
        .doc(userid)
        .collection('expense')
        .where('category', isEqualTo: category)
        .snapshots();
  }

  Future delGoals(String userid, String GoalName, int GoalAmount) async {
    var s = await userCollection.doc(userid).collection('goal').get();
    for (var doc in s.docs) {
      if (doc['title'] == GoalName && doc['goal'] == GoalAmount) {
        await doc.reference.delete();
      }
    }
  }

  Future clearExpenses(String userid) async {
    var s = await userCollection.doc(userid).collection('expense').get();
    for (var doc in s.docs) {
      await doc.reference.delete();
    }
    return await userCollection.doc(userid).update({
      'totalExpense': 0,
    });
  }

  Future updateSavings(String userid, int savings) async {
    return await userCollection.doc(userid).update({
      'monthlyincome': savings,
    });
  }
}
