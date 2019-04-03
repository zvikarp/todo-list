import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;

  Future<FirebaseUser> loginWithGoogle() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    try {
      FirebaseUser user = await _auth.signInWithCredential(credential);
      if (user != null) {
        _user = user;
        print("loged in");
        return user;
      }
    } catch (e) {
      print(e);
      try {
        _auth.signOut();
      } catch (e) {
        print(e);
      }
      return null;
    }
    return null;
  }

  Future<String> getUid() async {
    if (_user != null)
      return _user.uid;
    else {
      await loginWithGoogle();
      if (_user != null)
        return _user.uid;
      else
        return null;
    }
  }
}

final AuthService authService = AuthService();
