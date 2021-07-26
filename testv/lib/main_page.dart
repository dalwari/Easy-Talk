import 'package:flutter/material.dart';
import 'package:testv/home_page.dart';
import 'package:testv/auth/auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  AuthService _auth = AuthService();
  void _navigate() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return HomePage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Scaffold(
        /*appBar: AppBar(
          title: Text('Main Page'),
          centerTitle: true,
          backgroundColor: Colors.deepPurple[400],
        ),*/
        /*body: Center(
          child: Container(
            child: TextButton(
              child: Text('Go To Home Page'),
              onPressed: () async {
                dynamic result = await _auth.signInAnon();
                if (result == null) {
                  print("SIGN ERROR");
                }
                else
                {
                  _navigate();
                }
                
              },
            ),
          ),
        ),*/
        body:Container(
          color: Colors.blue[900],
          child:Stack(
          children: [
           // Align(
              //alignment: Alignment.center,
              //child:
               Container(
               
               child:Positioned.fill(child:Image.asset('assets/images/loc.jpg',fit:BoxFit.fill,), ),
               
             ),
            //),
             //Positioned.fill(child: Image.asset('assets/images/wel1.jpg',fit:BoxFit.cover,),),
             
            
          
            
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.only(bottom: 40.0),
                height: 100,
                width: 300,
                // padding: EdgeInsets.only(top:220,bottom:220),
                child: SignInButton(
                  Buttons.GoogleDark,
                  onPressed: () async {
                    dynamic creds = await _auth.signInWithGoogle();
                    if (creds == null) {
                      print("SIGN ERROR");
                    } else {
                      _navigate();
                    }
                  },
                ),
                decoration: BoxDecoration(shape: BoxShape.circle),
              ),
            ),
            Align(
            
              alignment: Alignment.topCenter,
              
              child:Container(

                margin: EdgeInsets.only(top:50),
              //color: Colors.yellow,
              //color:Colors.blue[900],
              child: Text('Easy-Talk',style: TextStyle(fontSize: 30.0,color: Colors.blue[900],fontWeight: FontWeight.bold,fontStyle: FontStyle.normal),),
            ),
            ),
            
          ],
        ),
        ), 
        

        //),
      ),
    );
  }
}
