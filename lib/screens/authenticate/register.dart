import 'package:authentication/services/auth.dart';
import 'package:authentication/shared/constants.dart';
import 'package:authentication/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({ this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign up'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label:Text('Sign In'),
            onPressed: () {
              widget.toggleView();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
              children:<Widget>[

                //EMAIL TEXT FIELD AND ITS FUNCTIONALITY

                SizedBox(height: 20.0),
                TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Email'),
                  validator: (val) => val.isEmpty ? 'Enter an Email' : null,
                    onChanged: (val){
                      setState(() => email = val);

                    }
                ),

                //PASSWORD TEXT FIELD AND ITS FUNCTIONALITY

                SizedBox(height: 20.0),
                TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Password'),
                    validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                    obscureText: true,
                    onChanged: (val){
                      setState(() => password = val);

                    }
                ),
                SizedBox(height: 20.0),
                Row(
                  children: <Widget>[

                    // REGISTER BUTTON AND ITS FUNCTIONALITY

                    RaisedButton(
                      color:Colors.pink[400],
                      child:Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async{
                        if(_formKey.currentState.validate()){
                          setState(() => loading = true);
                          dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                          if(result == null){
                            setState(() {
                              error = 'please supply a valid email';
                              loading = false;
                            });

                          }
                        }
                      },
                    ),

                    //GOOGLE SIGN IN BUTTON AND ITS FUNCTIONALITY

                    SizedBox(height: 20.0),
                    RaisedButton(
                      child: Text(
                        'Google Sign In',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () async{
                        dynamic result = await _auth.handleSignIn();
                        if(result == null){
                          setState(() {
                            error = 'Not Registered';
                            loading = false;
                          });
                        }
                      },
                    )
                  ],
                ),

                //DISPLAYING OF ERROR MESSAGES

                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color : Colors.red, fontSize: 14.0),
                )
              ],
          ),
        ),
      ),
    );
  }
}
