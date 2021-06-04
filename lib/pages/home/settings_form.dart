import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/pages/services/database.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingForm extends StatefulWidget {
  @override
  _SettingFormState createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {
final _formKey=GlobalKey<FormState>();
final List<String> sugars=['0','1','2','3','4'];

//form values
String _CurrentName;
String _CurrentSugar;
int _CurrentStrength;


  @override
  Widget build(BuildContext context) {

    final user=Provider.of<User>(context);
//we used streambuilder we can also use provider
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid:user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          UserData userData=snapshot.data;
              return Form(
                key: _formKey,
                child: Column(
                children: [
                  Text(
                      "Update your brew setting",
                      style:TextStyle(fontSize: 18),
                  ),
                  SizedBox(height:20),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: textInputDecoration,
                    validator: (val)=>val.isEmpty?'please enter a name':null,
                    onChanged:(val)=>setState(() =>_CurrentName=val),
                  ),
                  SizedBox(height:20),
                  DropdownButtonFormField(
                    value: _CurrentSugar??userData.sugar,
                    onChanged: (val){
                      setState(()=>_CurrentSugar=val);
                    },
                    items: sugars.map((sugar){
                      return DropdownMenuItem(
                        value: sugar,
                        child:Text('$sugar sugars'),

                        );
                      }).toList(),
                  ),
                  Slider(
                    value: (_CurrentStrength ?? userData.strength).toDouble(),
                    activeColor: Colors.brown[_CurrentStrength??userData.strength],
                    inactiveColor: Colors.brown[_CurrentStrength??userData.strength],
                    min:100,
                    max: 900,
                    divisions: 8,
                    onChanged: (val)=>setState(()=>_CurrentStrength=val.round()),
                    ),
                SizedBox(height:20),
                  RaisedButton(
                    color:Colors.pink[400],
                    child:Text(
                      'update',
                      style:TextStyle(color:Colors.white),
                    ),
                    onPressed :() async{
                      if (_formKey.currentState.validate()){
                        await DatabaseService(uid: user.uid).updateUserData(
                          _CurrentSugar??userData.sugar,
                          _CurrentName??userData.name,
                          _CurrentStrength??userData.strength
                        );
                        Navigator.pop(context);
                      }
                    }
                  ),
                ],
              ),
              
            );
                

        }else{
          return Loading();


        }
       
      }
    );
  }
}