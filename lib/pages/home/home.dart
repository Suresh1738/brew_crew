import 'package:brew_crew/pages/home/settings_form.dart';
import 'package:brew_crew/pages/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/pages/services/database.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/pages/home/brew_list.dart';
import 'package:brew_crew/models/brew.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final  AuthService _auth =AuthService();
  @override
  Widget build(BuildContext context) {
    void showSettingsPanel(){
      //showmodalbottom shet is inbuilt
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical:20.0,horizontal:60),
          child: SettingForm(),

        );

      });
    }
    return StreamProvider<List<Brew>>.value(
        value:DatabaseService().brews,   
        child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar:AppBar(
          title:Text('Brew Crew'),
          backgroundColor: Colors.brown[400],
          centerTitle: true,
          elevation:0,
          actions: [
            FlatButton.icon(
              icon:Icon(Icons.person),
              label:Text('Logout'),
              onPressed:() async{
                await _auth.SigningOut();

              }
            ),
            FlatButton.icon(
              icon:Icon(Icons.settings),
              label:Text('settings'),
              onPressed:() =>showSettingsPanel(),
            )
          ],
        ),
        body: BrewList(),
        
      ),
    );
  }
}
