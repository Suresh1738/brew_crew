import 'package:brew_crew/pages/services/auth.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constants.dart';

class SignIn extends StatefulWidget {
   
   final Function toggleView;
   SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String email='';
  String password='';
  String error='';
  final AuthService _auth=AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading =false;
  @override
  Widget build(BuildContext context) {
    return loading? Loading():Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor:Colors.brown[400],
        elevation:0,
        title:Text("Sign In To Brew Crew"),
        actions: [
        FlatButton.icon(
          icon:Icon(Icons.person),
          label:Text('Register'),
          onPressed:() {
            widget.toggleView();
            }
          )

        ],
      ),
      
      body: Container(
        padding: EdgeInsets.symmetric(vertical:20,horizontal:50),
       child:Form(
         key:_formkey,
         child: Column(
           children: [
             SizedBox(height: 20),
             TextFormField(
               decoration:textInputDecoration.copyWith(hintText:'Email'),
               validator:(val)=>val.isEmpty?'Enter an email':null,
               onChanged:(val){
                 setState(() => email=val.trim());

               }
             ),
             SizedBox(height: 20),
             TextFormField(
               decoration:textInputDecoration.copyWith(hintText:'Password'),
               obscureText: true,
               validator:(val)=>val.length<6?'Enter a password of 6+ chars long':null,
               onChanged:(val){
                 setState(() => password=val);

               }
             ),
             SizedBox(height: 20),
             RaisedButton(
               color:Colors.pink[400],
               child: Text(
                 "Sign In",
                  style: TextStyle(color:Colors.white),
               ),
               onPressed: () async{
                  if(_formkey.currentState.validate()){
                    setState(() =>loading=true);
                  dynamic result=await _auth.signInWithEmailAndPassword(email, password);
                  if (result==null){
                    setState((){
                    error='Failed to sign with those credintials';
                    loading  =false;
                    });
                    
                    
                  }
                }
               },
             ),
               SizedBox(height:12),
             Text(
               error,
               style:TextStyle(
                 color:Colors.red,
                 fontSize:14),
             ),
           ],
         ),
       ),
      
    ),
    );
  }
}