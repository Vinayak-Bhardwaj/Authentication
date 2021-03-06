import 'package:authentication/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '';

class AuthService {

  GoogleSignIn _googleSignIn;
  final FirebaseAuth _auth=FirebaseAuth.instance;

  AuthService(){
    _googleSignIn = GoogleSignIn();
  }

  // create user obj based on FirebaseUser

  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(uid: user.uid):null;
  }

  //auth change user stream
  Stream<User> get user{
    return _auth.onAuthStateChanged
      //.map((FirebaseUser user) => _userFromFirebaseUser(user));
      .map(_userFromFirebaseUser); //Same Functionality
  }



  //Sign In Anonamously
  Future signInAnon() async{
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e) {
       print(e.toString());
       return null;
    }

  }
  //Sign In with email and password
  Future signInWithEmailAndPassword(String email,String password) async {
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  //register with email and password
  Future registerWithEmailAndPassword(String email,String password) async {
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // Sign In With Google
  Future<FirebaseUser> handleSignIn() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser
          .authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
      final FirebaseUser user = (await _auth.signInWithCredential(credential))
          .user;
      print("signed in " + user.displayName);
      return user;
    }catch(e){
      print(e.toString());
      return null;
    }
  }


  //sign out

  Future signOut() async{

    try{
      return await _auth.signOut();
    }catch(e){

      print(e.toString());
      return null;
    }
  }

}