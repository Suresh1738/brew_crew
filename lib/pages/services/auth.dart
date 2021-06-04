import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/pages/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  //sign in anonymously
  final FirebaseAuth _auth=FirebaseAuth.instance;
  

  //creates user obj based on firebase
  User _userFromFirebaseUser(FirebaseUser user){
    return user !=null?User(uid:user.uid):null;
  }

  //aauth changes user stream
  Stream<User> get user{
    return _auth.onAuthStateChanged
    .map(_userFromFirebaseUser);
  } 

  Future signInAnon() async{
    try{
      AuthResult result=await _auth.signInAnonymously();
      FirebaseUser user=result.user;
      return _userFromFirebaseUser(user);

    }
    catch(e){
      print(e.toString());
      return null;

    }
  }
  //Register with email and password
   Future signInWithEmailAndPassword(String email ,String password) async{
    try{
      AuthResult result =await _auth.signInWithEmailAndPassword(email:email,password:password);
      FirebaseUser user =result.user;
      await DatabaseService(uid:user.uid).updateUserData('0','new member',100);
      return _userFromFirebaseUser(user);


    }catch(e){
       print(e.toString());
       return null;
    }

}

  
//Register with email and password
  Future registerWithEmailAndPassword(String email ,String password) async{
    try{
      AuthResult result =await _auth.createUserWithEmailAndPassword(email:email,password:password);
      FirebaseUser user =result.user;
      return _userFromFirebaseUser(user);


    }catch(e){
       print(e.toString());
       return null;
    }

}











  Future SigningOut() async {
    try{
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());
      return null;

    }
  }
}