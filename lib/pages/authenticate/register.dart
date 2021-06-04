import 'package:brew_crew/pages/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String email='';
  String password='';
  String error='';
  bool loading =false;
  final AuthService _auth=AuthService();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return loading?Loading():Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor:Colors.brown[400],
        elevation:0,
        title:Text("Sign Up To Brew Crew"),
        actions: [
        FlatButton.icon(
          icon:Icon(Icons.person),
            label:Text('Sign In'),
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
                 "Register",
                  style: TextStyle(color:Colors.white),
               ),
               onPressed: () async{
                if(_formkey.currentState.validate()){
                  loading=true;
                  dynamic result=await _auth.registerWithEmailAndPassword(email, password);
                  if (result==null){
                    setState((){ 
                      error='please supply a valid email ';
                      loading=false;
                    
                    });
                  }
                }
               }
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