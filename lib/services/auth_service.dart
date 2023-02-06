import 'package:budget_tracker/screens/helper/helper_function.dart';
import 'package:budget_tracker/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();

  Future emailPasswordSignUp(String email, String password, String username,
      BuildContext context) async {
    try {
      User user = (await auth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;
      if (user != null) {
        await Database(uid: user.uid).updateUser(email, username);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          e.message!,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future emailPasswordSignIn(
      String email, String password, BuildContext context) async {
    try {
      User user = (await auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;
      if (user != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          e.message!,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<bool> googleSignin() async {
    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      try {
        UserCredential result = await auth.signInWithCredential(credential);
        User? user = result.user;
        if (user != null) {
          if (result.additionalUserInfo!.isNewUser) {
            await FirebaseFirestore.instance
                .collection("users")
                .doc(user.uid)
                .set({
              "username": user.displayName,
              "email": user.email,
            });
          }
        }
      } on FirebaseAuthException catch (e) {
        print(e);
      }
      return Future.value(true);
    }
    return Future.value(false);
  }

  Future signOut() async {
    try {
      await googleSignIn.signOut();
      await auth.signOut();
    } catch (e) {
      print(e);
    }
    await helper_function.saveUserLoggedInStatus(false);
  }
}
