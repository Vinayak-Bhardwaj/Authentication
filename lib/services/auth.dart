import 'package:authentication/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth=FirebaseAuth.instance;

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



  //Sign In Anonomously
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

  //register with email and password

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