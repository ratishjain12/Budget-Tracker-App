import 'package:budget_tracker/screens/helper/helper_function.dart';
import 'package:budget_tracker/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();

  Future emailPasswordSignUp(
      String email, String password, String username) async {
    try {
      User user = (await auth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;
      if (user != null) {
        await Database(uid: user.uid).updateUser(email, username);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future emailPasswordSignIn(String email, String password) async {
    try {
      User user = (await auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;
      if (user != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future emailPasswordSignOut() async {}

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
      } catch (e) {
        print(e);
      }
      return Future.value(true);
    }
    return Future.value(false);
  }

  Future signOut() async {
    User? user = await auth.currentUser;
    await googleSignIn.signOut();
    await auth.signOut();
    await helper_function.saveUserLoggedInStatus(false);
  }
}
